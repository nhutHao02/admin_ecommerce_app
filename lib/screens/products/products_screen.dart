import 'dart:convert';
import 'package:admin_ecommerce_app/models/product.dart';
import 'package:admin_ecommerce_app/screens/products/product_add.dart';
import 'package:admin_ecommerce_app/screens/products/product_edit.dart';
import 'package:admin_ecommerce_app/screens/products/product_item.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:number_paginator/number_paginator.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late List<Product> products = [];

  var selectedPageNumber = 0;
  var total_pages = 0;
  var isLoading = false;

  void addProduct() {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProductAddScreen()))
        .then((result) {
      if (result != null && result is bool) {
        if (result) {
          setState(() {
            fetchProduct(selectedPageNumber + 1);
          });
        }
      }
    });
  }

  void editProduct(id) {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductEditScreen(id)))
        .then((result) {
      if (result != null && result is bool) {
        if (result) {
          setState(() {
            fetchProduct(selectedPageNumber + 1);
          });
        }
      }
    });
  }

  void deleteProduct(id) async {
    setState(() async {
      if (await deleteProductAPI(id)) {
        fetchProduct(selectedPageNumber + 1);
      }
    });
  }

  Future<bool> deleteProductAPI(id) async {
    print('deleteProductAPI using');
    const url =
        'http://tranhao123-001-site1.etempurl.com/api/products/delete-product';
    final uri = Uri.parse(url);
    final response = await http.delete(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"id_product": id}));
    if (response.statusCode == 200) {
      print('deleteProductAPI Success........');
      return true;
    } else {
      print('deleteProductAPI failed with status: ${response.statusCode}.');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }

  void fetchProduct(page) async {
    isLoading = true;
    print('fetchProduct using');
    String url =
        'http://tranhao123-001-site1.etempurl.com/api/products/list-all-products?page=$page&pageSize=9';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      total_pages = json['total_pages'];
      final List<dynamic> jsonDataList = json['data'];
      products = jsonDataList.map((jsonItem) {
        return Product.fromJson(jsonItem);
      }).toList();
      isLoading = false;
      print('fetch fisnished');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProduct("1");
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [addProductButton(onPressed: addProduct)]),
                Column(children: [
                  for (final product in products)
                    ProductItem(product,
                        onEdit: editProduct, onDelete: deleteProduct),
                  NumberPaginator(
                    initialPage: selectedPageNumber,
                    numberPages: total_pages,
                    onPageChange: (pageValue) {
                      setState(() {
                        selectedPageNumber = pageValue;
                        fetchProduct(pageValue + 1);
                      });
                    },
                    config: const NumberPaginatorUIConfig(
                      height: 48,
                      buttonSelectedForegroundColor: Colors.black,
                      buttonSelectedBackgroundColor: colorPrimary,
                    ),
                  ),
                ])
              ],
            ),
          );
  }
}

Widget addProductButton({onPressed}) => ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          colorPrimary,
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        iconColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: const Text(
        'Thêm sản phẩm',
        style: TextStyle(color: Colors.white),
      ),
    );
