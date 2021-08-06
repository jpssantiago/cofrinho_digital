import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/goal_model.dart';
import '/widgets/custom_app_bar.dart';
import '/providers/user_provider.dart';
import '/utils/alert_utils.dart';
import '/utils/snackbar_utils.dart';

import 'widgets/header_section.dart';
import 'widgets/month_section.dart';

class GoalPage extends StatelessWidget {
  const GoalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final GoalModel goal = args as GoalModel;

    AppBar _buildAppBar(UserProvider provider) {
      PopupMenuItem _buildDeleteOption() {
        return PopupMenuItem(
          child: const Text(
            'Deletar',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            Future.delayed(const Duration(seconds: 0), () {
              AlertUtils.showDefaultAlert(
                context: context,
                title: 'Confirmar',
                message: 'Tem certeza que deseja deletar este objetivo?',
                acceptButtonText: 'Deletar',
                onAccept: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/main',
                    (route) => false,
                  );

                  provider.deleteGoal(goal);

                  SnackbarUtils.showMessage(
                    context: context,
                    message: 'Objetivo deletado com sucesso.',
                  );
                },
              );
            });
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
                _buildDeleteOption(),
              ];
            },
          ),
        ],
      );
    }

    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: _buildAppBar(provider),
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
      },
    );
  }
}
