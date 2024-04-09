import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';
import 'package:project/data/models/product/product_model.dart';
import 'package:project/views/widgets/size.dart';

class SimpleCard extends StatelessWidget {
  final ProductModel prod;
  const SimpleCard({
    super.key,
    required this.prod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.r),
        color: Colors.grey,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(
            Colors.black26,
            BlendMode.darken,
          ),
          image: NetworkImage(prod.images[0]),
        ),
      ),
      padding: sizePadding(height: -5, width: -2),
      width: 250.w,
      child: Text(
        prod.title,
        textAlign: TextAlign.start,
        maxLines: 2,
        style: ThemeText.heading3.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
