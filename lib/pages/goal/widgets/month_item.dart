import 'package:flutter/material.dart';

import 'package:cofrinho_digital/utils/money_utils.dart';

class MonthItem extends StatelessWidget {
  final int index;
  final double value;
  final bool completed;
  final Function(int) onTap;

  const MonthItem({
    Key? key,
    required this.index,
    required this.value,
    required this.completed,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildCheck() {
      return const Center(
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    }

    Widget _buildLeading() {
      return Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: completed ? Theme.of(context).primaryColor : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: completed
                ? Theme.of(context).primaryColor
                : const Color(0xFF525252),
          ),
        ),
        child: completed ? _buildCheck() : const SizedBox(),
      );
    }

    Widget _buildTrailing() {
      return Text(
        MoneyUtils.formatMoney(value),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    return ListTile(
      leading: _buildLeading(),
      title: Text('Mês ${index + 1}'),
      trailing: _buildTrailing(),
      onTap: () => onTap(index),
    );
  }
}
