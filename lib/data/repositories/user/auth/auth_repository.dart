import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/core/api.dart';
import 'package:project/data/models/user/token_model.dart';
import 'package:project/data/models/user/user_model.dart';

class AuthRepository {
  static final _api = Api();

  static Future<TokenModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.dio.post(
        "/v1/auth/login",
        data: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final box = Hive.box('data');
      box.put('token', response.data);

      return TokenModel.fromJson(response.data);
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }

  static Future<UserModel> createUser({
    required String email,
    required String password,
    required String name,
    String avatar =
        "https://soccerpointeclaire.com/wp-content/uploads/2021/06/default-profile-pic-e1513291410505.jpg",
  }) async {
    try {
      Response response = await _api.dio.post(
        "/v1/users/",
        data: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'avatar': avatar,
        }),
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }
}
