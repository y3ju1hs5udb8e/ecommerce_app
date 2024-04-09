import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/logic/user/auth/auth_provider.dart';
import 'package:project/views/screens/others/root_screen.dart';
import 'package:project/views/screens/others/welcome_screen.dart';

class StatusScreen extends ConsumerWidget {
  static const String routeName = 'status';
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);
    return state.value?.accessToken != "invalid"
        ? const RootScreen()
        : const WelcomeScreen();
  }
}
