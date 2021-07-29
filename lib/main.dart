import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';

import 'pages/welcome/welcome_page.dart';
import 'pages/setup/setup_page.dart';
import 'pages/main/main_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        routes: {
          '/welcome': (context) => const WelcomePage(),
          '/setup': (context) => const SetupPage(),
          '/main': (context) => const MainPage(),
        },
        initialRoute: '/welcome',
        theme: _buildTheme(),
      ),
    );
  }
}

ThemeData _buildTheme() {
  return ThemeData(
    primaryColor: const Color(0xFF3C59FF),
  );
}
