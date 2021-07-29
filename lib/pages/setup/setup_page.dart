import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/custom_app_bar.dart';
import '/utils/snackbar_utils.dart';
import '/providers/user_provider.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({Key? key}) : super(key: key);

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    final UserProvider provider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    void setLoading(bool value) {
      setState(() {
        _loading = value;
      });
    }

    Widget _buildTitle() {
      return const Text(
        'Para começarmos bem, qual é o seu nome?',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    }

    Widget _buildInput() {
      return TextField(
        decoration: const InputDecoration(
          labelText: 'Nome...',
          border: OutlineInputBorder(),
        ),
        controller: _controller,
      );
    }

    void handleSubmit() async {
      if (_loading) return;

      String name = _controller.text;

      if (name.trim().isEmpty) {
        SnackbarUtils.showMessage(
          context: context,
          message: 'Informe o seu nome para continuar.',
        );
        return;
      }

      setLoading(true);

      final created = await provider.createUser(name);
      if (created) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/main',
          (route) => false,
        );
      }

      setLoading(false);
    }

    Widget _buildButton() {
      Row _buildRow() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Começar'),
            const SizedBox(width: 10),
            Image.asset('assets/icons/rocket.png'),
          ],
        );
      }

      Widget _buildLoading() {
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(color: Colors.white),
        );
      }

      return SizedBox(
        height: 50,
        width: double.infinity,
        child: TextButton(
          child: _loading ? _buildLoading() : _buildRow(),
          onPressed: handleSubmit,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).primaryColor,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar.buildWhiteAppBar(title: 'Configuração'),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildTitle(),
              Container(height: 20),
              _buildInput(),
              Container(height: 20),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }
}
