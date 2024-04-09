import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';
import 'package:project/views/widgets/size.dart';

Widget drawerCard({
  required String text,
  required VoidCallback callback,
  required IconData icon,
}) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 25.sp,
              ),
              widthBox(),
              Text(
                text,
                style: ThemeText.heading3,
              ),
            ],
          ),
          Container(
            width: 65.w,
            height: 1.h,
            margin: sizePadding(width: -10, height: 3),
            color: AppColor.kMainColor,
          ),
        ],
      ),
    ),
  );
}
