import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/user_provider.dart';
import 'widgets/app_bar.dart';
import 'widgets/savings_card.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: buildAppBar(context, provider),
          body: Container(
            color: Colors.white,
            child: ListView(
              children: const [
                SavingsCard(savedMoney: 500),
              ],
            ),
          ),
        );
      },
    );
  }
}
