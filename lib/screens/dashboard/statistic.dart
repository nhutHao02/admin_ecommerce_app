import 'package:admin_ecommerce_app/models/statistic_value.dart';
import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Statistic extends StatelessWidget {
  Statistic({super.key});

  final statisticValues = [
    StatisticValue(title: 'Products', value: '55900', icon: 'assets/icons/ic_document.svg', color: Colors.blue),
    StatisticValue(title: 'Customers', value: '55900', icon: 'assets/icons/ic_document.svg', color: Colors.amber),
    StatisticValue(title: 'Orders', value: '55900', icon: 'assets/icons/ic_document.svg', color: Colors.green),
    StatisticValue(title: 'Incomes', value: '55900', icon: 'assets/icons/ic_document.svg', color: Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / .5,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding,
          ),
          itemBuilder: (context, index) => StatisticCard(statisticValues[index]),
        ),
      ],
    );
  }
}

class StatisticCard extends StatelessWidget {
  const StatisticCard(this.statistic, {super.key});

  final StatisticValue statistic;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
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
                    Text(statistic.title.toString()),
                    Text(statistic.value.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SvgPicture.asset(statistic.icon, height: 32, width: 32, colorFilter: ColorFilter.mode(statistic.color, BlendMode.srcIn))
            ],
          ),
        ),
      ),
    );
  }
}
