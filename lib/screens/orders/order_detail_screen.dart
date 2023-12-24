import 'dart:convert';

import 'package:admin_ecommerce_app/models/order.dart';
import 'package:admin_ecommerce_app/models/order_detail.dart';
import 'package:admin_ecommerce_app/screens/orders/order_details.dart';
import 'package:admin_ecommerce_app/screens/orders/order_items.dart';
import 'package:http/http.dart' as http;
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen(this.order, {super.key});

  final Order order;
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late List<OrderDetail> orderDetails;
  var isLoading = false;

  late var totalPrice;
  late var totalProductPrice;
  late var deliveryPrice;

  void fetchOrderDetail(id) async {
    isLoading = true;
    print('fetchOrderDetail using');
    String url =
        'http://tranhao123-001-site1.etempurl.com/api/order/infor-order?id_order=$id';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      totalPrice = (json['data']['order_value'] as double).toInt().toString();
      totalProductPrice =
          (json['data']['total_price'] as double).toInt().toString();
      deliveryPrice = (json['data']['ship_price'] as double).toInt().toString();
      final List<dynamic> jsonDataList = json['data']['order_details'];
      orderDetails = jsonDataList.map((jsonItem) {
        return OrderDetail.fromJson(jsonItem);
      }).toList();
      isLoading = false;
      print('fetchOrderDetail fisnished');
      print(widget.order.timeOrder.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrderDetail(widget.order.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(defaultPadding / 2),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back),
          ),
        ),
        title: const Text('Chi tiết đơn hàng'),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const SizedBox(child: Center(child: CircularProgressIndicator()))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OrderDetailCard(
                          title: 'Thông tin đơn hàng',
                          values: {
                            'Mã đơn hàng': widget.order.orderId.toString(),
                            'Địa chỉ': widget.order.address.toString(),
                            'Ngày đặt hàng': widget.order.timeOrder.toString(),
                            'Trạng thái đơn hàng':
                                widget.order.nameStatusOrder.toString(),
                            'Phí vận chuyển': '${deliveryPrice.toString()} VNĐ',
                            'Tổng tiền hàng':
                                '${totalProductPrice.toString()} VNĐ',
                            'Tổng tiền': '${totalPrice.toString()} VNĐ',
                          },
                        ),
                        const SizedBox(height: defaultPadding),
                        OrderDetailCard(
                          title: 'Thông tin khách hàng',
                          values: {
                            'Tên khách hàng': widget.order.nameCus.toString(),
                            'SĐT': widget.order.phone.toString(),
                            'Email': 'abc@example.com',
                          },
                        ),
                        const SizedBox(height: defaultPadding),
                        ...orderDetails.map((orderDetail) {
                          return Column(
                            children: [
                              OrderItems(orderDetail),
                              const SizedBox(height: defaultPadding),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
