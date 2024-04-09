import 'package:flutter/material.dart';
import 'package:project/views/screens/auth/login_screen.dart';
import 'package:project/views/screens/auth/signup_screen.dart';
import 'package:project/views/screens/others/admin/category_upload_screen.dart';
import 'package:project/views/screens/others/all_category_screen.dart';
import 'package:project/views/screens/others/errors/error_screen.dart';
import 'package:project/views/screens/others/profile_edit_screeen.dart';
import 'package:project/views/screens/others/profile_screen.dart';
import 'package:project/views/screens/others/root_screen.dart';
import 'package:project/views/screens/others/setting_screen.dart';
import 'package:project/views/screens/others/status_screen.dart';
import 'package:project/views/screens/others/welcome_screen.dart';

class Routes {
  static Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );

      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      case SignUpScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );

      case StatusScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const StatusScreen(),
        );

      case RootScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RootScreen(),
        );

      case CategoryUploadScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const CategoryUploadScreen(),
        );

      case SettingScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SettingScreen(),
        );

      case AllCategoryScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const AllCategoryScreen(),
        );

      case ProfileEditScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ProfileEditScreen(),
        );

      case ProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const ErrorScreen(),
        );
    }
  }
}
