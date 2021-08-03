import 'package:flutter/material.dart';

import '/models/goal_model.dart';

class UserModel {
  String name;
  List<GoalModel> goals;

  UserModel({
    required this.name,
    required this.goals,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      goals: [
        GoalModel(title: 'Viajem as Bahamas', icon: Icons.ac_unit),
      ],
    );
  }

  static Map<String, dynamic> toMap(UserModel user) {
    return {
      'name': user.name,
    };
  }
}
