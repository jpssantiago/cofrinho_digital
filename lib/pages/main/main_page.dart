import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '/providers/user_provider.dart';

import 'widgets/app_bar.dart';
import 'widgets/savings_card.dart';
import 'widgets/goal_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Produção: ca-app-pub-5938820409184084/6591073595
  // Teste: ca-app-pub-3940256099942544/6300978111
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-5938820409184084/6591073595',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  bool bannerLoaded = false;

  void setBannerLoaded(bool value) {
    setState(() {
      bannerLoaded = value;
    });
  }

  void initializeBanner() async {
    await myBanner.load();
    setBannerLoaded(true);
  }

  @override
  void initState() {
    super.initState();
    initializeBanner();
  }

  @override
  Widget build(BuildContext context) {
    void handleTap() {
      Navigator.of(context).pushNamed('/select_goal_type');
    }

    Widget _buildAdWidget() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            // boxShadow: [
            //   BoxShadow(
            //     offset: const Offset(0, 4),
            //     blurRadius: 4,
            //     color: Colors.black.withOpacity(.25),
            //   ),
            // ],
          ),
          child: AdWidget(ad: myBanner),
        ),
      );
    }

    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: buildAppBar(context, provider),
          body: Container(
            color: Colors.white,
            child: ListView(
              children: [
                SavingsCard(savedMoney: provider.user!.getTotalSaved()),
                const SizedBox(height: 30),
                GoalList(goals: provider.user!.goals),
                const SizedBox(height: 30),
                bannerLoaded ? _buildAdWidget() : Container(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: handleTap,
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}
