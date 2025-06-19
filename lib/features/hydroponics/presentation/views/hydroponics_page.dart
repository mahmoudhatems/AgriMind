import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/features/home/presentation/widgets/tip_card.dart';
import 'package:happyfarm/features/hydroponics/presentation/manager/hydroponics_cubit.dart';
import 'package:happyfarm/features/hydroponics/presentation/widgets/hydro_device_controls.dart';
import 'package:happyfarm/features/hydroponics/presentation/widgets/hydro_sensor_section.dart';

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
  ];

  @override
  void initState() {
    super.initState();
    context.read<HydroponicsCubit>().fetchHydroData();

    _pumpSwitch.addListener(() {
      context.read<HydroponicsCubit>().togglePump(_pumpSwitch.value);
      HapticFeedback.lightImpact();
    });

    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  void _rotateTip() {
    if (!mounted) return;
    setState(() => _tipIndex = (_tipIndex + 1) % _tips.length);
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HydroponicsCubit, HydroponicsState>(
      builder: (context, state) {
        if (state is HydroponicsLoaded) {
          final data = state.data;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pumpSwitch.value != data.pumpStatus) {
              _pumpSwitch.value = data.pumpStatus;
            }
          });

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HydroponicsCubit>().fetchHydroData();
              HapticFeedback.lightImpact();
              await Future.delayed(const Duration(milliseconds: 600));
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                children: [
                  HydroSensorSection(data: data),
                  SizedBox(height: 20.h),
                  HydroDeviceControls(pumpController: _pumpSwitch),
                  SizedBox(height: 20.h),
                  TipCard(text: _tips[_tipIndex], key: ValueKey(_tipIndex)),
                ],
              ),
            ),
          );
        } else if (state is HydroponicsError) {
          return Center(
            child: Text(state.message, style: TextStyle(color: Colors.red)),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
