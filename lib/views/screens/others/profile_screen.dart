import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/themes.dart';
import 'package:project/logic/cart/cart_provider.dart';
import 'package:project/logic/others/other_providers.dart';
import 'package:project/logic/user/user_provider.dart';
import 'package:project/views/screens/others/root_screen.dart';
import 'package:project/views/widgets/message_snackbar.dart';
import 'package:project/views/widgets/size.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = 'profilePage';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          final cart = ref.watch(cartProvider);
          final data = ref.watch(userProvider);
          final image = ref.watch(imagePickerProvider);
          final user = data.value!;
          return SingleChildScrollView(
            padding: sizePadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heightBox(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200.w,
                      height: 200.w,
                      child: image != null
                          ? Image.file(File(image.path))
                          : Image.network(user.avatar),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (image != null)
                          TextButton(
                            onPressed: () {
                              ref.invalidate(imagePickerProvider);
                            },
                            child: Text(
                              'Cancel',
                              style: ThemeText.heading3,
                            ),
                          ),
                        TextButton(
                          onPressed: image != null
                              ? () {
                                  final data = ref
                                      .read(userProvider.notifier)
                                      .updateImage(
                                        image: image,
                                        id: user.id,
                                      );

                                  data.whenComplete(() {
                                    messageSnackBox(
                                      context: context,
                                      text: 'Profile pic changed',
                                      time: 3,
                                    );

                                    Navigator.pushReplacementNamed(
                                        context, RootScreen.routeName);

                                    ref.invalidate(imagePickerProvider);
                                  });
                                }
                              : () {
                                  ref
                                      .read(imagePickerProvider.notifier)
                                      .galleryImage();
                                },
                          child: Text(
                            image != null ? 'Update' : 'Change profile',
                            style: ThemeText.heading3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                heightBox(),
                Text(
                  user.email,
                  style: ThemeText.heading2,
                ),
                heightBox(),
                Text(
                  user.name,
                  style: ThemeText.heading3,
                ),
                heightBox(),
                Divider(
                  color: Colors.grey[300],
                  thickness: 2,
                  indent: 50,
                  endIndent: 50,
                ),
                heightBox(),
                _buildInfoRow('Email', Icons.email, user.email),
                _buildInfoRow('Password', Icons.lock, user.password),
                _buildInfoRow('Role', Icons.person, user.role),
                _buildInfoRow(
                    'Cart', Icons.shopping_cart, cart.length.toString()),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildInfoRow(String title, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: ThemeText.heading4,
          ),
          Row(
            children: [
              Icon(icon, size: 24, color: Colors.grey),
              widthBox(),
              Text(
                text,
                style: ThemeText.heading3,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget textBtn({
    required VoidCallback callback,
    required String text,
  }) {
    return TextButton(
      onPressed: callback,
      child: Text(
        text,
        style: ThemeText.heading4,
      ),
    );
  }

  // void showBottomTap({
  //   required BuildContext context,
  // }) {
  //   showBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return BottomSheet(
  //         onClosing: () {},
  //         builder: (context) {

  //         },
  //       );
  //     },
  //   );
  // }
}
