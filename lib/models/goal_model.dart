class GoalModel {
  String id;
  String title;
  String emoji;
  double goal;
  double saved;
  int months;
  List<int> completedMonths;
  double monthlyValue;

  GoalModel({
    required this.id,
    required this.title,
    required this.emoji,
    required this.goal,
    required this.saved,
    required this.months,
    required this.completedMonths,
    required this.monthlyValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'emoji': emoji,
      'goal': goal,
      'saved': saved,
      'months': months,
      'monthlyValue': monthlyValue,
    };
  }

  static List<int> monthsFromJson(var json) {
    return [];
  }

  static GoalModel fromMap(Map<String, dynamic> map) {
    return GoalModel(
      id: map['id'],
      title: map['title'],
      emoji: map['emoji'],
      goal: map['goal'],
      saved: map['saved'],
      months: map['months'],
      completedMonths: monthsFromJson(''),
      monthlyValue: map['monthlyValue'],
    );
  }
}
