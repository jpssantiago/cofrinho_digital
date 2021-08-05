import 'package:cofrinho_digital/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/goal_model.dart';
import '/widgets/custom_app_bar.dart';
import '/providers/user_provider.dart';

import 'widgets/header_section.dart';
import 'widgets/month_section.dart';

class GoalPage extends StatelessWidget {
  const GoalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final GoalModel goal = args as GoalModel;
    final provider = Provider.of<UserProvider>(context, listen: false);

    // TODO: Adicionar lista de opções no botão na appbar.
    AppBar _buildAppBar() {
      PopupMenuItem _buildEditOption() {
        return PopupMenuItem(
          child: const Text('Editar'),
          onTap: () {},
        );
      }

      PopupMenuItem _buildDeleteOption() {
        return PopupMenuItem(
          child: const Text(
            'Deletar',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.of(context).pop();

            provider.deleteGoal(goal);

            SnackbarUtils.showMessage(
              context: context,
              message: 'Objetivo deletado com sucesso.',
            );
          },
        );
      }

      return CustomAppBar.buildWhiteAppBar(
        title: goal.title,
        actions: [
          PopupMenuButton(
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.more_vert),
            ),
            itemBuilder: (BuildContext context) {
              return [
                _buildEditOption(),
                _buildDeleteOption(),
              ];
            },
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
