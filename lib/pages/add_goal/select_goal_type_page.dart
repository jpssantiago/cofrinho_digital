import 'package:flutter/material.dart';

import '/widgets/custom_app_bar.dart';
import '/models/goal_category_model.dart';

class SelectGoalTypePage extends StatelessWidget {
  const SelectGoalTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double itemWidth = 100;
    double itemHeight = 80 + 10 + 20;

    final List<GoalCategoryModel> _categories = [
      GoalCategoryModel(name: 'Reserva de emergência', emoji: '💰'),
      GoalCategoryModel(name: 'Fazer uma viajem', emoji: '✈'),
      GoalCategoryModel(name: 'Celular novo', emoji: '📱'),
      GoalCategoryModel(name: 'Casa nova', emoji: '🏠'),
      GoalCategoryModel(name: 'Carro novo', emoji: '🚗'),
      GoalCategoryModel(name: 'Poupar dinheiro', emoji: '🤑'),
      GoalCategoryModel(name: 'Quitar dívida', emoji: '💸'),
      GoalCategoryModel(name: 'Outro', emoji: '🐕'),
    ];

    Widget _buildItem(GoalCategoryModel category) {
      Widget _buildIcon() {
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFD8D8D8),
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              category.emoji,
              style: const TextStyle(
                fontSize: 36,
              ),
            ),
          ),
        );
      }

      Widget _buildName() {
        return SizedBox(
          width: 100,
          child: Text(
            category.name,
            style: const TextStyle(
              fontSize: 16,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }

      void handleTap() {
        Navigator.of(context).pushNamed('/goal_name', arguments: category);
      }

      return GestureDetector(
        onTap: handleTap,
        child: Column(
          children: [
            _buildIcon(),
            const SizedBox(height: 10),
            _buildName(),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar.buildWhiteAppBar(
        title: 'Etapa 1 de 3',
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: itemWidth / itemHeight,
              mainAxisSpacing: 20,
            ),
            itemCount: _categories.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(_categories[index]);
            },
          ),
        ),
      ),
    );
  }
}
