import 'package:flutter/material.dart';

class GoalModel {
  String title;
  IconData icon;
  double goal;
  double value;

  GoalModel({
    required this.title,
    required this.icon,
    required this.goal,
    required this.value,
  });
}
