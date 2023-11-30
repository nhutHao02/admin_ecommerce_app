import 'package:admin_ecommerce_app/models/address.dart';
import 'package:admin_ecommerce_app/models/order_item.dart';
import 'package:admin_ecommerce_app/models/user.dart';

class Order {
  String? orderId;
  String? userId;
  double? totalPrice;
  String? orderDate;
  String? status;
  Address? shippingAddress;
  User? userInfo;
  List<OrderItem>? orderItems;

  Order({this.orderId, this.userId, this.totalPrice, this.orderDate, this.status, this.shippingAddress, this.userInfo, this.orderItems});

  Order.fromJson(Map<String, dynamic> jsonMap) {
    orderId = jsonMap['orderId'] ?? '';
    userId = jsonMap['userId'] ?? '';
    totalPrice = jsonMap['totalPrice'] ?? '';
    orderDate = jsonMap['orderDate'] ?? '';
    status = jsonMap['status'] ?? '';
    shippingAddress = Address.fromJson(jsonMap['shippingAddress']);
    userInfo = User.fromjson(jsonMap['userInfo']);
    List<OrderItem> orderItems = [];
    jsonMap['orderItems'].forEach((item) => orderItems.add(OrderItem.fromJson(item)));
    this.orderItems = orderItems;
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'totalPrice': totalPrice,
      'orderDate': orderDate,
      'status': status,
      'shippingAddress': shippingAddress?.toJson(),
      'userInfo': userInfo?.toJson(),
      'orderItems': [...orderItems!.map((e) => e.toJson())]
    };
  }
}
