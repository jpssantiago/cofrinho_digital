import '/models/goal_model.dart';

class UserModel {
  String name;
  List<GoalModel> goals;

  UserModel({
    required this.name,
    required this.goals,
  });

  double getTotalSaved() {
    double saved = 0;

    for (GoalModel goal in goals) {
      saved += goal.saved;
    }

    return saved;
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      goals: [
        GoalModel(
          title: 'Celular novo',
          emoji: '📱',
          goal: 5000,
          saved: 300,
        ),
        GoalModel(
          title: 'Viajem as Bahamas',
          emoji: '✈️',
          goal: 12000,
          saved: 3201,
        ),
      ],
    );
  }

  static Map<String, dynamic> toMap(UserModel user) {
    return {
      'name': user.name,
    };
  }
}
