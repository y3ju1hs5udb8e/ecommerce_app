import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget imageBox({
  required String image,
  double width = double.infinity,
  double height = 180,
}) {
  return CachedNetworkImage(
    key: UniqueKey(),
    imageUrl: image,
    width: width,
    height: height,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    placeholder: (context, url) =>
        const Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
