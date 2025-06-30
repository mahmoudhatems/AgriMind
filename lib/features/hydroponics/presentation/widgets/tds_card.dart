import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:easy_localization/easy_localization.dart'; // Import for .tr()
import 'package:happyfarm/core/utils/strings.dart'; // Import StringManager

class TDSCard extends StatelessWidget {
  final double tdsValue;

  final List<FlSpot> historicalTdsData;

  const TDSCard({
    super.key,
    required this.tdsValue,
    this.historicalTdsData = const [],
  });

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> chartSpots = historicalTdsData;

    const double optimalMin = 800;
    const double optimalMax = 1200;

    Color currentTdsColor;
    String tdsStatus;
    if (tdsValue < optimalMin) {
      currentTdsColor = ColorsManager.errorColor;
      tdsStatus = 'Low'; // Will be localized
    } else if (tdsValue > optimalMax) {
      currentTdsColor = ColorsManager.yellow;
      tdsStatus = 'High'; // Will be localized
    } else {
      currentTdsColor = ColorsManager.primaryGreenColor;
      tdsStatus = 'Optimal'; // Will be localized
    }

    Color getBarColor(double value) {
      if (value < optimalMin) {
        return ColorsManager.errorColor;
      } else if (value > optimalMax) {
        return ColorsManager.yellow;
      } else {
        return ColorsManager.primaryGreenColor;
      }
    }

    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < chartSpots.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: chartSpots[i].y,
              gradient: LinearGradient(
                colors: [
                  getBarColor(chartSpots[i].y).withOpacity(0.8), // Corrected
                  getBarColor(chartSpots[i].y).withOpacity(0.5), // Corrected
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              width: 20.w,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.r),
                topRight: Radius.circular(6.r),
              ),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 1500,
                color: ColorsManager.textIconColorGray
                    .withOpacity(0.1), // Corrected
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
            color: ColorsManager.mainBlueGreen.withOpacity(0.1), // Corrected
            width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03), // Corrected
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title for the card, styled with your app's typography
          Text(
            StringManager.tdsLevelPpm.tr(), // Localized
            style: Styles.titlesemiBoldText24DarkfontJosefinSans.copyWith(
              color: ColorsManager.darkBlueTextColor,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 8.h),
          // Subtitle providing more context, styled from your app's typography
          Text(
            StringManager.totalDissolvedSolids.tr(), // Localized
            style: Styles.styleNormalText14GrayfontJosefinSans.copyWith(
              color: ColorsManager.textIconColorGray,
            ),
          ),
          SizedBox(height: 20.h),
          // AspectRatio to control the chart's size proportionally
          AspectRatio(
            aspectRatio: 1.8,
            child: BarChart(
              BarChartData(
                maxY: 1500, // Maximum value for the Y-axis
                barGroups: barGroups, // The data for the bar chart
                // Controls the alignment and spacing of bar groups on the X-axis
                alignment: BarChartAlignment.spaceAround,
                groupsSpace: 20.w, // Space between groups of bars

                // Configuration for touch interactions and tooltips on bars
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: ColorsManager.darkBlueTextColor.withOpacity(0.8), // Corrected
                    tooltipPadding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    tooltipRoundedRadius: 8.r,
                    // Custom builder for tooltip content
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String timeLabel = '';
                      if (group.x == chartSpots.length - 1) {
                        timeLabel = StringManager.now.tr(); // Localized
                      } else {
                        // Calculate time elapsed for historical points
                        final int hoursAgo = (chartSpots.length - 1) - group.x;
                        timeLabel = '$hoursAgo${'h Ago'.tr()}'; // Localize "h Ago"
                      }
                      return BarTooltipItem(
                        '${rod.toY.toStringAsFixed(0)} ppm\n', // Display TDS value without decimals
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: timeLabel, // Display time label below value
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7), // Corrected
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  // Callback for touch events (can be used for custom highlights)
                  touchCallback:
                      (FlTouchEvent event, BarTouchResponse? response) {
                    // No specific action implemented here, but available for interactivity.
                  },
                ),

                // Configuration for the grid lines
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine:
                      false, // No vertical grid lines for a cleaner look
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: ColorsManager.textIconColorGray.withOpacity(0.2), // Corrected
                      strokeWidth: 0.6,
                      dashArray: [
                        4,
                        4
                      ], // Dashed lines for a modern, less intrusive feel
                    );
                  },
                ),

                // Configuration for axis titles and labels
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        final int index = value.toInt();
                        if (chartSpots.isEmpty ||
                            index < 0 ||
                            index >= chartSpots.length) {
                          return const Text('');
                        }
                        if (index == chartSpots.length - 1) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(StringManager.now.tr(), // Localized
                                style: Styles
                                    .styleNormalText14GrayfontJosefinSans
                                    .copyWith(fontSize: 10.sp)),
                          );
                        } else {
                          final int hoursAgo = (chartSpots.length - 1) - index;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('$hoursAgo${'h Ago'.tr()}', // Localized "h Ago"
                                style: Styles
                                    .styleNormalText14GrayfontJosefinSans
                                    .copyWith(fontSize: 10.sp)),
                          );
                        }
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value == 0 || value % 200 == 0) {
                          return Text('${value.toInt()}',
                              style: Styles.styleNormalText14GrayfontJosefinSans
                                  .copyWith(fontSize: 10.sp));
                        }
                        return const Text('');
                      },
                      reservedSize: 40,
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),

                // Configuration for the chart borders
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(
                        color: ColorsManager.textIconColorGray.withOpacity(0.4), // Corrected
                        width: 0.8),
                    left: BorderSide(
                        color: ColorsManager.textIconColorGray.withOpacity(0.4), // Corrected
                        width: 0.8),
                    right: BorderSide.none,
                    top: BorderSide.none,
                  ),
                ),

                // Add horizontal lines to indicate optimal TDS ranges
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: optimalMin,
                      color: ColorsManager.gold.withOpacity(0.6), // Corrected
                      strokeWidth: 1.2,
                      dashArray: [5, 5],
                      label: HorizontalLineLabel(
                        show: true,
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.only(right: 8.w, bottom: 4.h),
                        style: Styles.styleNormalText14GrayfontJosefinSans
                            .copyWith(
                              fontSize: 9.sp,
                              color: ColorsManager.gold,
                            ),
                        labelResolver: (line) =>
                            '${StringManager.minOptimal.tr()} (${line.y.toInt()})', // Localized
                      ),
                    ),
                    HorizontalLine(
                      y: optimalMax,
                      color: ColorsManager.primaryGreenColor.withOpacity(0.6), // Corrected
                      strokeWidth: 1.2,
                      dashArray: [5, 5],
                      label: HorizontalLineLabel(
                        show: true,
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.only(right: 8.w, top: 4.h),
                        style: Styles.styleNormalText14GrayfontJosefinSans
                            .copyWith(
                              fontSize: 9.sp,
                              color: ColorsManager.primaryGreenColor,
                            ),
                        labelResolver: (line) =>
                            '${StringManager.maxOptimal.tr()} (${line.y.toInt()})', // Localized
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          // Current TDS value display with status indicator
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                // Border color indicates the status (low, optimal, high)
                border: Border.all(
                    color: currentTdsColor.withOpacity(0.5), width: 1.2), // Corrected
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Wrap content tightly
                children: [
                  Icon(
                    tdsStatus == 'Optimal'
                        ? Icons.check_circle_rounded
                        : Icons.warning_rounded,
                    color: currentTdsColor,
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    // Translate status
                    'Current: ${tdsValue.toStringAsFixed(0)} ppm (${tdsStatus.tr()})', // Localized status
                    style: Styles.styleBoldText16ButomfontJosefinSans.copyWith(
                      color: currentTdsColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}