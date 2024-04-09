import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';
import 'package:project/data/models/product/product_model.dart';
import 'package:project/views/screens/store/detail_screen.dart';
import 'package:project/views/widgets/image_widget.dart';
import 'package:project/views/widgets/size.dart';

class ProductCard extends StatelessWidget {
  final ProductModel data;
  final int height;
  const ProductCard({
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
            builder: (context) => DetailScreen(data: data),
          ),
        );
      },
      child: Container(
        width: 190.w,
        height: 290.h,
        alignment: Alignment.center,
        padding: sizePadding(width: -5),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.kMainColor,
          ),
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7.r),
              child: imageBox(image: data.images[0]),
            ),
            Text(
              data.title,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: ThemeText.heading3.copyWith(
                fontSize: 21.sp,
              ),
            ),
            Text(
              "${data.price}\$",
              maxLines: 1,
              style: ThemeText.heading2,
            ),
          ],
        ),
      ),
    );
  }
}
