import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/views/screens/auth/login_screen.dart';
import 'package:project/views/widgets/common_button.dart';
import 'package:project/views/widgets/size.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = "welcome";
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        // alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            image: AssetImage("assets/images/splash_image.jpg"),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Live Your\nPerfect',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              'smart, gorgeous, & fashionable\ncollections make you cool',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            heightBox(height: 50),
            commonButton(
              callback: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              text: 'Start',
            ),
          ],
        ),
      ),
    );
  }
}
