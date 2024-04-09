import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '404 screen doesn\'t exist',
          style: TextStyle(
            fontSize: 40.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
