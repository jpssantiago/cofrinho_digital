import 'package:flutter/material.dart';

import '/models/goal_model.dart';

const double itemWidth = 180;
const double itemHeight = 122;

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

    Widget _buildIcon() {
      return Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            goal.icon,
            color: Colors.white,
          ),
        ),
      );
    }

    Widget _buildTitle() {
      return SizedBox(
        width: itemWidth - 20 - 36 - 10, // Padding - Tamanho icon - SizedBox.
        height: 36,
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
          _buildIcon(),
          const SizedBox(width: 10),
          _buildTitle(),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: itemWidth,
        height: itemHeight,
        decoration: _buildDecoration(),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderRow(),
          ],
        ),
      ),
    );
  }
}
