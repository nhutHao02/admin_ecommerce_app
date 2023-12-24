import 'dart:convert';

import 'package:admin_ecommerce_app/models/order.dart';
import 'package:admin_ecommerce_app/screens/orders/order_detail_screen.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:number_paginator/number_paginator.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late List<Order> orders = [];

  final orderStatus = [
    'Tất cả',
    'Chờ xác nhận',
    'Đã xác nhận',
    'Cho lấy hàng',
    'Đang giao hàng',
    'Trả hàng',
    'Hủy đơn hàng'
  ];
  var selectedPageNumber = 0;
  var total_pages = 0;
  var isLoading = false;
  var selectedOrderStatus = '';

  void fetchOrder(page) async {
    isLoading = true;
    print('fetchOrder using');
    String url =
        'http://tranhao123-001-site1.etempurl.com/api/order/list-all-orders?page=$page&pageSize=9';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      total_pages = json['total_pages'];
      final List<dynamic> jsonDataList = json['data'];
      orders = jsonDataList.map((jsonItem) {
        return Order.fromJson(jsonItem);
      }).toList();
      isLoading = false;
      print('fetchOrder fisnished');
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case '1':
        return Colors.yellow.shade400;
      case '2':
        return Colors.lightBlueAccent.shade200;
      case '3':
        return Color.fromARGB(255, 19, 237, 52);
      case '4':
        return Color.fromARGB(255, 230, 0, 255);
      case '5':
        return Color.fromARGB(255, 0, 255, 251);
      case '6':
        return Color.fromARGB(255, 255, 0, 0);
      case '7':
        return Colors.orange.shade200;
      default:
        return Colors.black;
    }
  }

  @override
  void initState() {
    selectedOrderStatus = orderStatus.first;
    super.initState();
    fetchOrder("1");
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton<String>(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          underline: const SizedBox(),
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          value: selectedOrderStatus,
                          items: orderStatus
                              .map<DropdownMenuItem<String>>((status) =>
                                  DropdownMenuItem(
                                      value: status, child: Text(status)))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedOrderStatus = value!),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingTextStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        showCheckboxColumn: false,
                        columns: const [
                          DataColumn(label: Text('Mã đơn')),
                          DataColumn(label: Text('Tên khách hàng')),
                          DataColumn(label: Text('SĐT')),
                          DataColumn(label: Text('Ngày đặt')),
                          DataColumn(label: Text('Trạng thái')),
                        ],
                        rows: List<DataRow>.generate(
                          orders.length,
                          (int index) => DataRow(
                            cells: [
                              DataCell(Text(orders[index].orderId ?? 'Lỗi')),
                              DataCell(Text(orders[index].nameCus ?? 'Lỗi')),
                              DataCell(Text(orders[index].phone ?? 'Lỗi')),
                              DataCell(Text(orders[index].timeOrder ?? 'Lỗi')),
                              DataCell(
                                  Text(orders[index].nameStatusOrder ?? 'Lỗi',
                                      style: TextStyle(
                                        color: getStatusColor(orders[index]
                                            .statusOrder
                                            .toString()),
                                      ))),
                            ],
                            onSelectChanged: (value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OrderDetailScreen(orders[index])));
                            },
                          ),
                        ),
                      ),
                    ),
                    NumberPaginator(
                      initialPage: selectedPageNumber,
                      numberPages: total_pages,
                      onPageChange: (pageValue) {
                        setState(() {
                          selectedPageNumber = pageValue;
                          fetchOrder(selectedPageNumber + 1);
                        });
                      },
                      config: const NumberPaginatorUIConfig(
                        height: 48,
                        buttonSelectedForegroundColor: Colors.black,
                        buttonSelectedBackgroundColor: colorPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
