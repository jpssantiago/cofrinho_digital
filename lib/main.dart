import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'providers/user_provider.dart';
import 'services/database_service.dart';

import 'pages/welcome/welcome_page.dart';
import 'pages/setup/setup_page.dart';
import 'pages/main/main_page.dart';
import 'pages/profile/profile_page.dart';
import 'pages/edit_profile/edit_profile_page.dart';
import 'pages/add_goal/select_goal_type_page.dart';
import 'pages/add_goal/goal_name_page.dart';
import 'pages/add_goal/goal_details_page.dart';
import 'pages/goal/goal_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await DatabaseService.startDatabase();

  MobileAds.instance.initialize();

  runApp(const MyApp());
}

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
          '/profile': (context) => const ProfilePage(),
          '/edit_profile': (context) => const EditProfilePage(),
          '/select_goal_type': (context) => const SelectGoalTypePage(),
          '/goal_name': (context) => const GoalNamePage(),
          '/goal_details': (context) => const GoalDetailsPage(),
          '/goal': (context) => const GoalPage(),
        },
        initialRoute: '/welcome',
        theme: _buildTheme(),
      ),
    );
  }
}

ThemeData _buildTheme() {
  return ThemeData(
    primaryColor: const Color(0xFF3B59FF),
  );
}
