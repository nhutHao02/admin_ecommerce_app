import 'package:admin_ecommerce_app/models/order.dart';
import 'package:admin_ecommerce_app/screens/orders/order_details.dart';
import 'package:admin_ecommerce_app/screens/orders/order_items.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen(this.order, {super.key});

  final Order order;

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
        title: const Text('Detail Order'),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OrderDetailCard(
                    title: 'Details',
                    values: {
                      'Order ID': order.orderId.toString(),
                      'User ID': order.userId.toString(),
                      'Status': order.status.toString(),
                      'Order Date': order.orderDate.toString(),
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  OrderDetailCard(
                    title: 'User Information',
                    values: {
                      'User ID': order.userInfo?.userId.toString(),
                      'Name': order.userInfo?.name.toString(),
                      'Email': order.userInfo?.email.toString(),
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  OrderDetailCard(
                    title: 'Shiping Address',
                    values: {
                      'ID': order.shippingAddress?.id.toString(),
                      'City': order.shippingAddress?.city.toString(),
                      'Country': order.shippingAddress?.country.toString(),
                      'State': order.shippingAddress?.state.toString(),
                      'Postcode': order.shippingAddress?.postcode.toString(),
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  OrderItems(order)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
