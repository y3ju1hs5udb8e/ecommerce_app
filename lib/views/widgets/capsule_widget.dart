import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';
import 'package:project/views/widgets/image_widget.dart';
import 'package:project/views/widgets/size.dart';

Widget capsuleWidget({
  required String text,
  required String image,
}) {
  return Container(
    padding: sizePadding(height: 5),
    margin: EdgeInsets.symmetric(horizontal: 10.w),
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColor.kMainColor,
      ),
      borderRadius: BorderRadius.circular(18.r),
    ),
    child: Row(
      children: [
        imageBox(
          image: image,
          width: 25.w,
          height: 20.h,
        ),
        widthBox(width: -3),
        Text(text),
      ],
    ),
  );
}
