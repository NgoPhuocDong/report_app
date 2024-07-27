import 'package:flutter/material.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF294157),
      child: Center(
        child: Text(
          'Nội dung bác sĩ',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}