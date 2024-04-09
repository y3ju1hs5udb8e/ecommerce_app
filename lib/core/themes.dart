import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///appColor
class AppColor {
  static Color kMainColor = const Color(0xffff772a);
  static Color kTextColor = const Color(0xff141414);
  static Color kWhiteColor = const Color(0xffffffff);
}

///appTheme
class AppThemes {
  //ligh
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.kWhiteColor,
    colorScheme: ColorScheme.light(
      primary: AppColor.kMainColor,
      secondary: AppColor.kMainColor,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColor.kWhiteColor,
    ),
    iconTheme: IconThemeData(
      size: 20,
      color: AppColor.kTextColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.kTextColor,
    colorScheme: ColorScheme.dark(
      primary: AppColor.kMainColor,
      secondary: AppColor.kMainColor,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColor.kTextColor,
    ),
    iconTheme: IconThemeData(
      size: 20,
      color: AppColor.kWhiteColor,
    ),
  );
}

///text theme
class ThemeText {
  //heading 1 not working
  static TextStyle heading1 = TextStyle(
    fontSize: 45.sp,
    fontWeight: FontWeight.w800,
  );

  static TextStyle heading2 = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle heading3 = TextStyle(
    fontSize: 25.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle heading4 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w300,
  );
}
