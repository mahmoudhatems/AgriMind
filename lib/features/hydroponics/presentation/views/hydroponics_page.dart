import 'package:easy_localization/easy_localization.dart'; // Import this
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/features/home/presentation/widgets/tip_card.dart';
import 'package:happyfarm/features/hydroponics/presentation/manager/hydroponics_cubit.dart';
import 'package:happyfarm/features/hydroponics/presentation/widgets/hydro_device_controls.dart';
import 'package:happyfarm/features/hydroponics/presentation/widgets/hydro_sensor_section.dart';
import 'package:happyfarm/features/hydroponics/presentation/widgets/tds_card.dart';

class HydroponicsPage extends StatefulWidget {
  const HydroponicsPage({super.key});

  @override
  State<HydroponicsPage> createState() => _HydroponicsPageState();
}

class _HydroponicsPageState extends State<HydroponicsPage> {
  final _pumpSwitch = ValueNotifier(false);
  int _tipIndex = 0;

  @override
  void initState() {
    super.initState();

    context.read<HydroponicsCubit>().fetchHydroData(context);

    _pumpSwitch.addListener(() {
      context.read<HydroponicsCubit>().togglePump(_pumpSwitch.value);
      HapticFeedback.lightImpact();
    });

    // Initial call to start tip rotation
    _rotateTip();
  }

  void _rotateTip() {
    if (!mounted) return;
    setState(() => _tipIndex = (_tipIndex + 1) % StringManager.hydroponicsTips.length);
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  @override
  void dispose() {
    _pumpSwitch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HydroponicsCubit, HydroponicsState>(
      builder: (context, state) {
        if (state is HydroponicsLoaded) {
          final data = state.data;
          final historicalTds = state.historicalTds;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pumpSwitch.value != data.pumpStatus) {
              _pumpSwitch.value = data.pumpStatus;
            }
          });

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HydroponicsCubit>().fetchHydroData(context);
              HapticFeedback.lightImpact();
              await Future.delayed(const Duration(milliseconds: 600));
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                children: [
                  HydroSensorSection(data: data), // HydroSensorSection will be updated below
                  SizedBox(height: 20.h),
                  TDSCard( // TDSCard will be updated below
                    tdsValue: data.tds,
                    historicalTdsData: historicalTds,
                  ),
                  SizedBox(height: 20.h),
                  HydroDeviceControls(pumpController: _pumpSwitch), // HydroDeviceControls will be updated below
                  SizedBox(height: 20.h),
                  TipCard(
                    text: StringManager.hydroponicsTips[_tipIndex].tr(), // Localized tip
                    key: ValueKey(_tipIndex),
                  ),
                ],
              ),
            ),
          );
        } else if (state is HydroponicsError) {
          return Center(
            child: Text(state.message, style: TextStyle(color: Colors.red)), // Consider localizing error messages too
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}