import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import '/widgets/custom_app_bar.dart';

class GoalDetailsPage extends StatefulWidget {
  const GoalDetailsPage({Key? key}) : super(key: key);

  @override
  State<GoalDetailsPage> createState() => _GoalDetailsPageState();
}

class _GoalDetailsPageState extends State<GoalDetailsPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();

    final _goalController = MoneyMaskedTextController(
      leftSymbol: 'R\$ ',
      initialValue: 0,
    );

    final _monthsController = TextEditingController(
      text: '12',
    );

    final _monthlyValueController = MoneyMaskedTextController(
      leftSymbol: 'R\$ ',
      initialValue: 0,
    );

    Widget _buildSection({required String title, required Widget child}) {
      Widget _buildTitle() {
        return Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF525252),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            child,
          ],
        ),
      );
    }

    // TODO: Adicionar validação nesses inputs.
    Widget _buildInput({
      required var controller,
      TextInputType? keyboardType,
      double? width,
      String? suffix,
    }) {
      return IntrinsicWidth(
        stepWidth: 10,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixText: suffix ?? '',
            suffixStyle: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
          keyboardType: TextInputType.text,
        ),
      );
    }

    Widget _buildButton() {
      void handleSubmit() {
        if (_loading) return;

        setState(() {
          _loading = true;
        });

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _loading = false;
          });
        });
      }

      Widget _buildRow() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Criar objetivo',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Image.asset('assets/icons/rocket.png', width: 24, height: 24),
          ],
        );
      }

      Widget _buildLoading() {
        return const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: GestureDetector(
          onTap: handleSubmit,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: _loading ? _buildLoading() : _buildRow(),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar.buildWhiteAppBar(title: 'Etapa 3 de 3'),
      body: Container(
        color: Colors.white,
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                title: 'Valor total do objetivo',
                child: _buildInput(controller: _goalController),
              ),
              _buildSection(
                title: 'Quantidade de meses',
                child: Row(
                  children: [
                    _buildInput(
                      controller: _monthsController,
                      keyboardType: TextInputType.number,
                      width: 120,
                      suffix: 'meses',
                    ),
                  ],
                ),
              ),
              _buildSection(
                title: 'Contribuição mensal',
                child: _buildInput(controller: _monthlyValueController),
              ),
              const Spacer(),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }
}
