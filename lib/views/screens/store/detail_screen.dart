import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';
import 'package:project/data/models/product/product_model.dart';
import 'package:project/logic/cart/cart_provider.dart';
import 'package:project/logic/product/products_provider.dart';
import 'package:project/logic/user/user_provider.dart';
import 'package:project/views/screens/others/admin/update_screen.dart';
import 'package:project/views/screens/others/category_screen.dart';
import 'package:project/views/screens/others/root_screen.dart';
import 'package:project/views/widgets/common_button.dart';
import 'package:project/views/widgets/image_widget.dart';
import 'package:project/views/widgets/message_snackbar.dart';
import 'package:project/views/widgets/size.dart';

class DetailScreen extends StatefulWidget {
  static const String routeName = 'details';

  final ProductModel data;
  const DetailScreen({
    super.key,
    required this.data,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Details',
          style: ThemeText.heading2,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_outlined,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.r),
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(17.r),
                      bottomRight: Radius.circular(17.r),
                    ),
                    child: imageBox(
                      image:
                          imageUrl == null ? widget.data.images[0] : imageUrl!,
                      height: 350,
                    ),
                  ),
                  heightBox(),
                  SingleChildScrollView(
                    padding: sizePadding(width: -5, height: -5),
                    child: Row(
                      children: [
                        for (final i in widget.data.images)
                          Container(
                            width: 70.w,
                            height: 70.h,
                            margin: sizePadding(width: -5, height: -5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  imageUrl = i;
                                });
                              },
                              child: imageBox(image: i),
                            ),
                          ),
                      ],
                    ),
                  ),
                  heightBox(),
                  Padding(
                    padding: sizePadding(),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CategoryScreen(
                                        id: widget.data.category.id,
                                        title: widget.data.category.name,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  widget.data.category.name,
                                  textAlign: TextAlign.left,
                                  style: ThemeText.heading2.copyWith(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "⭐(4.5)",
                              style: ThemeText.heading3.copyWith(
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                        heightBox(height: -3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                widget.data.title,
                                textAlign: TextAlign.left,
                                style: ThemeText.heading2.copyWith(),
                              ),
                            ),
                            widthBox(),
                            Text(
                              "\$ ${widget.data.price}",
                              style: ThemeText.heading3,
                            ),
                          ],
                        ),
                        heightBox(),
                        ExpansionTile(
                          title: Text(
                            'Description',
                            style: ThemeText.heading2,
                          ),
                          children: [
                            Text(
                              widget.data.description,
                              textAlign: TextAlign.start,
                              style: ThemeText.heading3,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  heightBox(height: 40),
                ],
              ),
            ),
          ),
          Consumer(builder: (context, ref, child) {
            final user = ref.watch(userProvider);
            return Positioned(
              left: 35,
              bottom: 5,
              child: user.value!.role == 'Customer' ||
                      user.value!.role == 'customer'
                  ? commonButton(
                      callback: () {
                        ref.read(cartProvider.notifier).addToCart(widget.data);
                        messageSnackBox(
                          context: context,
                          text: 'Added to Cart',
                          time: 3,
                        );
                      },
                      text: 'Add to Cart',
                    )
                  : Container(
                      padding: sizePadding(),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              final data = ref
                                  .read(productProvider.notifier)
                                  .deleteProduct(id: widget.data.id);

                              data.whenComplete(() =>
                                  Navigator.pushReplacementNamed(
                                      context, RootScreen.routeName));
                            },
                            style: IconButton.styleFrom(
                              fixedSize: Size(50.w, 55.h),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: const BeveledRectangleBorder(),
                            ),
                            icon: Icon(
                              Icons.delete,
                              size: 30.sp,
                            ),
                          ),
                          widthBox(width: 10),
                          FilledButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateScreen(data: widget.data),
                                ),
                              );
                            },
                            style: IconButton.styleFrom(
                              fixedSize: Size(250.w, 55.h),
                              backgroundColor: Colors.green.shade700,
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(7.r),
                              ),
                            ),
                            child: Text(
                              'Update',
                              style: ThemeText.heading3,
                            ),
                          )
                        ],
                      ),
                    ),
            );
          }),
        ],
      ),
    );
  }
}
