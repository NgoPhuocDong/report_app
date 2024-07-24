import 'package:flutter/material.dart';
import '../model/main_model.dart';
import '../widgets/custom_tab_bar.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  ReportsPageState createState() => ReportsPageState();
}

class ReportsPageState extends State<ReportsPage> {
  final MainModel model = MainModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REPORTS'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(); // Quay lại trang trước đó
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Xử lý khi nhấn vào nút tài khoản
            },
          ),
        ],
        elevation: 0, // Loại bỏ bóng dưới AppBar
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFFD9D9D9), // Màu cho đường gạch ngang
            height: 1.0, // Chiều cao của đường gạch ngang
          ),
          CustomTabBar(
            currentTab: model.currentTab,
            onTabSelected: (tab) {
              setState(() {
                model.currentTab = tab;
              });
            },
          ),
          const SizedBox(height: 37), // Khoảng cách giữa tab bar và phần thân
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF294157), // Mã màu #294157
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0), // Bán kính bo tròn cho góc trên bên trái
                  topRight: Radius.circular(30.0), // Bán kính bo tròn cho góc trên bên phải
                ),
              ),
              child: const Center(
                child: Text(
                  'Content goes here',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // Các nội dung khác của trang
            ),
          ),
        ],
      ),
    );
  }
}
