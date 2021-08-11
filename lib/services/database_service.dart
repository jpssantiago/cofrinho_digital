import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '/models/user_model.dart';
import '/models/goal_model.dart';

class DatabaseService {
  static Database? _db;

  static Future<void> startDatabase() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'cofrinho_digital.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE users(name TEXT PRIMARY KEY)',
        );
        db.execute(
          'CREATE TABLE goals(id TEXT PRIMARY KEY, title TEXT, emoji TEXT, goal REAL, saved REAL, periods INTEGER, periodType TEXT, completedPeriods TEXT, periodValue REAL)',
        );
        return;
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
      List<GoalModel> goals = await loadGoals();
      return UserModel.fromMap(
        response[0],
        goals,
      );
    }

    return null;
  }

  static Future<void> deleteUser() async {
    await _db?.delete('users');
    await _db?.delete('goals');
  }

  static Future<void> saveUser(UserModel newUser) async {
    await _db?.update(
      'users',
      {
        'name': newUser.name,
      },
    );
  }

  static Future<void> addGoal(GoalModel goal) async {
    await _db?.insert(
      'goals',
      goal.toMap(),
    );
  }

  static Future<List<GoalModel>> loadGoals() async {
    List<GoalModel> goals = [];

    final response = await _db?.query('goals');
    if (response != null) {
      for (var item in response) {
        goals.add(GoalModel.fromMap(item));
      }
    }

    return goals;
  }

  static Future<void> deleteGoal(GoalModel goal) async {
    await _db?.delete('goals', where: 'id = ?', whereArgs: [goal.id]);
  }

  static Future<void> saveGoal(GoalModel goal) async {
    await _db?.update(
      'goals',
      {
        'saved': goal.saved,
        'completedMonths': goal.completedMonthsToJson(),
      },
      where: 'id = ?',
      whereArgs: [goal.id],
    );
  }
}
