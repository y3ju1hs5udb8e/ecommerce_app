import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/views/widgets/size.dart';

Widget formField({
  required TextEditingController controller,
  required String text,
  bool isInt = false,
}) {
  return Column(
    children: [
      TextFormField(
        controller: controller,
        keyboardType: isInt ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.r),
          ),
        ),
      ),
      heightBox(),
    ],
  );
}
