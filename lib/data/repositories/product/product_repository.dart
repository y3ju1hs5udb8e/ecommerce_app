import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/core/api.dart';
import 'package:project/data/models/product/product_model.dart';

class ProductRepository {
  static final Api _api = Api();

  //get all from db
  static Future<List<ProductModel>> getProduct() async {
    try {
      Response response = await _api.dio.get("/v1/products");

      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }

  //product category
  static Future<List<Category>> getCategory() async {
    try {
      Response response = await _api.dio.get("/v1/categories");

      return (response.data as List).map((e) => Category.fromJson(e)).toList();
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }

  //create category
  static Future<Category> createCategory({
    required String title,
    required XFile? image,
  }) async {
    try {
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

      Response response = await _api.dio.post(
        "/v1/categories/",
        data: {
          "name": title,
          "image": res.data["location"],
        },
      );

      return Category.fromJson(response.data);
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }

  //single from db
  static Future<ProductModel> getProductDetail({required int id}) async {
    try {
      Response response = await _api.dio.get("/v1/products/$id");

      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }

  //create product
  static Future<ProductModel> createProduct({
    required List<XFile?> images,
    required String title,
    required String description,
    required String categoryName,
    required int price,
  }) async {
    try {
      //photo list upload
      List<String> imageUrl = [];

      for (final i in images) {
        List<int> binary = await i!.readAsBytes();

        FormData formData = FormData.fromMap({
          'file': MultipartFile.fromBytes(
            binary,
            filename: i.path.split('/').last,
          ),
        });

        Response res = await _api.dio.post(
          '/v1/files/upload',
          data: formData,
        );

        String imageLink = res.data['location'];

        imageUrl.add(imageLink);
      }

      //category id
      final listCategory = await ProductRepository.getCategory();

      late int id;

      final index =
          listCategory.indexWhere((element) => element.name == categoryName);
      if (index != -1) {
        id = listCategory[index].id;
      } else {
        id = 1;
      }

      //create
      Response response = await _api.dio.post(
        '/v1/products/',
        data: {
          "title": title,
          "price": price,
          "description": description,
          "categoryId": id,
          "images": imageUrl,
        },
      );

      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }

  static Future<ProductModel> updateProduct({
    required int id,
    required String title,
    required String description,
    required int price,
  }) async {
    try {
      Response response = await _api.dio.put(
        '/v1/products/$id',
        data: {
          "title": title,
          "price": price,
          "description": description,
        },
      );

      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }

  static Future deleteProduct({required int id}) async {
    try {
      Response response = await _api.dio.delete('/v1/products/$id');

      return response.data;
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }
}
