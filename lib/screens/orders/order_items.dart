import 'package:admin_ecommerce_app/models/order_detail.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';

class OrderItems extends StatelessWidget {
  const OrderItems(this.orderDetail, {super.key});

  final OrderDetail orderDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: colorSecondary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Text('Sản phẩm',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 2),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(defaultPadding),
                  child:
                      Image.network(orderDetail.listImageProduct[0].pathImage),
                ),
                const SizedBox(height: 20),
                dataRow('Mã sản phẩm', orderDetail.idProduct.toString()),
                dataRow('Tên sản phẩm', orderDetail.nameProduct.toString()),
                dataRow('Size', orderDetail.nameSize.toString()),
                dataRow('Số lượng', orderDetail.quantity.toString()),
                dataRow('Giá', '${orderDetail.price.toString()} VNĐ'),
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
            child: Text(cell1,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
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
