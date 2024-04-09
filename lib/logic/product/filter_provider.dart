import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/data/models/product/product_model.dart';
import 'package:project/data/repositories/product/filter_repositor.dart';

//search
final filterProvider =
    AsyncNotifierProvider<FilterProvider, List<ProductModel>>(
        FilterProvider.new);

class FilterProvider extends AsyncNotifier<List<ProductModel>> {
  @override
  FutureOr<List<ProductModel>> build() {
    return [];
  }

  //search feature
  Future searchProduct({required String title}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => FilterRepository.searchProduct(title: title),
    );
  }
}

//category
final catItemProvider = FutureProvider.family(
    (ref, int id) => FilterRepository.getCategorizedItems(id: id));
