//register image format to url to access

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/core/api.dart';
import 'package:project/data/models/product/file_model.dart';

class FileRepository {
  static final _api = Api();

  static Future<FileModel> registerImage({required XFile image}) async {
    try {
      List<int> binary = await image.readAsBytes();

      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          binary,
          filename: image.path.split('/').last,
        ),
      });

      Response response = await _api.dio.post(
        '/v1/files/upload',
        data: formData,
        // options: Options(headers: {
        //   'Content-Type': 'multipart/form-data',
        // }),
      );

      return FileModel.fromMap(response.data);
    } on DioException catch (e) {
      throw "${e.toString}";
    }
  }
}
