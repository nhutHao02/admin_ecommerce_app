import 'dart:convert';

import 'package:admin_ecommerce_app/models/statistic_value.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class Statistic extends StatefulWidget {
  const Statistic(this.onMenuSelected, {super.key});
  final void Function(String) onMenuSelected;

  @override
  State<Statistic> createState() => _statistic();
}

class _statistic extends State<Statistic> {
  var isLoading = false;
  var statisticValues = [
    StatisticValue(
        title: 'Sản phẩm',
        value: '55900',
        icon: 'assets/icons/menu_product.svg',
        color: Colors.blue,
        keyScreen: 'PR'),
    StatisticValue(
        title: 'Đơn hàng',
        value: '55900',
        icon: 'assets/icons/order.svg',
        color: Colors.amber,
        keyScreen: 'OR')
  ];

  void fetchProduct() async {
    isLoading = true;
    print('fetchProduct using');
    String url =
        'http://tranhao123-001-site1.etempurl.com/api/products/list-all-products?page=1&pageSize=1';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      statisticValues[0].value = json['total_items'].toString();
      isLoading = false;
      print('fetch fisnished');
    });
  }

  void fetchOrder() async {
    isLoading = true;
    print('fetchOrder using');
    String url =
        'http://tranhao123-001-site1.etempurl.com/api/order/list-all-orders?page=1&pageSize=1';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      statisticValues[1].value = json['total_items'].toString();
      isLoading = false;
      print('fetchOrder fisnished');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProduct();
    fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / .5,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding,
          ),
          itemBuilder: (context, index) => isLoading
              ? const SizedBox(
                  child: Center(child: CircularProgressIndicator()))
              : StatisticCard(widget.onMenuSelected, statisticValues[index]),
        ),
      ],
    );
  }
}

class StatisticCard extends StatelessWidget {
  const StatisticCard(this.onMenuSelected, this.statistic, {super.key});

  final StatisticValue statistic;
  final void Function(String) onMenuSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onMenuSelected(statistic.keyScreen),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      statistic.title.toString(),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      statistic.value.toString(),
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              SvgPicture.asset(statistic.icon,
                  height: 50,
                  width: 50,
                  colorFilter:
                      ColorFilter.mode(statistic.color, BlendMode.srcIn))
            ],
          ),
        ),
      ),
    );
  }
}
