import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/user_provider.dart';

import 'widgets/app_bar.dart';
import 'widgets/savings_card.dart';
import 'widgets/goal_list.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handleTap() {
      Navigator.of(context).pushNamed('/select_goal_type');
    }

    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: buildAppBar(context, provider),
          body: Container(
            color: Colors.white,
            child: ListView(
              children: [
                SavingsCard(savedMoney: provider.user!.getTotalSaved()),
                const SizedBox(height: 30),
                GoalList(goals: provider.user!.goals),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: handleTap,
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}
