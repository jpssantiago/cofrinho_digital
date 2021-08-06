import 'package:cofrinho_digital/models/goal_category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '/widgets/custom_app_bar.dart';
import 'widgets/goal_value_section.dart';
import 'widgets/monthly_value_section.dart';
import 'widgets/months_section.dart';
import '/providers/user_provider.dart';
import '/utils/snackbar_utils.dart';
import '/models/goal_model.dart';

class GoalDetailsPage extends StatefulWidget {
  const GoalDetailsPage({Key? key}) : super(key: key);

  @override
  State<GoalDetailsPage> createState() => _GoalDetailsPageState();
}

class _GoalDetailsPageState extends State<GoalDetailsPage> {
  double goalValue = 0;
  int months =
      0; // TODO: Adicionar opção de escolher dias ou semanas (não só meses).
  double monthlyValue = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);
    final args = ModalRoute.of(context)!.settings.arguments;
    final GoalCategoryModel category = args as GoalCategoryModel;

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

    void setLoading(bool value) {
      setState(() {
        loading = value;
      });
    }

    void handleSubmit() async {
      if (loading) return;

      if (goalValue < 1 || months < 1 || monthlyValue < 1) {
        SnackbarUtils.showMessage(
          context: context,
          message: 'Preencha os campos para continuar.',
        );
        return;
      }

      setLoading(true);

      await provider.addGoal(
        GoalModel(
          id: const Uuid().v4(),
          title: category.name,
          emoji: category.emoji,
          goal: goalValue,
          saved: 0,
          months: months,
          completedMonths: [],
          monthlyValue: monthlyValue,
        ),
      );

      Navigator.of(context).pushNamedAndRemoveUntil(
        '/main',
        (route) => false,
      );

      SnackbarUtils.showMessage(
        context: context,
        message: 'Objetivo adicionado com sucesso.',
      );

      setLoading(false);
    }

    return Scaffold(
      appBar: CustomAppBar.buildWhiteAppBar(title: 'Etapa 3 de 3'),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: ListView(
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
            _buildButton(
              onTap: handleSubmit,
              context: context,
              loading: loading,
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

Widget _buildButton({
  required VoidCallback onTap,
  required BuildContext context,
  required bool loading,
}) {
  Widget _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Criar objetivo',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        Image.asset('assets/icons/rocket.png', width: 24, height: 24),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: loading ? _buildLoading() : _buildRow(),
    ),
  );
}
