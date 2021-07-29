import 'package:flutter/material.dart';

import '/models/user_model.dart';
import '/services/database_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  Future<bool> createUser(String name) async {
    UserModel newUser = UserModel(name: name);
    _user = newUser;

    await DatabaseService.createUser(newUser);
    return true;
  }

  Future<void> loadUser() async {
    _user = await DatabaseService.loadUser();
  }

  bool userExists() {
    return user != null;
  }
}

// TODO: Salvar isso aqui em um banco local.
// return Future.delayed(const Duration(seconds: 2), () {
//   return true;
// });
