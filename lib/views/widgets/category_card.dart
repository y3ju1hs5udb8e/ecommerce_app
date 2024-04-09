import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';
import 'package:project/data/models/product/product_model.dart';
import 'package:project/views/screens/others/category_screen.dart';
import 'package:project/views/widgets/size.dart';

class CategoryCard extends StatelessWidget {
  final Category data;
  final int height;
  const CategoryCard({
    super.key,
    required this.data,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              id: data.id,
              title: data.name,
            ),
          ),
        );
      },
      child: Container(
        width: 190.w,
        height: 290.h,
        alignment: Alignment.center,
        padding: sizePadding(width: -5),
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(7.r),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                Colors.black38,
                BlendMode.darken,
              ),
              image: NetworkImage(data.image),
            )),
        child: Text(
          data.name,
          style: ThemeText.heading2.copyWith(
            color: AppColor.kWhiteColor,
          ),
        ),
      ),
    );
  }
}
