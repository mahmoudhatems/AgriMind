import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/features/greenhouse/presentation/manager/greenhouse_cubit.dart';
import 'package:happyfarm/features/greenhouse/presentation/widgets/environmental_sensors.dart';
import 'package:happyfarm/features/greenhouse/presentation/widgets/widgets/device_controls.dart';
import 'package:happyfarm/features/home/presentation/widgets/tip_card.dart';

class GreenhouseScreen extends StatefulWidget {
  const GreenhouseScreen({super.key});

  @override
  State<GreenhouseScreen> createState() => _GreenhouseScreenState();
}

class _GreenhouseScreenState extends State<GreenhouseScreen> {
  final _fanSwitch = ValueNotifier(false);
  final _pumpSwitch = ValueNotifier(false);

  int _tipIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<GreenhouseCubit>().fetchGreenhouseData();

    _fanSwitch.addListener(() {
      context.read<GreenhouseCubit>().toggleFan(_fanSwitch.value);
      HapticFeedback.lightImpact();
    });

    _pumpSwitch.addListener(() {
      context.read<GreenhouseCubit>().togglePump(_pumpSwitch.value);
      HapticFeedback.lightImpact();
    });

    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  void _rotateTip() {
    if (!mounted) return;
    setState(() => _tipIndex = (_tipIndex + 1) % StringManager.homeTips.length);
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GreenhouseCubit, GreenhouseState>(
      builder: (context, state) {
        if (state is GreenhouseLoaded) {
          final data = state.data;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _fanSwitch.value = data.fanStatus;
            _pumpSwitch.value = data.pumpStatus;
          });

          return RefreshIndicator(
            onRefresh: () async {
              context.read<GreenhouseCubit>().fetchGreenhouseData();
              HapticFeedback.lightImpact();
              await Future.delayed(const Duration(milliseconds: 600));
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                children: [
                  SensorSection(data: data),
                  SizedBox(height: 20.h),
                  DeviceControls(
                    fanController: _fanSwitch,
                    pumpController: _pumpSwitch,
                  ),
                  SizedBox(height: 20.h),
                  TipCard(
                    text: StringManager.homeTips[_tipIndex],
                    key: ValueKey(_tipIndex),
                  ),
                ],
              ),
            ),
          );
        } else if (state is GreenhouseError) {
          return Center(
            child: Text(state.message, style: TextStyle(color: Colors.red)),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
