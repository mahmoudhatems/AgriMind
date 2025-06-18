import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:lottie/lottie.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    Key? key,
    required this.zoneName,
    required this.status,
    required this.lastUpdate,
  }) : super(key: key);

  final String zoneName;
  final String status;
  final String lastUpdate;

  bool get isOnline => status.toLowerCase() == 'online';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        final cardPadding = isTablet ? 24.r : 20.r;
        final iconSize = isTablet ? 100.r : 80.r;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                isOnline ? ColorsManager.mainBlueGreen : Colors.redAccent,
                isOnline
                    ? ColorsManager.mainBlueGreen.withValues( alpha:  0.7)
                    : Colors.redAccent.withValues( alpha:  0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.tileBackground.withValues( alpha:  0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
                spreadRadius: 0,
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: isTablet ? 3 : 2,
                  child: _buildStatusInfo(isTablet),
                ),
                SizedBox(width: isTablet ? 20.w : 16.w),
                _buildStatusIcon(iconSize),
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            )
            .slideY(
              begin: -0.2,
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            );
      },
    );
  }

  Widget _buildStatusInfo(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// 👇 الهيدر الثابت هنا
        Text(
          zoneName,
          style: TextStyle(
            color: Colors.white,
            fontSize: isTablet ? 22.sp : 18.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: isTablet ? 8.h : 6.h),

        _buildStatusIndicator(isTablet),

        SizedBox(height: isTablet ? 12.h : 8.h),
        Text(
          "Last updated: $lastUpdate",
          style: TextStyle(
            color: ColorsManager.realWhiteColor.withValues( alpha:  0.8),
            fontSize: isTablet ? 13.sp : 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(bool isTablet) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isTablet ? 10.r : 8.r,
          height: isTablet ? 10.r : 8.r,
          decoration: BoxDecoration(
            color: isOnline ? Colors.greenAccent : Colors.redAccent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: (isOnline ? Colors.greenAccent : Colors.redAccent)
                    .withValues( alpha:  0.6),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
        )
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .scale(
              begin: const Offset(1.0, 1.0),
              end: const Offset(1.2, 1.2),
              duration: 1500.ms,
              curve: Curves.easeInOut,
            )
            .then()
            .scale(
              begin: const Offset(1.2, 1.2),
              end: const Offset(1.0, 1.0),
              duration: 1500.ms,
              curve: Curves.easeInOut,
            ),
        SizedBox(width: isTablet ? 10.w : 8.w),
        Text(
          isOnline ? "Zone is Online" : "Zone is Offline",
          style: TextStyle(
            color: Colors.white,
            fontSize: isTablet ? 16.sp : 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIcon(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: ColorsManager.realWhiteColor.withValues( alpha:  0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorsManager.realWhiteColor.withValues( alpha:  0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Lottie.asset(
          StringManager.dashboardLottie,
          repeat: true,
          reverse: false,
          animate: true,
          frameRate: FrameRate.composition,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.dashboard_rounded,
            color: ColorsManager.realWhiteColor.withValues( alpha:  0.8),
            size: size * 0.4,
          ),
        ),
      ),
    );
  }
}
