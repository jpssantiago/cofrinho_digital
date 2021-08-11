class GoalModel {
  String id;
  String title;
  String emoji;
  double goal;
  double saved;
  int periods;
  String periodType;
  List<int> completedPeriods;
  double periodValue;

  GoalModel({
    required this.id,
    required this.title,
    required this.emoji,
    required this.goal,
    required this.saved,
    required this.periods,
    required this.periodType,
    required this.completedPeriods,
    required this.periodValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'emoji': emoji,
      'goal': goal,
      'saved': saved,
      'periods': periods,
      'periodType': periodType,
      'periodValue': periodValue,
      'completedMonths': completedMonthsToJson(),
    };
  }

  String completedMonthsToJson() {
    String str = '';

    for (int index in completedPeriods) {
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
    return GoalModel(
      id: map['id'],
      title: map['title'],
      emoji: map['emoji'],
      goal: map['goal'],
      saved: map['saved'],
      periods: map['periods'],
      periodType: map['periodType'],
      completedPeriods: completedMonthsFromJson(map['completedMonths']),
      periodValue: map['periodValue'],
    );
  }
}
