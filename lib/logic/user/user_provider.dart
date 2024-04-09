import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/data/models/user/user_model.dart';
import 'package:project/data/repositories/user/user_repository.dart';

final userProvider =
    StateNotifierProvider<UserDataNotifier, AsyncValue<UserModel>>((ref) {
  return UserDataNotifier();
});

class UserDataNotifier extends StateNotifier<AsyncValue<UserModel>> {
  final _userAsync = StreamController<AsyncValue<UserModel>>();

  UserDataNotifier() : super(const AsyncValue.loading()) {
    userProfile();
  }

  void userProfile() async {
    try {
      final user = await UserRepository.getUser();
      state = AsyncValue.data(user);
      _userAsync.add(AsyncValue.data(user));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      _userAsync.add(AsyncValue.error(e, st));
    }
  }

  Future updateProfile({
    required UserModel userModel,
    XFile? image,
  }) async {
    try {
      final user = await UserRepository.updateProfile(
        userModel: userModel,
      );
      state = AsyncValue.data(user);
      _userAsync.add(AsyncValue.data(user));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      _userAsync.add(AsyncValue.error(e, st));
    }
  }

  Future updateImage({
    required XFile? image,
    required int id,
  }) async {
    try {
      final user = await UserRepository.updateImage(
        image: image,
        id: id,
      );
      state = AsyncValue.data(user);
      _userAsync.add(AsyncValue.data(user));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      _userAsync.add(AsyncValue.error(e, st));
    }
  }

  //user data(stream) getter
  Stream<AsyncValue<UserModel>> get userDatas => _userAsync.stream;

  @override
  void dispose() {
    _userAsync.close();
    super.dispose();
  }
}
