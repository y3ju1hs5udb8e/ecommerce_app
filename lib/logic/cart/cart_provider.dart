import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/data/models/cart/cart_model.dart';
import 'package:project/data/models/product/product_model.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartModel>>(
    (ref) => CartNotifier());

class CartNotifier extends StateNotifier<List<CartModel>> {
  CartNotifier() : super([]);

  void addToCart(ProductModel product) {
    final existingIndex = state.indexWhere((item) => item.id == product.id);

    if (existingIndex != -1) {
      state[existingIndex] = CartModel(
        id: product.id,
        name: product.title,
        image: product.images[0],
        price: product.price,
        category: product.category.name,
        number: state[existingIndex].number + 1,
      );
    } else {
      state = [
        ...state,
        CartModel(
          id: product.id,
          name: product.title,
          image: product.images[0],
          price: product.price,
          category: product.category.name,
          number: 1,
        ),
      ];
    }
  }

  void deleteItem(int id) {
    final exisitingIndex = state.indexWhere((element) => element.id == id);

    if (exisitingIndex != -1) {
      if (state[exisitingIndex].number > 1) {
        state[exisitingIndex] = state[exisitingIndex].copyWith(
          number: state[exisitingIndex].number - 1,
        );
      } else {
        state.removeAt(exisitingIndex);
      }
    } else {
      state.removeAt(exisitingIndex);
    }

    state = [...state];
  }

  double totalSum() {
    double total = 0;

    for (final i in state) {
      total = total + (i.number * i.price);
    }

    return total;
  }
}
