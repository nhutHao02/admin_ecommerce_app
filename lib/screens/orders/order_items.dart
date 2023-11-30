import 'package:admin_ecommerce_app/models/order.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class OrderItems extends StatelessWidget {
  const OrderItems(this.order, {super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: colorSecondary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Text('Order Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 2),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                ...order.orderItems!.mapIndexed(
                  (index, orderItem) => Column(
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(defaultPadding),
                            child: Image.asset(orderItem.image ?? 'assets/images/product_placeholder.jpg'),
                          ),
                          const SizedBox(height: 20),
                          dataRow('Product ID', orderItem.productId.toString()),
                          dataRow('Name', orderItem.name.toString()),
                          dataRow('Price', orderItem.price.toString()),
                          dataRow('Quantity', orderItem.quantity.toString()),
                        ],
                      ),
                      if (index < order.orderItems!.length - 1) const Column(children: [Divider(height: 2), SizedBox(height: 20)])
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dataRow(String cell1, String cell2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(cell1, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Text(
              cell2,
              style: TextStyle(color: Colors.green.shade300, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
