import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/views/widgets/size.dart';

class BannerWidget extends StatelessWidget {
  final PageController controller;
  final List<String> banners;
  const BannerWidget(
      {super.key, required this.controller, required this.banners});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      scrollBehavior: const MaterialScrollBehavior(),
      allowImplicitScrolling: true,
      children: [
        for (final i in banners)
          Padding(
            padding: sizePadding(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                'assets/images/$i',
                fit: BoxFit.fill,
                color: Colors.black38,
                colorBlendMode: BlendMode.lighten,
                width: double.infinity,
                height: 190.h,
              ),
            ),
          ),
      ],
    );
  }
}
