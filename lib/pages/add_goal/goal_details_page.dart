import 'package:cofrinho_digital/pages/add_goal/widgets/period_selector_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '/widgets/custom_app_bar.dart';
import 'widgets/goal_value_section.dart';
import 'widgets/period_value_section.dart';
import 'widgets/periods_section.dart';
import '/providers/user_provider.dart';
import '/utils/snackbar_utils.dart';
import '/models/goal_model.dart';
import '/models/goal_category_model.dart';

class GoalDetailsPage extends StatefulWidget {
  const GoalDetailsPage({Key? key}) : super(key: key);

  @override
  State<GoalDetailsPage> createState() => _GoalDetailsPageState();
}

class _GoalDetailsPageState extends State<GoalDetailsPage> {
  // TODO: Adicionar opção de escolher dias ou semanas (não só meses).
  double goalValue = 0;
  int periods = 0;
  String periodType = 'months';
  double periodValue = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);
    final args = ModalRoute.of(context)!.settings.arguments;
    final GoalCategoryModel category = args as GoalCategoryModel;

    void handleGoalValueChange(double value) {
      setState(() {
        goalValue = value;

        if (periods > 0) {
          periodValue = goalValue / periods;
        }
      });
    }

    void handleMonthsChange(int value) {
      setState(() {
        periods = value;

        if (goalValue > 0) {
          periodValue = goalValue / periods;
        }
      });
    }

    void handleperiodValueChange(double value) {
      setState(() {
        periodValue = value;

        if (periods > 0) {
          goalValue = periodValue * periods;
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

      if (goalValue < 1 || periods < 1 || periodValue < 1) {
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
          periods: periods,
          periodType: periodType,
          completedPeriods: [],
          periodValue: periodValue,
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
                  PeriodSection(
                    value: periods,
                    onSubmit: handleMonthsChange,
                    periodType: periodType,
                  ),
                  const SizedBox(height: 30),
                  PeriodValueSection(
                    value: periodValue,
                    onSubmit: handleperiodValueChange,
                    periodType: periodType,
                  ),
                  const SizedBox(height: 30),
                  PeriodSelectorSection(
                    selectedPeriodType: periodType,
                    onSelectPeriodType: (String value) {
                      setState(() {
                        periodType = value;
                      });
                    },
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
