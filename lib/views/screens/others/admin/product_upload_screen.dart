import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/core/themes.dart';
import 'package:project/logic/product/products_provider.dart';
import 'package:project/views/screens/others/admin/category_upload_screen.dart';
import 'package:project/views/screens/others/root_screen.dart';
import 'package:project/views/widgets/common_button.dart';
import 'package:project/views/widgets/form_widget.dart';
import 'package:project/views/widgets/message_snackbar.dart';
import 'package:project/views/widgets/size.dart';

class ProductUploadScreen extends StatefulWidget {
  const ProductUploadScreen({super.key});

  @override
  State<ProductUploadScreen> createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  List<XFile?> images = [];

  void pickMultipleImage() async {
    final ImagePicker imagePicker = ImagePicker();
    List<XFile?> multipleImage = await imagePicker.pickMultiImage();
    if (multipleImage.isNotEmpty) {
      images.addAll(multipleImage);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: sizePadding(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create Category',
                    style: ThemeText.heading3.copyWith(fontSize: 21.sp),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, CategoryUploadScreen.routeName);
                    },
                    child: Text(
                      'Create',
                      style: ThemeText.heading3.copyWith(fontSize: 21.sp),
                    ),
                  ),
                ],
              ),
              heightBox(height: -5),
              Text(
                '-Or-',
                style: ThemeText.heading3,
              ),
              heightBox(height: -5),
              Text(
                'Publish Product',
                style: ThemeText.heading2,
              ),

              heightBox(),

              //form datas{tiitle, description, price and category name}
              formField(
                controller: titleController,
                text: 'Title',
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                ),
              ),
              heightBox(),
              formField(
                controller: priceController,
                text: 'Product Cost',
                isInt: true,
              ),
              formField(
                controller: categoryController,
                text: 'Category Name',
              ),
              heightBox(),
              ElevatedButton(
                onPressed: pickMultipleImage,
                child: const Text('Upload images'),
              ),
              heightBox(height: -10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    for (final i in images)
                      Container(
                        width: 100.w,
                        height: 100.h,
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: i != null
                            ? Image.file(File(i.path))
                            : const Text('Image Here'),
                      ),
                  ],
                ),
              ),

              heightBox(),

              //submit btn
              Consumer(builder: (context, ref, child) {
                return commonButton(
                  callback: () {
                    FocusScope.of(context).unfocus();
                    if (images.isNotEmpty) {
                      final data =
                          ref.read(productProvider.notifier).createProduct(
                                images: images,
                                title: titleController.text,
                                description: descriptionController.text,
                                categoryName: categoryController.text,
                                price: int.parse(priceController.text),
                              );

                      data.whenComplete(() {
                        messageSnackBox(
                          context: context,
                          text: 'Product added',
                          time: 3,
                        );

                        Navigator.pushReplacementNamed(
                            context, RootScreen.routeName);
                      });

                      Navigator.pushReplacementNamed(
                          context, RootScreen.routeName);
                    } else {
                      errorSnackBar(
                        context: context,
                        text: 'Product images should be provided',
                        time: 3,
                      );
                    }
                  },
                  text: 'Publish',
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
  }
}
