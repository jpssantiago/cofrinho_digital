import 'package:cofrinho_digital/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/user_provider.dart';
import '/widgets/custom_app_bar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);
    final TextEditingController _controller = TextEditingController(
      text: provider.user!.name,
    );

    Widget _buildInput() {
      return TextField(
        decoration: const InputDecoration(
          labelText: 'Nome',
          border: OutlineInputBorder(),
        ),
        controller: _controller,
      );
    }

    void setLoading(bool value) {
      setState(() {
        _loading = value;
      });
    }

    void handleSubmit() async {
      if (_loading) return;

      String name = _controller.text;
      if (name.trim().isEmpty) {
        return;
      }

      setLoading(true);

      UserModel user = provider.user!;
      user.name = name;
      await provider.updateUser(user);

      Navigator.of(context).pop();

      setLoading(false);
    }

    Widget _buildButton() {
      Widget _buidRow() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Editar perfil'),
            SizedBox(width: 10),
            Icon(Icons.save),
          ],
        );
      }

      Widget _buildLoading() {
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }

      return SizedBox(
        width: double.infinity,
        height: 50,
        child: TextButton(
          child: _loading ? _buildLoading() : _buidRow(),
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
      appBar: CustomAppBar.buildWhiteAppBar(
        title: 'Editar informações de perfil',
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildInput(),
              const SizedBox(height: 20),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }
}
