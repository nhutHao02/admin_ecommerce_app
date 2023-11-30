import 'package:admin_ecommerce_app/models/address.dart';
import 'package:admin_ecommerce_app/models/order_item.dart';
import 'package:admin_ecommerce_app/models/order.dart';
import 'package:admin_ecommerce_app/models/user.dart';
import 'package:admin_ecommerce_app/screens/orders/order_detail_screen.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final orders = [
    Order(
      orderId: '98403',
      orderItems: [
        OrderItem(productId: '1111', name: 'Product 1', image: 'assets/images/demo.jpg', price: '14000'),
        OrderItem(productId: '2222', name: 'Product 2', image: 'assets/images/demo.jpg', price: '14000'),
        OrderItem(productId: '3333', name: 'Product 3', image: 'assets/images/demo.jpg', price: '14000'),
      ],
      userId: '1111',
      orderDate: '26/11/2023',
      userInfo: User(email: 'user1@gmail.com', name: 'user1', pic: '', userId: '111'),
      shippingAddress: Address(),
      status: 'packaging',
      totalPrice: 12000,
    ),
    Order(
      orderId: '86331',
      orderItems: [
        OrderItem(productId: '1111', name: 'Product 1', image: 'assets/images/demo.jpg', price: '14000'),
        OrderItem(productId: '2222', name: 'Product 2', image: 'assets/images/demo.jpg', price: '14000'),
        OrderItem(productId: '3333', name: 'Product 3', image: 'assets/images/demo.jpg', price: '14000'),
      ],
      userId: '2222',
      orderDate: '26/11/2023',
      userInfo: User(email: 'user2@gmail.com', name: 'user2', pic: '', userId: '222'),
      shippingAddress: Address(),
      status: 'delivered',
      totalPrice: 12000,
    ),
    Order(
      orderId: '73229',
      orderItems: [
        OrderItem(productId: '1111', name: 'Product 1', image: 'assets/images/demo.jpg', price: '14000'),
        OrderItem(productId: '2222', name: 'Product 2', image: 'assets/images/demo.jpg', price: '14000'),
        OrderItem(productId: '3333', name: 'Product 3', image: 'assets/images/demo.jpg', price: '14000'),
      ],
      userId: '3333',
      orderDate: '26/11/2023',
      userInfo: User(email: 'user3@gmail.com', name: 'user3', pic: '', userId: '333'),
      shippingAddress: Address(),
      status: 'canceled',
      totalPrice: 12000,
    ),
  ];

  final orderStatus = ['All', 'Packaging', 'Deliverd', 'Completed', 'Canceled'];

  var isLoading = false;
  var selectedOrderStatus = '';

  @override
  void initState() {
    selectedOrderStatus = orderStatus.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    underline: const SizedBox(),
                    borderRadius: BorderRadius.circular(defaultPadding / 2),
                    value: selectedOrderStatus,
                    items: orderStatus.map<DropdownMenuItem<String>>((status) => DropdownMenuItem(value: status, child: Text(status))).toList(),
                    onChanged: (value) => setState(() => selectedOrderStatus = value!),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                  showCheckboxColumn: false,
                  columns: const [
                    DataColumn(label: Text('Order ID')),
                    DataColumn(label: Text('User ID')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Total Price')),
                    DataColumn(label: Text('Order Date')),
                  ],
                  rows: List<DataRow>.generate(
                    orders.length,
                    (int index) => DataRow(
                      cells: [
                        DataCell(Text(orders[index].orderId ?? 'Error')),
                        DataCell(Text(orders[index].userId ?? 'Error')),
                        DataCell(Text(
                          orders[index].status ?? 'Error',
                          style: TextStyle(
                              color: orders[index].status.toString() == 'packaging'
                                  ? Colors.yellow.shade400
                                  : orders[index].status.toString() == 'delivered'
                                      ? Colors.lightBlueAccent.shade200
                                      : orders[index].status.toString() == 'completed'
                                          ? Colors.green.shade400
                                          : Colors.red.shade400),
                        )),
                        DataCell(Text(orders[index].totalPrice != null ? '${orders[index].totalPrice.toString()} VNĐ' : 'Error')),
                        DataCell(Text(orders[index].orderDate ?? 'Error')),
                      ],
                      onSelectChanged: (value) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailScreen(orders[index])));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isLoading) const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
