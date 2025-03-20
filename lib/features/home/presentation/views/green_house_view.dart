import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

class GreenhousePage extends StatefulWidget {
  const GreenhousePage({Key? key}) : super(key: key);

  @override
  State<GreenhousePage> createState() => _GreenhousePageState();
}

class _GreenhousePageState extends State<GreenhousePage> with SingleTickerProviderStateMixin {
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
      switch (device) {
        case 'Door':
          isDoorOpen = !isDoorOpen;
          break;
        case 'Fan':
          isFanOn = !isFanOn;
          if (isFanOn) {
            _fanController.repeat();
          } else {
            _fanController.stop();
          }
          break;
        case 'Pump':
          isPumpOn = !isPumpOn;
          break;
        case 'Heater':
          isHeaterOn = !isHeaterOn;
          break;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEnvironmentalGrid(),
            SizedBox(height: 20.h),
            _buildTrendChart(),
            SizedBox(height: 20.h),
            _buildControlPanel(),
            SizedBox(height: 20.h),
            _buildSystemLogs(),
          ],
        ),
      ),
    );
  }

  Widget _buildEnvironmentalGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 0.8,
      children: [
        _buildMetricCard('Temperature', '${temperature.toStringAsFixed(1)}°C', 
            Icons.thermostat, Colors.red),
        _buildMetricCard('Humidity', '${humidity.toStringAsFixed(0)}%', 
            Icons.water_drop, Colors.blue),
        _buildMetricCard('Soil Moisture', '${soilMoisture.toStringAsFixed(0)}%', 
            Icons.grass, Colors.green),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32.w, color: color),
            SizedBox(height: 8.h),
            Text(title, style: TextStyle(
                fontSize: 14.sp, 
                fontWeight: FontWeight.w500)),
            SizedBox(height: 4.h),
            Text(value, style: TextStyle(
                fontSize: 18.sp, 
                fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendChart() {
    final chartData = _getChartData();
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Environmental Trends", style: TextStyle(
                fontSize: 18.sp, 
                fontWeight: FontWeight.bold)),
            SizedBox(height: 12.h),
            Container(
              height: 200.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: _bottomTitles(chartData),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40.w,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}°C',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40.w,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}%',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: chartData.map((data) => FlSpot(
                        data.time.millisecondsSinceEpoch.toDouble(),
                        data.temperature,
                      )).toList(),
                      color: Colors.red,
                      barWidth: 2,
                      isCurved: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      spots: chartData.map((data) => FlSpot(
                        data.time.millisecondsSinceEpoch.toDouble(),
                        data.humidity,
                      )).toList(),
                      color: Colors.blue,
                      barWidth: 2,
                      isCurved: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  minX: chartData.first.time.millisecondsSinceEpoch.toDouble(),
                  maxX: chartData.last.time.millisecondsSinceEpoch.toDouble(),
                  minY: 0,
                  maxY: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SideTitles _bottomTitles(List<EnvironmentalData> data) {
    return SideTitles(
      showTitles: true,
      reservedSize: 24.h,
      getTitlesWidget: (value, meta) {
        final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
        return Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Text(
            '${date.hour}:00',
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey[600],
            ),
          ),
        );
      },
    );
  }

  List<EnvironmentalData> _getChartData() => [
    EnvironmentalData(DateTime(2023, 1, 1, 8), 22, 60),
    EnvironmentalData(DateTime(2023, 1, 1, 10), 25, 58),
    EnvironmentalData(DateTime(2023, 1, 1, 12), 28, 55),
    EnvironmentalData(DateTime(2023, 1, 1, 14), 26, 57),
    EnvironmentalData(DateTime(2023, 1, 1, 16), 24, 62),
  ];
  
Widget _buildControlPanel() {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    child: Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Device Controls",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 16.w,
            runSpacing: 16.h,
            alignment: WrapAlignment.center,
            children: [
              _buildControlButton(Icons.door_front_door_outlined, 'Door', isDoorOpen),
              _buildControlButton(Icons.toys_outlined, 'Fan', isFanOn),
              _buildControlButton(Icons.invert_colors_outlined, 'Pump', isPumpOn),
              _buildControlButton(Icons.heat_pump_outlined, 'Heater', isHeaterOn),
            ],
          ),
        ],
      ),
    ),
  );
}
  Widget _buildControlButton(IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () => _toggleDevice(label),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isActive ? Colors.blue[50] : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: RotationTransition(
              turns: label == 'Fan' && isActive 
                  ? Tween(begin: 0.0, end: 1.0).animate(_fanController)
                  : AlwaysStoppedAnimation(0.0),
              child: Icon(icon, size: 28.w, 
                  color: isActive ? Colors.blue : Colors.grey),
            ),
          ),
          SizedBox(height: 8.h),
          Text(label, style: TextStyle(
              fontSize: 12.sp,
              color: isActive ? Colors.blue : Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSystemLogs() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("System Logs", style: TextStyle(
                    fontSize: 18.sp, 
                    fontWeight: FontWeight.bold)),
                Icon(Icons.history, size: 24.w),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              height: 150.h,
              child: ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Text(logs[index]['time']!, 
                      style: TextStyle(fontSize: 12.sp)),
                  title: Text(logs[index]['message']!,
                      style: TextStyle(fontSize: 14.sp)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EnvironmentalData {
  final DateTime time;
  final double temperature;
  final double humidity;

  EnvironmentalData(this.time, this.temperature, this.humidity);
}