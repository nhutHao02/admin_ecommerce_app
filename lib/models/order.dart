import 'package:intl/intl.dart';

class Order {
  String? orderId;
  String? nameCus;
  String? address;
  String? phone;
  String? timeOrder;
  String? statusOrder;
  String? nameStatusOrder;
  Order(
      {this.orderId,
      this.nameCus,
      this.address,
      this.phone,
      this.timeOrder,
      this.statusOrder,
      this.nameStatusOrder});
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['id_order'].toString(),
      nameCus: json['name_customer'],
      address: json['address'],
      phone: json['phone'],
      timeOrder: DateFormat('dd-MM-yyyy HH:mm:ss')
          .format(DateTime.parse(json['time_order'])),
      statusOrder: json['status_order'].toString(),
      nameStatusOrder: json['name_status_order'],
    );
  }
}
