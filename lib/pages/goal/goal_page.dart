import 'package:flutter/material.dart';

import '/models/goal_model.dart';
import '/widgets/custom_app_bar.dart';

import 'widgets/header_section.dart';
import 'widgets/month_section.dart';

class GoalPage extends StatelessWidget {
  const GoalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final GoalModel goal = args as GoalModel;

    // TODO: Adicionar lista de opções no botão na appbar.
    AppBar _buildAppBar() {
      return CustomAppBar.buildWhiteAppBar(
        title: goal.title,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: ListView(
          children: [
            HeaderSection(goal: goal),
            MonthSection(goal: goal),
          ],
        ),
      ),
    );
  }
}
