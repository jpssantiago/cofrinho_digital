import 'package:flutter/material.dart';

import '/providers/user_provider.dart';
import '/widgets/custom_app_bar.dart';

AppBar buildAppBar(BuildContext context, UserProvider provider) {
  String getName() {
    return provider.user!.name.split(' ')[0];
  }

  Widget _buildProfileAction() {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/profile');
      },
      icon: const Icon(
        Icons.account_circle,
        color: Color(0xFF272727),
      ),
    );
  }

  return CustomAppBar.buildWhiteAppBar(
    title: 'Olá, ${getName()}',
    actions: [
      _buildProfileAction(),
      const SizedBox(width: 20),
    ],
  );
}
