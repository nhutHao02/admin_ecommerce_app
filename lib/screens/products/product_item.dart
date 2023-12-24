import 'package:admin_ecommerce_app/models/product.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:admin_ecommerce_app/shared/utils.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(this.product,
      {required this.onEdit, required this.onDelete, super.key});

  final Product product;
  final void Function(String) onDelete;
  final void Function(String) onEdit;

  @override
  Widget build(BuildContext context) {
    final Size size = getScreenSize(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    height: size.width * .5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: NetworkImage(
                              product.images.elementAt(0).pathImage.toString()),
                          fit: BoxFit.cover),
                    ),
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert_rounded,
                        color: colorSecondary),
                    color: colorSecondary,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                          onTap: () => onEdit(product.id!),
                          value: 1,
                          child: const Text('Sửa')),
                      PopupMenuItem(
                          onTap: () => onDelete(product.id!),
                          value: 2,
                          child: const Text('Xóa',
                              style: TextStyle(color: Colors.red))),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${product.name}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 10),
                    Row(children: [
                      const Text('Size:', style: TextStyle(fontSize: 15)),
                      const SizedBox(width: 5),
                      const Text('39', style: TextStyle(fontSize: 15)),
                      const SizedBox(width: 5),
                      const Text('40', style: TextStyle(fontSize: 15)),
                      const SizedBox(width: 5),
                      const Text('41', style: TextStyle(fontSize: 15)),
                      const SizedBox(width: 5),
                      const Text('42', style: TextStyle(fontSize: 15)),
                      IconButton(
                        icon: const Icon(Icons.more_horiz),
                        tooltip: 'Chi tiết size',
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("Sizes"),
                                    content: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('42 x 2'),
                                        Text('42 x 2'),
                                        Text('42 x 2'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              {Navigator.pop(context)},
                                          child: const Text('Đóng'))
                                    ],
                                  ));
                        },
                      )
                    ]),
                    Text(
                      'Giá khuyến mãi: ${product.promotionalPrice} VNĐ',
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    Text(
                      'Giá niêm yết: ${product.price} VNĐ',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
