import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final String currentTab;
  final Function(String) onTabSelected;

  const CustomTabBar({super.key, required this.currentTab, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Khoảng cách giữa thanh tab và các cạnh
      child: Column(
        children: [
          const SizedBox(height: 37), // Khoảng cách từ phần trên đến các thành phần tab
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTabItem("DASHBOARD"),
              _buildTabItem("DOANH THU"),
              _buildTabItem("BÁC SĨ"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String tabTitle) {
    bool isSelected = tabTitle == currentTab;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(tabTitle),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding để làm cho tab nhỏ hơn
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(16.0), // Bán kính bo tròn
          ),
          child: Center(
            child: Text(
              tabTitle,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.0, // Kích thước chữ
              ),
            ),
          ),
        ),
      ),
    );
  }
}
