// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_ecommerce_app/models/image_product.dart';

class Product {
  String? id, name, price, promotionalPrice, idStatus;
  List<ProductImage> images;
  Product(
      {required this.id,
      required this.name,
      required this.images,
      required this.promotionalPrice,
      required this.price,
      required this.idStatus});

  factory Product.fromJson(Map<String, dynamic> json) {
    List<ProductImage> imagesL = (json['list_image'] as List<dynamic>)
        .map((imgJson) => ProductImage.fromJson(imgJson))
        .toList();
    return Product(
      id: json['id_product'].toString(),
      name: json['name_product'],
      images: imagesL,
      promotionalPrice:
          (json['promotional_price'] as double).toInt().toString(),
      price: (json['listed_price'] as double).toInt().toString(),
      idStatus: json['id_status_product'].toString(),
    );
  }
}
