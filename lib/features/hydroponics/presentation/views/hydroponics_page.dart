// lib/features/hydroponics/presentation/pages/hydroponics_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/features/home/presentation/widgets/tip_card.dart'; // Ensure this path is correct for your project
import 'package:happyfarm/features/hydroponics/presentation/manager/hydroponics_cubit.dart';
import 'package:happyfarm/features/hydroponics/presentation/widgets/hydro_device_controls.dart'; // Ensure this path is correct for your project
import 'package:happyfarm/features/hydroponics/presentation/widgets/hydro_sensor_section.dart'; // Ensure this path is correct for your project
import 'package:happyfarm/features/hydroponics/presentation/widgets/tds_card.dart'; // Import the new TDS card

class HydroponicsPage extends StatefulWidget {
  const HydroponicsPage({super.key});

  @override
  State<HydroponicsPage> createState() => _HydroponicsPageState();
}

class _HydroponicsPageState extends State<HydroponicsPage> {
  final _pumpSwitch = ValueNotifier(false);
  int _tipIndex = 0;

  final List<String> _tips = [
    "Ensure the pH level stays between 5.5 - 6.5 for optimal plant health.",
    "Clean and check pump filters weekly to avoid clogs.",
    "Keep water temperature between 18°C - 24°C.",
    "Low water level may damage roots, refill when below 25%.",
    "Use sensors to automate nutrient control and lighting.",
    "Maintain TDS levels between 800-1200 ppm for optimal nutrient absorption."
  ];

  @override
  void initState() {
    super.initState();
    // Start fetching hydroponics data in real-time
    context.read<HydroponicsCubit>().fetchHydroData();

    // Listen to pump switch changes to update Firebase
    _pumpSwitch.addListener(() {
      context.read<HydroponicsCubit>().togglePump(_pumpSwitch.value);
      HapticFeedback.lightImpact(); // Provide haptic feedback on toggle
    });

    // Start rotating tips after an initial delay
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  /// Rotates the displayed tip card periodically.
  void _rotateTip() {
    if (!mounted) return; // Ensure widget is still in the tree
    setState(() => _tipIndex = (_tipIndex + 1) % _tips.length);
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  @override
  void dispose() {
    _pumpSwitch.dispose(); // Dispose the ValueNotifier to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HydroponicsCubit, HydroponicsState>(
      builder: (context, state) {
        if (state is HydroponicsLoaded) {
          final data = state.data;
          final historicalTds = state.historicalTds; // Get the historical TDS data from the state

          // Ensure the pump switch reflects the actual pump status from data
          // This is important because the pump status might change from external sources
          // or be updated by Firebase after a toggle.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pumpSwitch.value != data.pumpStatus) {
              _pumpSwitch.value = data.pumpStatus;
            }
          });

          return RefreshIndicator(
            onRefresh: () async {
              // Re-fetching data (re-subscribing to stream) on pull-to-refresh.
              // In a perfectly stable real-time system, this might not be strictly
              // necessary for data updates, but it's good for robustness or
              // to re-establish connection if needed.
              context.read<HydroponicsCubit>().fetchHydroData();
              HapticFeedback.lightImpact(); // Haptic feedback on refresh
              await Future.delayed(const Duration(milliseconds: 600)); // Simulate refresh duration
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                children: [
                  HydroSensorSection(data: data),
                  SizedBox(height: 20.h),
                  // Pass the fetched historical TDS data to TDSCard for plotting
                  TDSCard(tdsValue: data.tds, historicalTdsData: historicalTds),
                  SizedBox(height: 20.h),
                  HydroDeviceControls(pumpController: _pumpSwitch),
                  SizedBox(height: 20.h),
                  TipCard(text: _tips[_tipIndex], key: ValueKey(_tipIndex)),
                ],
              ),
            ),
          );
        } else if (state is HydroponicsError) {
          // Display error message if data fetching fails
          return Center(
            child: Text(state.message, style: TextStyle(color: Colors.red)),
          );
        }

        // Show a loading indicator when the data is being fetched initially or refreshed
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}