import 'package:admin_ecommerce_app/models/product.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:admin_ecommerce_app/shared/utils.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(this.product, {required this.onEdit, required this.onDelete, super.key});

  final Product product;
  final void Function(String) onEdit;
  final void Function(String) onDelete;

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
                      image: DecorationImage(image: AssetImage(product.images!.first), fit: BoxFit.cover),
                    ),
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert_rounded, color: colorSecondary),
                    color: colorSecondary,
                    itemBuilder: (context) => [
                      PopupMenuItem(onTap: () => onEdit(product.id!), value: 1, child: const Text('Edit')),
                      PopupMenuItem(onTap: () => onDelete(product.id!), value: 2, child: const Text('Delete', style: TextStyle(color: Colors.red))),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${product.name}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 10),
                    Text(
                      '${product.price} VNĐ',
                      style: const TextStyle(color: Colors.red, fontSize: 18),
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
