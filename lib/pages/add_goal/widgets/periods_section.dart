import 'package:flutter/material.dart';

class PeriodSection extends StatelessWidget {
  final Function(int) onSubmit;
  final int value;

  const PeriodSection({
    Key? key,
    required this.onSubmit,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        _buildTextField(
          controller: controller,
          context: context,
          onSubmit: () {
            int value = int.parse(controller.text);
            onSubmit(value);
          },
        ),
      ],
    );
  }
}

Widget _buildTitle() {
  return const Text(
    'Número de %period%',
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
    keyboardType: TextInputType.number,
  );
}
