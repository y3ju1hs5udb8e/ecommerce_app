import 'package:dio/dio.dart';
import 'package:project/core/api.dart';
import 'package:project/data/models/product/product_model.dart';

class FilterRepository {
  static final Api _api = Api();

  //search
  static Future<List<ProductModel>> searchProduct(
      {required String title}) async {
    try {
      Response response = await _api.dio.get('/v1/products/?title=$title');

      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }

  //category items
  static Future<List<ProductModel>> getCategorizedItems(
      {required int id}) async {
    try {
      Response response = await _api.dio.get('/v1/products/?categoryId=$id');

      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw '${e.message}';
    }
  }
}
