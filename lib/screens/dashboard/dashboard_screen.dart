import 'package:admin_ecommerce_app/screens/dashboard/orders_pie_chart.dart';
import 'package:admin_ecommerce_app/screens/dashboard/statistic.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

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
              Statistic(),
              const SizedBox(height: defaultPadding),
              OrdersPieChart(),
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
