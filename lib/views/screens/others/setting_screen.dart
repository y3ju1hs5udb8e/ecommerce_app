import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/core/themes.dart';
import 'package:project/logic/others/other_providers.dart';
import 'package:project/logic/user/user_provider.dart';
import 'package:project/views/screens/others/profile_edit_screeen.dart';
import 'package:project/views/widgets/setting_widgets.dart';
import 'package:project/views/widgets/size.dart';

class SettingScreen extends ConsumerWidget {
  static const String routeName = 'setting';
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isLight = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: sizePadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //common settings
            headingWidget('Common'),

            heightBox(),
            OptionWidget(
              callback: () {},
              title: 'Language',
              subTitle: 'English',
              iconData: Icons.language,
            ),

            heightBox(),
            OptionWidget(
              callback: () {},
              title: 'Location',
              subTitle: 'Nepal',
              iconData: Icons.location_city,
            ),

            //account settings
            heightBox(height: 5),
            headingWidget('Account'),

            heightBox(),
            OptionWidget(
              callback: () {},
              title: 'Profile',
              subTitle: user.value!.name,
              iconData: Icons.person,
            ),

            heightBox(),
            OptionWidget(
              callback: () {
                Navigator.pushNamed(context, ProfileEditScreen.routeName);
              },
              title: 'Edit Profile',
              subTitle: user.value!.email,
              iconData: Icons.edit_attributes,
            ),

            //security
            heightBox(height: 5),
            headingWidget('Security'),

            heightBox(),
            OptionWidget(
              callback: () {
                ref.read(themeProvider.notifier).toogle();
              },
              title: 'Dark Mode',
              subTitle: isLight ? 'Off' : 'On',
              iconData: Icons.light,
            ),

            heightBox(),
            OptionWidget(
              callback: () {},
              title: 'Lock App',
              subTitle: 'Unavailable',
              iconData: Icons.lock,
            ),

            //Others
            heightBox(height: 5),
            headingWidget('Misc'),

            heightBox(),
            OptionWidget(
              callback: () {},
              title: 'Legal Policy',
              subTitle: 'Tap to read',
              iconData: Icons.policy,
            ),

            heightBox(),
            OptionWidget(
              callback: () {},
              title: 'About',
              subTitle: 'Tap to read',
              iconData: Icons.info,
            ),
          ],
        ),
      ),
    );
  }

  Widget headingWidget(String text) => Text(
        text,
        textAlign: TextAlign.left,
        style: ThemeText.heading2,
      );
}
