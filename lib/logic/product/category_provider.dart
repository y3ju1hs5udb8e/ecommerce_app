import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/data/models/product/product_model.dart';
import 'package:project/data/repositories/product/product_repository.dart';

final categoryProvider =
    StateNotifierProvider<CategoryProvider, AsyncValue<List<Category>>>(
  (ref) => CategoryProvider(),
);

class CategoryProvider extends StateNotifier<AsyncValue<List<Category>>> {
  final StreamController _asyncStream = StreamController();

  CategoryProvider() : super(const AsyncValue.loading()) {
    _fetchCategory();
  }

  Future<void> _fetchCategory() async {
    try {
      final category = await ProductRepository.getCategory();
      state = AsyncValue.data(category);
      _asyncStream.add(AsyncValue.data(category));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createCategory({
    required String title,
    required XFile? image,
  }) async {
    try {
      await ProductRepository.createCategory(
        title: title,
        image: image,
      );

      _fetchCategory();
    } catch (e, st) {
      AsyncValue.error(e, st);
    }
  }
}
