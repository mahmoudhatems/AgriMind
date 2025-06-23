// lib/features/hydroponics/presentation/widgets/tds_card.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';

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
      tdsStatus = 'Low';
    } else if (tdsValue > optimalMax) {
      currentTdsColor = ColorsManager.yellow;
      tdsStatus = 'High';
    } else {
      currentTdsColor = ColorsManager.primaryGreenColor;
      tdsStatus = 'Optimal';
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
                  getBarColor(chartSpots[i].y).withValues(alpha: 0.8),
                  getBarColor(chartSpots[i].y).withValues(alpha: 0.5),
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
                    .withValues(alpha: 0.1), // Very subtle background color
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors
            .white, // Solid white background for a clean, consistent card look
        borderRadius: BorderRadius.circular(16.r), // Uniform rounded corners
        // Subtle border using your theme's main color with low opacity
        border: Border.all(
            color: ColorsManager.mainBlueGreen.withValues(alpha: 0.1),
            width: 1),
        boxShadow: [
          // Gentle, diffused shadow for a floating "Meta/Apple" feel
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
            'TDS Level (ppm)',
            style: Styles.titlesemiBoldText24DarkfontJosefinSans.copyWith(
              color: ColorsManager.darkBlueTextColor,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 8.h),
          // Subtitle providing more context, styled from your app's typography
          Text(
            'Total Dissolved Solids in nutrient solution',
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
                    tooltipBgColor: ColorsManager.darkBlueTextColor.withValues(
                        alpha:
                            0.8), // Dark, slightly transparent tooltip background
                    tooltipPadding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    tooltipRoundedRadius: 8.r,
                    // Custom builder for tooltip content
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String timeLabel = '';
                      if (group.x == chartSpots.length - 1) {
                        timeLabel =
                            'Now'; // Label for the most recent data point
                      } else {
                        // Calculate time elapsed for historical points
                        final int hoursAgo = (chartSpots.length - 1) - group.x;
                        timeLabel = '${hoursAgo}h Ago';
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
                              color: Colors.white.withValues(alpha: 0.7),
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
                      color: ColorsManager.textIconColorGray.withValues(
                          alpha: 0.2), // Lighter, subtle horizontal grid lines
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
                            child: Text('Now',
                                style: Styles
                                    .styleNormalText14GrayfontJosefinSans
                                    .copyWith(fontSize: 10.sp)),
                          );
                        } else {
                          final int hoursAgo = (chartSpots.length - 1) - index;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('${hoursAgo}h Ago',
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
                        color: ColorsManager.textIconColorGray
                            .withValues(alpha: 0.4),
                        width: 0.8),
                    left: BorderSide(
                        color: ColorsManager.textIconColorGray
                            .withValues(alpha: 0.4),
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
                      color: ColorsManager.gold.withValues(
                          alpha: 0.6), // Gold for the minimum optimal line
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
                            'Min Optimal (${line.y.toInt()})', // Concise label
                      ),
                    ),
                    HorizontalLine(
                      y: optimalMax,
                      color: ColorsManager.primaryGreenColor.withValues(
                          alpha: 0.6), // Green for the maximum optimal line
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
                            'Max Optimal (${line.y.toInt()})', // Concise label
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
                    color: currentTdsColor.withValues(alpha: 0.5), width: 1.2),
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
                    'Current: ${tdsValue.toStringAsFixed(0)} ppm ($tdsStatus)',
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
