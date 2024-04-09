// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int number;

  @HiveField(2)
  String image;

  @HiveField(3)
  int price;

  @HiveField(4)
  String category;

  @HiveField(5)
  int id;

  CartModel({
    required this.name,
    required this.category,
    required this.image,
    required this.price,
    required this.number,
    required this.id,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      name: json['name'],
      category: json['category'],
      image: json['image'],
      price: json['price'],
      number: json['number'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'image': image,
      'price': price,
      'number': number,
      'id': id,
    };
  }

  CartModel copyWith({
    String? name,
    int? number,
    String? image,
    int? price,
    String? category,
    int? id,
  }) {
    return CartModel(
      name: name ?? this.name,
      number: number ?? this.number,
      image: image ?? this.image,
      price: price ?? this.price,
      category: category ?? this.category,
      id: id ?? this.id,
    );
  }
}
