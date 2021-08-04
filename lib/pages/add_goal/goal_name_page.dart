import 'package:flutter/material.dart';

import '/widgets/custom_app_bar.dart';
import '/models/goal_category_model.dart';
import '/utils/snackbar_utils.dart';

class GoalNamePage extends StatelessWidget {
  const GoalNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Object? args = ModalRoute.of(context)!.settings.arguments;
    GoalCategoryModel category = args as GoalCategoryModel;
    TextEditingController _controller = TextEditingController(
      text: category.name,
    );

    Widget _buildTitle() {
      return const Padding(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Text(
          'Dê um nome para o seu novo objetivo.',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Widget _buildEmoji() {
      return Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFD8D8D8),
            ),
          ),
          child: Center(
            child: Text(
              category.emoji,
              style: const TextStyle(
                fontSize: 36,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    Widget _buildInput() {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Center(
          child: SizedBox(
            width: 220,
            child: TextField(
              textAlign: TextAlign.center,
              controller: _controller,
              maxLength: 25,
              decoration: const InputDecoration(),
            ),
          ),
        ),
      );
    }

    Widget _buildButton() {
      void handleSubmit() {
        String name = _controller.text;
        if (name.trim().isEmpty) {
          SnackbarUtils.showMessage(
            context: context,
            message: 'O nome do objetivo não pode ser vazio.',
          );
          return;
        }

        category.name = name;

        Navigator.of(context).pushNamed(
          '/goal_details',
          arguments: category,
        );
      }

      return Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 30, right: 20),
        child: GestureDetector(
          onTap: handleSubmit,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Próximo',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar.buildWhiteAppBar(title: 'Etapa 2 de 3'),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            const Spacer(),
            _buildEmoji(),
            _buildInput(),
            const Spacer(),
            _buildButton(),
          ],
        ),
      ),
    );
  }
}
