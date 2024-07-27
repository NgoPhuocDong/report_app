import 'package:flutter/material.dart';

class RevenuePage extends StatelessWidget {
  const RevenuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF294157),
      child: Center(
        child: Text(
          'Nội dung Doanh Thu',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}