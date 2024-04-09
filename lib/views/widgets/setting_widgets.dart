// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';

//normal
class OptionWidget extends StatelessWidget {
  final VoidCallback callback;
  final String title;
  final String subTitle;
  final IconData iconData;
  const OptionWidget({
    super.key,
    required this.callback,
    required this.title,
    required this.subTitle,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(
        color: Colors.grey.shade300,
        width: 1.5,
      ))),
      child: ListTile(
        onTap: callback,
        leading: Icon(
          iconData,
          size: 25.sp,
        ),
        title: Text(
          title,
          style: ThemeText.heading3,
        ),
        subtitle: Text(
          subTitle,
          style: ThemeText.heading4,
        ),
      ),
    );
  }
}
