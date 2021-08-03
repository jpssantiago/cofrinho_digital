import 'package:flutter/material.dart';

import '/utils/money_utils.dart';

class SavingsCard extends StatelessWidget {
  final double savedMoney;

  const SavingsCard({
    Key? key,
    this.savedMoney = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildTitle() {
      return const Text(
        'Valor total poupado',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      );
    }

    Widget _buildValue() {
      return Text(
        MoneyUtils().formatMoney(savedMoney),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 112,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            const SizedBox(height: 10),
            _buildValue(),
          ],
        ),
      ),
    );
  }
}
