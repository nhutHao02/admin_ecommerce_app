import 'package:admin_ecommerce_app/models/image_product.dart';

class OrderDetail {
  int idProduct;
  String nameProduct;
  List<ProductImage> listImageProduct;
  String nameSize;
  int quantity;
  int price;

  OrderDetail({
    required this.idProduct,
    required this.nameProduct,
    required this.listImageProduct,
    required this.nameSize,
    required this.quantity,
    required this.price,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      idProduct: json['id_product'],
      nameProduct: json['name_product'],
      listImageProduct: (json['list_image_product'] as List<dynamic>)
          .map((imageJson) => ProductImage.fromJson(imageJson))
          .toList(),
      nameSize: json['name_size'],
      quantity: json['quantity'],
      price: (json['price'] as double).toInt(),
    );
  }
}
