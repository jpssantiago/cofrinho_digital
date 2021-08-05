import 'package:flutter/material.dart';

import '/models/user_model.dart';
import '/models/goal_model.dart';
import '/services/database_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  Future<bool> createUser(String name) async {
    UserModel newUser = UserModel(name: name, goals: []);
    _user = newUser;

    await DatabaseService.createUser(newUser);
    return true;
  }

  Future<bool> loadUser() async {
    _user = await DatabaseService.loadUser();

    return _user != null;
  }

  Future<void> deleteUser() async {
    await DatabaseService.deleteUser();
    _user = null;
  }

  Future<void> updateUser(UserModel newUser) async {
    _user = newUser;
    await DatabaseService.saveUser(newUser);

    notifyListeners();
  }

  Future<void> addGoal(GoalModel goal) async {
    _user!.goals.add(goal);
    await DatabaseService.addGoal(goal);

    notifyListeners();
  }
}
