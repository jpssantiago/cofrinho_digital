import 'package:flutter/material.dart';

import '/widgets/custom_app_bar.dart';
import 'widgets/goal_value_section.dart';
import 'widgets/monthly_value_section.dart';
import 'widgets/months_section.dart';

class GoalDetailsPage extends StatefulWidget {
  const GoalDetailsPage({Key? key}) : super(key: key);

  @override
  State<GoalDetailsPage> createState() => _GoalDetailsPageState();
}

class _GoalDetailsPageState extends State<GoalDetailsPage> {
  double goalValue = 0;
  int months = 0;
  double monthlyValue = 0;

  @override
  Widget build(BuildContext context) {
    void handleGoalValueChange(double value) {
      setState(() {
        goalValue = value;

        if (months > 0) {
          monthlyValue = goalValue / months;
        }
      });
    }

    void handleMonthsChange(int value) {
      setState(() {
        months = value;

        if (goalValue > 0) {
          monthlyValue = goalValue / months;
        }
      });
    }

    void handleMonthlyValueChange(double value) {
      setState(() {
        monthlyValue = value;

        if (months > 0) {
          goalValue = monthlyValue * months;
        }
      });
    }

    // TODO: Adicionar botão de adicionar
    return Scaffold(
      appBar: CustomAppBar.buildWhiteAppBar(title: 'Etapa 3 de 3'),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            const SizedBox(height: 30),
            GoalValueSection(
              value: goalValue,
              onSubmit: handleGoalValueChange,
            ),
            const SizedBox(height: 30),
            MonthsSection(
              value: months,
              onSubmit: handleMonthsChange,
            ),
            const SizedBox(height: 30),
            MonthlyValueSection(
              value: monthlyValue,
              onSubmit: handleMonthlyValueChange,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTitle() {
  return const Text(
    'Para finalizar, precisamos saber algumas outras informações.',
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}
