import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project/data/models/product/product_model.dart';
import 'package:project/views/screens/store/detail_screen.dart';
import 'package:project/views/widgets/simple_card.dart';

class CarouselWidget extends StatelessWidget {
  final List<ProductModel> data;
  const CarouselWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 6,
      itemBuilder: (context, index, realIndex) {
        final prod = data[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(data: prod),
              ),
            );
          },
          child: SimpleCard(prod: prod),
        );
      },
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.5,
        aspectRatio: 2,
        initialPage: 1,
      ),
    );
  }
}
