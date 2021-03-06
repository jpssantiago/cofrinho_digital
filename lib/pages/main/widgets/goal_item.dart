import 'package:flutter/material.dart';

import '/models/goal_model.dart';
import '/utils/money_utils.dart';

const double itemWidth = 180;
const double itemHeight = 130;

class GoalItem extends StatelessWidget {
  final GoalModel goal;

  const GoalItem({
    Key? key,
    required this.goal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration _buildDecoration() {
      return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: Colors.black.withOpacity(.25),
          ),
        ],
      );
    }

    Widget _buildEmoji() {
      return Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            goal.emoji,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );
    }

    Widget _buildTitle() {
      return Container(
        width: itemWidth - 20 - 36 - 10, // Padding - Tamanho icon - SizedBox.
        height: 36,
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          goal.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }

    Widget _buildHeaderRow() {
      return Row(
        children: [
          _buildEmoji(),
          const SizedBox(width: 10),
          _buildTitle(),
        ],
      );
    }

    Widget _buildValue() {
      return Text(
        MoneyUtils.formatMoney(goal.saved),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    Widget _buildProgressIndicator() {
      double getValue() {
        return goal.saved / goal.goal;
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: LinearProgressIndicator(
          value: getValue(),
          minHeight: 10,
          backgroundColor: const Color(0xFFE7E7E7),
          valueColor: AlwaysStoppedAnimation(
            Theme.of(context).primaryColor,
          ),
        ),
      );
    }

    void handleTap() {
      Navigator.of(context).pushNamed('/goal', arguments: goal);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: handleTap,
        child: Container(
          width: itemWidth,
          height: itemHeight,
          decoration: _buildDecoration(),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeaderRow(),
              _buildValue(),
              _buildProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
