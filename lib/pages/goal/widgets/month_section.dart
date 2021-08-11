import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/goal_model.dart';
import '/providers/user_provider.dart';
import '/utils/snackbar_utils.dart';

import 'month_item.dart';

class MonthSection extends StatelessWidget {
  final GoalModel goal;

  const MonthSection({
    Key? key,
    required this.goal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildChildren(UserProvider provider) {
      List<Widget> list = [];

      for (int i = 0; i < goal.periods; i++) {
        bool completed = provider.hasCompletedPeriod(goal, i);

        list.add(
          MonthItem(
            index: i,
            value: goal.periodValue,
            completed: completed,
            onTap: (int index) {
              provider.toggleCompletedPeriod(goal, index);

              if (goal.completedPeriods.length == goal.periods) {
                SnackbarUtils.showMessage(
                  context: context,
                  message: 'Você completou este objetivo com sucesso!',
                );
              }
            },
          ),
        );
      }

      return list;
    }

    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: _buildChildren(provider),
          ),
        );
      },
    );
  }
}
