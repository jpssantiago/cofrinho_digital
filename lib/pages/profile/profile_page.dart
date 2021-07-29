import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/user_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handleEditProfileTap() {
      Navigator.of(context).pushNamed('/edit_profile');
    }

    void handleDeleteTap(UserProvider provider) {
      String title = 'Confirmação.';
      String content = 'Você tem certeza que deseja excluir a sua conta?';
      String content2 = 'Todos os seus dados serão perdidos.';

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content + '\n\n' + content2),
            actions: [
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Excluir'),
                onPressed: () async {
                  await provider.deleteUser();

                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/welcome',
                    (route) => false,
                  );
                },
              ),
            ],
          );
        },
      );
    }

    Widget _buildBackground(UserProvider provider) {
      Widget _buildImage() {
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.2),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 70,
            ),
          ),
        );
      }

      Widget _buildName() {
        return Text(
          provider.user!.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      }

      Widget _buildDescription() {
        return const Text(
          'Plano gratuito',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFFDEDEDE),
          ),
        );
      }

      return Container(
        width: double.infinity,
        height: 222,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            _buildImage(),
            const SizedBox(height: 20),
            _buildName(),
            const SizedBox(height: 5),
            _buildDescription(),
          ],
        ),
      );
    }

    Widget _buildListView(UserProvider provider) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 170,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: Colors.black.withOpacity(.25),
              ),
            ],
          ),
          height: 55 * 2,
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Editar informações de perfil.'),
                onTap: handleEditProfileTap,
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Excluir conta.'),
                onTap: () => handleDeleteTap(provider),
              ),
            ],
          ),
        ),
      );
    }

    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(elevation: 0),
          body: Container(
            color: Colors.white,
            child: Stack(
              children: [
                _buildBackground(provider),
                _buildListView(provider),
              ],
            ),
          ),
        );
      },
    );
  }
}
