import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';

class GreenhousePage extends StatefulWidget {
  const GreenhousePage({Key? key}) : super(key: key);
  
  @override
  State createState() => _GreenhousePageState();
}

class _GreenhousePageState extends State with SingleTickerProviderStateMixin {
  late AnimationController _fanController;
  double temperature = 26.5;
  double humidity = 55.0;
  double soilMoisture = 72.0;
  
  bool isDoorOpen = false;
  bool isFanOn = false;
  bool isPumpOn = false;
  bool isHeaterOn = false;
  
  List<Map<String, String>> logs = [
    {"time": "10:00 AM", "message": "System initialized"},
    {"time": "10:05 AM", "message": "Optimal conditions reached"},
    {"time": "10:10 AM", "message": "Fan activated"},
    {"time": "10:15 AM", "message": "Water pump activated"},
    {"time": "10:20 AM", "message": "Heater activated"},
  ];
  
  @override
  void initState() {
    super.initState();
    _fanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }
  
  void _toggleDevice(String device) {
  setState(() {
    // Handle both full titles and partial matches
    if (device == 'Door') {
      isDoorOpen = !isDoorOpen;
    } else if (device == 'Fan') {
      isFanOn = !isFanOn;
      if (isFanOn) {
        _fanController.repeat();
      } else {
        _fanController.stop();
      }
    } else if (device.contains('Pump') || device == 'Pump') {
      isPumpOn = !isPumpOn;
    } else if (device == 'Heater') {
      isHeaterOn = !isHeaterOn;
    }
    _addLog(device);
  });
}
  
  void _addLog(String device) {
    logs.insert(0, {
      "time": "${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}",
      "message": "$device ${_getStatus(device) ? 'activated' : 'deactivated'}"
    });
  }
  
  bool _getStatus(String device) {
    switch (device) {
      case 'Door':
        return isDoorOpen;
      case 'Fan':
        return isFanOn;
      case 'Pump':
        return isPumpOn;
      case 'Heater':
        return isHeaterOn;
      default:
        return false;
    }
  }
  
  @override
  void dispose() {
    _fanController.dispose();
    super.dispose();
  }
  
  Widget _buildStatusSummary() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorsManager.mainGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatusItem('Temperature', '$temperature°C', 
              temperature > 28 ? Colors.red : ColorsManager.mainGreen),
          _buildStatusItem('Humidity', '$humidity%', 
              humidity < 40 ? Colors.orange : ColorsManager.mainGreen),
          _buildStatusItem('Soil', '$soilMoisture%', 
              soilMoisture < 60 ? Colors.orange : ColorsManager.mainGreen),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 14.sp, color: Colors.black54)),
        SizedBox(height: 4.h),
        Text(value, 
            style: TextStyle(
              fontSize: 18.sp, 
              fontWeight: FontWeight.bold,
              color: color,
            )),
      ],
    );
  }

 Widget _buildEnvironmentalGrid() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Environmental Controls',
          style: Styles.styleBoldText18ButomfontJosefinSans),
      SizedBox(height: 12.h),
      LayoutBuilder(
        builder: (context, constraints) {
          // Calculate the height needed for 2 rows with the given aspect ratio
          // Each row height = item width / aspect ratio
          final itemWidth = (constraints.maxWidth - 16.w) / 2;
          final itemHeight = itemWidth / 1.5; // Using your aspect ratio of 1.5
          final gridHeight = itemHeight * 2 + 50.h; // 2 rows + spacing
          
          return SizedBox(
            height: gridHeight,
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,

              children: [
                _buildControlCard('Door', Icons.meeting_room_outlined, isDoorOpen),
                _buildControlCard('Fan', Icons.air_outlined, isFanOn),
                _buildControlCard('Pump', Icons.water_drop_outlined, isPumpOn),
                _buildControlCard('Heater', Icons.local_fire_department_outlined, isHeaterOn),
              ],
            ),
          );
        }
      ),
    ],
  );
}

  Widget _buildControlCard(String title, IconData icon, bool isActive) {
    return GestureDetector(
      onTap: () => _toggleDevice(title.split(' ')[0]),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isActive ? ColorsManager.mainGreen.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isActive ? ColorsManager.mainGreen : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32.r,
              color: isActive ? ColorsManager.mainGreen : Colors.grey,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: isActive ? ColorsManager.mainGreen : Colors.black54,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              isActive ? 'ON' : 'OFF',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: isActive ? ColorsManager.mainGreen : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendChart() {
    return Container(
      height: 200.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Daily Trends', style: Styles.styleBoldText18ButomfontJosefinSans),
              Row(
                children: [
                  _buildLegendItem('Temperature', Colors.red),
                  SizedBox(width: 8.w),
                  _buildLegendItem('Humidity', Colors.blue),
                  SizedBox(width: 8.w),
                  _buildLegendItem('Soil', Colors.brown),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 5,
                minY: 0,
                maxY: 100,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 20,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final hours = ['8AM', '10AM', '12PM', '2PM', '4PM', '6PM'];
                        if (value >= 0 && value < hours.length) {
                          return Text(
                            hours[value.toInt()],
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 10.sp,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 10.sp,
                          ),
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                lineBarsData: [
                  // Temperature line (scaled down to fit the chart)
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 25),
                      FlSpot(1, 26),
                      FlSpot(2, 27),
                      FlSpot(3, 25.5),
                      FlSpot(4, 26.5),
                      FlSpot(5, 26),
                    ],
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 3,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.red.withOpacity(0.1),
                    ),
                  ),
                  // Humidity line
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 50),
                      FlSpot(1, 54),
                      FlSpot(2, 52),
                      FlSpot(3, 58),
                      FlSpot(4, 55),
                      FlSpot(5, 53),
                    ],
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.blue.withOpacity(0.1),
                    ),
                  ),
                  // Soil moisture line
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 70),
                      FlSpot(1, 68),
                      FlSpot(2, 65),
                      FlSpot(3, 75),
                      FlSpot(4, 72),
                      FlSpot(5, 70),
                    ],
                    isCurved: true,
                    color: Colors.brown,
                    barWidth: 3,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.brown.withOpacity(0.1),
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

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12.r,
          height: 12.r,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildControlPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Controls', style:Styles.styleBoldText18ButomfontJosefinSans),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildQuickControlButton('Auto', Icons.auto_mode, false),
              _buildQuickControlButton('Refresh', Icons.refresh, false),
              _buildQuickControlButton('Water Now', Icons.water, false),
              _buildQuickControlButton('Settings', Icons.settings, false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickControlButton(String label, IconData icon, bool isActive) {
    return GestureDetector(
      onTap: () {
        // Implement quick control actions here
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: isActive ? ColorsManager.mainGreen : Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.black54,
              size: 24.r,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemLogs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('System Logs', style: Styles.styleBoldText18ButomfontJosefinSans),
        SizedBox(height: 12.h),
        Container(
          height: 150.h,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    Text(
                      logs[index]["time"] ?? "",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        logs[index]["message"] ?? "",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusSummary(),
          SizedBox(height: 20.h),
          _buildEnvironmentalGrid(),
          SizedBox(height: 20.h),
          _buildTrendChart(),
          SizedBox(height: 20.h),
          _buildControlPanel(),
          SizedBox(height: 20.h),
          _buildSystemLogs(),
        ],
      )
    );
  }
}