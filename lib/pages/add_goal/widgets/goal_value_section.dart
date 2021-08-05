import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class GoalValueSection extends StatelessWidget {
  final Function(double) onSubmit;
  final double value;

  const GoalValueSection({
    Key? key,
    required this.onSubmit,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = MoneyMaskedTextController(
      leftSymbol: 'R\$ ',
      initialValue: value,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        _buildTextField(
          controller: controller,
          context: context,
          onSubmit: () {
            double value = controller.numberValue;
            onSubmit(value);
          },
        ),
      ],
    );
  }
}

Widget _buildTitle() {
  return const Text(
    'Valor total do objetivo',
    style: TextStyle(
      fontSize: 14,
      color: Color(0xFF525252),
    ),
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required BuildContext context,
  required VoidCallback onSubmit,
}) {
  return TextField(
    controller: controller,
    decoration: const InputDecoration(
      border: InputBorder.none,
    ),
    style: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
    ),
    onSubmitted: (String value) => onSubmit(),
    autofocus: true,
  );
}
