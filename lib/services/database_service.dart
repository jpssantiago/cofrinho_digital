import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '/models/user_model.dart';

class DatabaseService {
  static Database? _db;

  static Future<void> startDatabase() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'cofrinho_digital.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(name TEXT PRIMARY KEY)',
        );
      },
      version: 1,
    );
  }

  static Future<void> createUser(UserModel user) async {
    await _db?.insert(
      'users',
      UserModel.toMap(user),
    );
  }

  static Future<UserModel?> loadUser() async {
    final response = await _db?.query('users');

    if (response != null && response.isNotEmpty) {
      return UserModel.fromMap(response[0]);
    }

    return null;
  }

  static Future<void> deleteUser() async {
    await _db?.delete('users');
  }
}
