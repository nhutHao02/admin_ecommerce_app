import 'package:admin_ecommerce_app/shared/constants.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class OrderDetailCard extends StatelessWidget {
  const OrderDetailCard({required this.title, required this.values, super.key});

  final String title;
  final Map<String, dynamic> values;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: colorSecondary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 2),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...values.entries.mapIndexed((index, entry) => Padding(
                      padding: EdgeInsets.only(bottom: index == values.length - 1 ? 0 : 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(entry.key.toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                          ),
                          Expanded(
                            child: Text(
                              entry.value.toString(),
                              style: TextStyle(color: Colors.green.shade300, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
