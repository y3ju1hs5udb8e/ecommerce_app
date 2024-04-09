import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/core/themes.dart';
import 'package:project/data/models/user/user_model.dart';
import 'package:project/logic/others/other_providers.dart';
import 'package:project/logic/user/user_provider.dart';
import 'package:project/views/screens/others/root_screen.dart';
import 'package:project/views/widgets/common_button.dart';
import 'package:project/views/widgets/form_widget.dart';
import 'package:project/views/widgets/message_snackbar.dart';
import 'package:project/views/widgets/size.dart';

@override
class ProfileEditScreen extends StatelessWidget {
  static const String routeName = 'profileEditPage';
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final userData = ref.watch(userProvider);
          return userData.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (user) => _buildProfileForm(
              user,
              context,
            ),
            error: (error, stackTrace) => _buildErrorContent(error, context),
          );
        },
      ),
    );
  }

  Widget _buildProfileForm(
    UserModel user,
    BuildContext context,
  ) {
    final TextEditingController nameController =
        TextEditingController(text: user.name);
    final TextEditingController emailController =
        TextEditingController(text: user.email);
    final TextEditingController passwordController =
        TextEditingController(text: user.password);
    final TextEditingController roleController =
        TextEditingController(text: user.role);

    return SingleChildScrollView(
      padding: sizePadding(),
      child: Column(
        children: [
          Text(
            'Edit Profile',
            style: ThemeText.heading1,
          ),
          heightBox(height: 10),

          //name
          formField(controller: nameController, text: 'Name'),

          //email
          formField(controller: emailController, text: 'Email'),

          //password
          formField(controller: passwordController, text: 'Password'),

          //role
          formField(controller: roleController, text: 'Role'),

          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return commonButton(
                callback: () {
                  FocusScope.of(context).unfocus();
                  final data = ref.read(userProvider.notifier).updateProfile(
                        userModel: UserModel(
                          id: user.id,
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                          role: roleController.text,
                          avatar: user.avatar,
                        ),
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
                },
                text: 'Update Profile',
              );
            },
          ),
          heightBox(height: 20),
          Text(
            'Note: You can only update your image/profile via your profile screen',
            textAlign: TextAlign.center,
            style: ThemeText.heading3.copyWith(color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorContent(dynamic error, BuildContext context) {
    return Center(
      child: Text('Error: $error'),
    );
  }
}
