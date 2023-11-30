import 'package:admin_ecommerce_app/models/product.dart';
import 'package:admin_ecommerce_app/screens/products/product_item.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var products = <Product>[
    Product(
      id: '1',
      description: 'Product 1',
      images: ['assets/images/product_placeholder.jpg'],
      isfavorite: false,
      name: 'Product 1',
      price: '10000',
    ),
    Product(
      id: '2',
      description: 'Product 2',
      images: ['assets/images/product_placeholder.jpg'],
      isfavorite: false,
      name: 'Product 2',
      price: '10000',
    ),
    Product(
      id: '3',
      description: 'Product 3',
      images: ['assets/images/product_placeholder.jpg'],
      isfavorite: false,
      name: 'Product 3',
      price: '10000',
    ),
  ];

  var isLoading = false;

  void addProduct() {}

  void editProduct(id) {}

  void deleteProduct(id) {
    setState(() {
      products.removeWhere((product) => product.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [addProductButton(onPressed: addProduct)]),
                Column(children: [for (final product in products) ProductItem(product, onEdit: editProduct, onDelete: deleteProduct)])
              ],
            ),
          );
  }
}

Widget addProductButton({onPressed}) => ElevatedButton.icon(
      style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding / 2)),
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: const Text('Add Product'),
    );
