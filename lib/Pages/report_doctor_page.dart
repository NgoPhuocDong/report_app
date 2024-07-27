import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/ReportDoctorModel.dart';

class ReportDoctorPage extends StatefulWidget {
  @override
  _ReportDoctorPageState createState() => _ReportDoctorPageState();
}

class _ReportDoctorPageState extends State<ReportDoctorPage> {
  List<DoanhThu> reportData = [];

  @override
  void initState() {
    super.initState();
    fetchReportData();
  }

  Future<void> fetchReportData() async {
    final response = await http.get(Uri.parse('https://apishpt.doctorsaigon.net/api/v2/his/DataTest'));

    if (response.statusCode == 200) {
      print(response.body); // In ra dữ liệu để kiểm tra cấu trúc

      final jsonResponse = jsonDecode(response.body);
      final body = jsonResponse['body'];

      // Chuyển đổi chuỗi JSON thành đối tượng Map
      final decodedBody = jsonDecode(body);

      // Kiểm tra xem 'obdata' có phải là null không
      final obdataString = decodedBody['obdata'];
      if (obdataString != null) {
        final obdataJson = jsonDecode(obdataString); // Parse chuỗi JSON bên trong obdata
        final dsdoanhthutheobs = jsonDecode(obdataJson['dsdoanhthutheobs']);

        if (dsdoanhthutheobs != null) {
          setState(() {
            reportData = List<DoanhThu>.from(
                dsdoanhthutheobs.map((x) => DoanhThu.fromJson(x))
            );
          });
        } else {
          setState(() {
            reportData = [];
          });
        }
      } else {
        setState(() {
          reportData = [];
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REPORTS'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTabButton(context, 'DASHBOARD', false),
              _buildTabButton(context, 'DOANH THU', false),
              _buildTabButton(context, 'BÁC SĨ', true),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTabButton(context, 'BÁC SĨ CHỈ ĐỊNH', true),
              _buildTabButton(context, 'BÁC SĨ THỰC HIỆN', false),
            ],
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle date selection
                  },
                  icon: Icon(Icons.calendar_today),
                  label: Text('Tháng này'),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.filter_alt),
                  onPressed: () {
                    // Handle filter action
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: reportData.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: reportData.length,
                itemBuilder: (context, index) {
                  final item = reportData[index];
                  return _buildReportCard(
                    context,
                    item.ten ?? 'Unknown Title', // Sử dụng item.ten thay vì item['ten']
                    item.value?.toString() ?? '0.0', // Sử dụng item.value thay vì item['value']
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String title, bool selected) {
    return ElevatedButton(
      onPressed: () {
        // Handle tab change
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? Colors.blue : Colors.grey,
      ),
      child: Text(title),
    );
  }

  Widget _buildReportCard(BuildContext context, String title, String value) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            value,
            style: TextStyle(color: Colors.yellow),
          ),
        ],
      ),
    );
  }
}
