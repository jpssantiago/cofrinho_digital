import 'package:cofrinho_digital/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          child: const Text('Deletar'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).primaryColor,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ),
          ),
          onPressed: () async {
            final provider = Provider.of<UserProvider>(context, listen: false);
            await provider.deleteUser();

            Navigator.of(context).pushNamedAndRemoveUntil(
              '/welcome',
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}
