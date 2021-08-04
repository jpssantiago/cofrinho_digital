import 'package:flutter/material.dart';

import 'goal_item.dart';
import '/models/goal_model.dart';

class GoalList extends StatelessWidget {
  final List<GoalModel> goals;

  const GoalList({
    Key? key,
    required this.goals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handleAddNewGoalTap() {
      //
    }

    Widget _buildTitle() {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'Meus objetivos',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }

    // Trocar para => padding all: 10.
    Widget _buildEmptyListItem() {
      Widget _buildIcon() {
        return Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      }

      Widget _buildText() {
        return const Text(
          'Nenhum objetivo por enquanto...',
          style: TextStyle(
            fontSize: 16,
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap: handleAddNewGoalTap,
          child: Container(
            width: itemWidth,
            height: itemHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(.25),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIcon(),
                  _buildText(),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildListView() {
      return SizedBox(
        height: itemHeight + 10,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          itemCount: goals.length,
          itemBuilder: (BuildContext context, int index) {
            return GoalItem(
              goal: goals[index],
            );
          },
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(height: 10),
        goals.isEmpty ? _buildEmptyListItem() : _buildListView(),
      ],
    );
  }
}
