import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';
import 'package:project/logic/others/other_providers.dart';
import 'package:project/logic/product/category_provider.dart';
import 'package:project/views/screens/others/root_screen.dart';
import 'package:project/views/widgets/common_button.dart';
import 'package:project/views/widgets/form_widget.dart';
import 'package:project/views/widgets/message_snackbar.dart';
import 'package:project/views/widgets/size.dart';

class CategoryUploadScreen extends StatelessWidget {
  static const String routeName = 'categoryUpload';
  const CategoryUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create category'),
      ),
      body: _categoryField(),
    );
  }

  SingleChildScrollView _categoryField() {
    final titleController = TextEditingController();
    return SingleChildScrollView(
      padding: sizePadding(),
      child: Consumer(builder: (context, ref, child) {
        final image = ref.watch(imagePickerProvider);
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                ref.read(imagePickerProvider.notifier).galleryImage();
              },
              child: Container(
                width: double.infinity,
                height: 250.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: Colors.grey.shade600,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
                child: image != null
                    ? Image.file(
                        File(image.path),
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Text(
                          'Category Image here',
                          style: ThemeText.heading3,
                        ),
                      ),
              ),
            ),
            heightBox(),
            formField(
              controller: titleController,
              text: 'Title',
            ),
            heightBox(),
            commonButton(
              callback: () {
                if (image != null) {
                  final data =
                      ref.read(categoryProvider.notifier).createCategory(
                            title: titleController.text,
                            image: image,
                          );

                  data.whenComplete(() {
                    messageSnackBox(
                      context: context,
                      text: 'Upload Success',
                      time: 3,
                    );

                    Navigator.pushReplacementNamed(
                        context, RootScreen.routeName);

                    ref.invalidate(imagePickerProvider);
                  });
                } else {
                  messageSnackBox(
                    context: context,
                    text: 'Image should be provided',
                    time: 5,
                  );
                }
              },
              text: 'Create',
            ),
          ],
        );
      }),
    );
  }
}
