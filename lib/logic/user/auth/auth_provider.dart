import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/data/models/user/token_model.dart';
import 'package:project/data/repositories/user/auth/auth_repository.dart';

//login logout
final authProvider = AsyncNotifierProvider<AuthNotifier, TokenModel>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<TokenModel> {
  @override
  FutureOr<TokenModel> build() async {
    final box = await Hive.box('data').get('token');
    return box != null
        ? TokenModel.fromJson(jsonDecode(jsonEncode(box)))
        : TokenModel.empty();
  }

  Future loginUser({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => AuthRepository.loginUser(
        email: email,
        password: password,
      ),
    );
  }

  void logOut() {
    state = const AsyncLoading();
    Hive.box('data').delete('token');
    state = AsyncData(TokenModel.empty());
  }
}

//create acc
final signupProvider = AsyncNotifierProvider(SignupNotifier.new);

class SignupNotifier extends AsyncNotifier {
  @override
  FutureOr build() {}

  Future createUser({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => AuthRepository.createUser(
        name: name,
        email: email,
        password: password,
      ),
    );
  }
}
