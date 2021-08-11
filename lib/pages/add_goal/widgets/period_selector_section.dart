import 'package:flutter/material.dart';

final List<Map<String, String>> options = [
  {
    'displayName': 'Mensal',
    'name': 'months',
  },
  {
    'displayName': 'Semanal',
    'name': 'weeks',
  },
  {
    'displayName': 'Diário',
    'name': 'days',
  }
];

class PeriodSelectorSection extends StatelessWidget {
  final String selectedPeriodType;
  final Function(String) onSelectPeriodType;

  const PeriodSelectorSection({
    Key? key,
    required this.selectedPeriodType,
    required this.onSelectPeriodType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildTitle() {
      return const Text(
        'Período de contribuição',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF525252),
        ),
      );
    }

    Widget _buildOption({
      required String name,
      required String value,
      required bool selected,
    }) {
      return Padding(
        padding: const EdgeInsets.only(right: 5),
        child: GestureDetector(
          onTap: () => onSelectPeriodType(name),
          child: Container(
            width: 100,
            height: 36,
            decoration: BoxDecoration(
              color: selected ? Theme.of(context).primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: selected
                    ? Theme.of(context).primaryColor
                    : Colors.black.withOpacity(.8),
              ),
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : Colors.black.withOpacity(.8),
                ),
              ),
            ),
          ),
        ),
      );
    }

    List<Widget> _buildChildren() {
      List<Widget> list = [];

      for (Map<String, String> item in options) {
        list.add(
          _buildOption(
            name: item['name']!,
            selected: item['name'] == selectedPeriodType,
            value: item['displayName']!,
          ),
        );
      }

      return list;
    }

    return SizedBox(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 20),
          Row(
            children: _buildChildren(),
          )
        ],
      ),
    );
  }
}
