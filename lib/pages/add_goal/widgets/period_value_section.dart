import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class PeriodValueSection extends StatelessWidget {
  final Function(double) onSubmit;
  final double value;
  final String periodType;

  const PeriodValueSection({
    Key? key,
    required this.onSubmit,
    required this.value,
    required this.periodType,
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
        _buildTitle(periodType),
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

Widget _buildTitle(String periodType) {
  String getPeriod() {
    if (periodType == 'days') {
      return 'diária';
    } else if (periodType == 'weeks') {
      return 'semanal';
    }

    return 'mensal';
  }

  return Text(
    'Contribuição ${getPeriod()}',
    style: const TextStyle(
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
  );
}
