import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/core/api.dart';
import 'package:project/data/models/user/user_model.dart';

class UserRepository {
  static final Api _api = Api();

  static Future<UserModel> getUser() async {
    try {
      final data = Hive.box('data');
      final box = data.get('token');
      final map = jsonDecode(jsonEncode(box));

      Response response = await _api.dio.get(
        "/v1/auth/profile",
        options: Options(headers: {
          "Authorization": "Bearer ${map['access_token']}",
        }),
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }

  //update

  //name
  static Future<UserModel> updateProfile({
    required UserModel userModel,
  }) async {
    try {
      //update data
      Response response = await _api.dio.put(
        '/v1/users/${userModel.id}',
        data: {
          'avatar': userModel.avatar,
          'name': userModel.name,
          'email': userModel.email,
          'password': userModel.password,
          'role': userModel.role,
        },
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }

  static Future<UserModel> updateImage({
    required XFile? image,
    required int id,
  }) async {
    List<int> binary = await image!.readAsBytes();

    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        binary,
        filename: image.path.split('/').last,
      ),
    });

    Response res = await _api.dio.post(
      '/v1/files/upload',
      data: formData,
    );

    try {
      //update data
      Response response = await _api.dio.put(
        '/v1/users/$id',
        data: {
          'avatar': res.data['location'],
        },
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }
}
