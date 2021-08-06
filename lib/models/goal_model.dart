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
      'completedMonths': completedMonthsToJson(),
    };
  }

  String completedMonthsToJson() {
    String str = '';

    for (int index in completedMonths) {
      str += '$index,';
    }

    return str;
  }

  static List<int> completedMonthsFromJson(String str) {
    List<int> list = [];

    if (str.contains(',')) {
      List<String> data = str.split(',');

      for (String item in data) {
        if (item != "") {
          list.add(int.parse(item.replaceAll(',', '')));
        }
      }
    }

    return list;
  }

  static GoalModel fromMap(Map<String, dynamic> map) {
    // print(map['completedMonths']);
    return GoalModel(
      id: map['id'],
      title: map['title'],
      emoji: map['emoji'],
      goal: map['goal'],
      saved: map['saved'],
      months: map['months'],
      completedMonths: completedMonthsFromJson(map['completedMonths']),
      monthlyValue: map['monthlyValue'],
    );
  }
}
