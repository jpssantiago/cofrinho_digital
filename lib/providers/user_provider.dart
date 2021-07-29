import 'package:flutter/material.dart';

import '/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  Future<bool> createUser(String name) {
    _user = UserModel(name: name);

    return Future.delayed(const Duration(seconds: 2), () {
      return true;
    });
  }
}
