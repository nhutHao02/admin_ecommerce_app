import 'package:flutter/material.dart';

class OrderItem {
  String? productId, name, image, price, description;
  int? quantity;
  bool? isChecked = false;
  Color? color;

  OrderItem({this.productId, this.name, this.image, this.price, this.description});

  OrderItem.fromJson(Map<String, dynamic> jsonMap) {
    productId = jsonMap['productId'];
    name = jsonMap['name'];
    image = jsonMap['image'];
    price = jsonMap['price'].toString();
    description = jsonMap['description'];
    quantity = int.parse(jsonMap['quantity'].toString());
    isChecked = false;
    color = null;
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'quantity': quantity ?? 0,
      'isChecked': isChecked ?? false,
      'color': color,
    };
  }
}
