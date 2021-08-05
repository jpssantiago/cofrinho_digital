import 'package:flutter/material.dart';

import 'package:cofrinho_digital/models/goal_model.dart';

import 'month_item.dart';

class MonthSection extends StatelessWidget {
  final GoalModel goal;

  const MonthSection({
    Key? key,
    required this.goal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildChildren() {
      List<Widget> list = [];

      for (int i = 0; i < goal.months; i++) {
        // TODO: Marcar como concluído ou não concluído os meses.
        bool completed = false;

        list.add(
          MonthItem(
            index: i,
            value: goal.monthlyValue,
            completed: completed,
            onTap: (int index) {},
          ),
        );
      }

      return list;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: _buildChildren(),
      ),
    );
  }
}
