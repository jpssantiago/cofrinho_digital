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

  static UserModel fromMap(Map<String, dynamic> map, List<GoalModel> goals) {
    return UserModel(
      name: map['name'],
      goals: goals,
    );
  }

  static Map<String, dynamic> toMap(UserModel user) {
    return {
      'name': user.name,
    };
  }
}

/*
// GoalModel(
        //   title: 'Celular novo',
        //   emoji: '📱',
        //   goal: 5000,
        //   saved: 500,
        //   monthlyValue: 500,
        //   months: 10,
        // ),
        // GoalModel(
        //   title: 'Viajem as Bahamas',
        //   emoji: '✈️',
        //   goal: 12000,
        //   saved: 3201,
        //   months: 12,
        //   monthlyValue: 1000,
        // ),
*/
