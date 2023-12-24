// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:admin_ecommerce_app/screens/dashboard/orders_pie_chart.dart';
import 'package:admin_ecommerce_app/screens/dashboard/statistic.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';

class DashboardScreen extends StatefulWidget {
  final void Function(String) onMenuSelected;

  const DashboardScreen(this.onMenuSelected, {super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            children: [
              Statistic(widget.onMenuSelected),
              const SizedBox(height: defaultPadding),
              OrdersPieChart(),
            ],
          ),
          if (isLoading) const CircularProgressIndicator()
        ],
      ),
    );
  }
}
