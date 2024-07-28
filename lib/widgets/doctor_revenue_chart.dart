import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DoctorRevenueChart extends StatelessWidget {
  final String doctorName;
  final List<FlSpot> dataPoints;

  DoctorRevenueChart({required this.doctorName, required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Biểu đồ doanh thu theo bác sĩ: $doctorName'),
      content: Container(
        width: double.maxFinite,
        height: 300,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: dataPoints,
                isCurved: true,
                barWidth: 2,
                color: Colors.blue,
                belowBarData: BarAreaData(show: false),
                dotData: FlDotData(show: true),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Đóng'),
        ),
      ],
    );
  }
}
