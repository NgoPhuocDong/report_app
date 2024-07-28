import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DoctorRevenueChart extends StatelessWidget {
  final String tenBacSi;
  final List<FlSpot> duLieu;

  DoctorRevenueChart({required this.tenBacSi, required this.duLieu});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.90, // Điều chỉnh chiều rộng của AlertDialog
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(tenBacSi, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: duLieu,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.3),
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 1:
                              return Text('T2');
                            case 2:
                              return Text('T3');
                            case 3:
                              return Text('T4');
                            case 4:
                              return Text('T5');
                            case 5:
                              return Text('T6');
                          }
                          return Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value % 10000000 == 0) {
                            return Text((value / 1000000).toStringAsFixed(0) + 'M');
                          }
                          return Text('');
                        },
                        reservedSize: 40, // Thêm dòng này để cung cấp thêm không gian cho các nhãn
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Đóng',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
