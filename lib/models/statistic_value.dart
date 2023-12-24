import 'package:flutter/material.dart';

class StatisticValue {
  StatisticValue(
      {required this.title,
      required this.value,
      required this.icon,
      required this.color,
      required this.keyScreen});
  String title, value, icon;
  Color color;
  String keyScreen;
}
