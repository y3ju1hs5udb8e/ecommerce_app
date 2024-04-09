import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';

Widget commonButton({
  required VoidCallback callback,
  required String text,
}) {
  return FilledButton(
    onPressed: callback,
    style: FilledButton.styleFrom(
      alignment: Alignment.center,
      fixedSize: Size(350.w, 65.h),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(17.r),
      ),
      backgroundColor: AppColor.kMainColor,
    ),
    child: Text(
      text,
      style: ThemeText.heading2,
    ),
  );
}

Widget iconButton({
  required VoidCallback callback,
  required IconData iconData,
  required Color color,
  required Color iconColor,
  required BorderRadius borderRadius,
}) {
  return IconButton(
    onPressed: callback,
    style: IconButton.styleFrom(
        backgroundColor: color,
        shape: BeveledRectangleBorder(
          borderRadius: borderRadius,
        )),
    icon: Icon(
      iconData,
      size: 30.sp,
      color: iconColor,
    ),
  );
}
