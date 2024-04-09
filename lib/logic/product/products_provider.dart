import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/data/models/product/product_model.dart';
import 'package:project/data/repositories/product/product_repository.dart';

final productProvider =
    StateNotifierProvider<ProductProvider, AsyncValue<List<ProductModel>>>(
  (ref) {
    return ProductProvider();
  },
);

class ProductProvider extends StateNotifier<AsyncValue<List<ProductModel>>> {
  final StreamController _asyncStream = StreamController();

  ProductProvider() : super(const AsyncValue.loading()) {
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    try {
      List<ProductModel> products = await ProductRepository.getProduct();
      state = AsyncValue.data(products);
      _asyncStream.add(AsyncValue.data(products));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      _asyncStream.add(AsyncValue.error(e, st));
    }
  }

  Future<void> createProduct({
    required List<XFile?> images,
    required String title,
    required String description,
    required String categoryName,
    required int price,
  }) async {
    try {
      await ProductRepository.createProduct(
        categoryName: categoryName,
        description: description,
        images: images,
        price: price,
        title: title,
      );

      _fetchProduct();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      _asyncStream.add(AsyncValue.error(e, st));
    }
  }

  Future updateProduct({
    required int id,
    required String title,
    required String description,
    required int price,
  }) async {
    try {
      await ProductRepository.updateProduct(
        description: description,
        id: id,
        price: price,
        title: title,
      );

      _fetchProduct();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      _asyncStream.add(AsyncValue.error(e, st));
    }
  }

  Future deleteProduct({required int id}) async {
    try {
      await ProductRepository.deleteProduct(id: id);

      _fetchProduct();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      _asyncStream.add(AsyncValue.error(e, st));
    }
  }

  //getter
  Stream get data => _asyncStream.stream;

  @override
  void dispose() {
    super.dispose();
    _asyncStream.close();
  }
}
