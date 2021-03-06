import 'package:flutter/material.dart';

import '/models/goal_model.dart';
import '/utils/money_utils.dart';

class HeaderSection extends StatelessWidget {
  final GoalModel goal;

  const HeaderSection({
    Key? key,
    required this.goal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildIcon() {
      double value = goal.saved / goal.goal;

      return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: value,
                color: Theme.of(context).primaryColor,
                backgroundColor: const Color(0xFFE7E7E7),
              ),
            ),
            Text(
              goal.emoji,
              style: const TextStyle(
                fontSize: 36,
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildTitle() {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          goal.title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }

    Widget _buildValueRow() {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              MoneyUtils.formatMoney(goal.saved) + '/',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              MoneyUtils.formatMoney(goal.goal).replaceFirst('R\$ ', ''),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildDescription() {
      String getPeriodPlural() {
        if (goal.periodType == 'days') {
          return 'dias';
        } else if (goal.periodType == 'weeks') {
          return 'semanas';
        }

        return 'meses';
      }

      String getPeriodSingular() {
        if (goal.periodType == 'days') {
          return 'dia';
        } else if (goal.periodType == 'weeks') {
          return 'semana';
        }

        return 'm??s';
      }

      int remainingPeriods = goal.periods - goal.completedPeriods.length;
      String defaultText =
          '$remainingPeriods ${getPeriodPlural()} restantes - ${MoneyUtils.formatMoney(goal.periodValue)} por ${getPeriodSingular()}';
      String completedText = 'Parab??ns, voc?? completou este objetivo!';

      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          remainingPeriods == 0 ? completedText : defaultText,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF525252),
          ),
        ),
      );
    }

    return Column(
      children: [
        _buildIcon(),
        _buildTitle(),
        _buildValueRow(),
        _buildDescription(),
      ],
    );
  }
}
