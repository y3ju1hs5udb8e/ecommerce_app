import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//sizebox
Widget heightBox({
  double height = 0,
}) {
  return SizedBox(
    height: (20 + height).h,
  );
}

Widget widthBox({
  double width = 0,
}) {
  return SizedBox(
    width: (10 + width).w,
  );
}

//padding
EdgeInsets sizePadding({
  double width = 0,
  double height = 0,
}) {
  return EdgeInsets.symmetric(
    horizontal: (10 + width).w,
    vertical: (5 + height).h,
  );
}
