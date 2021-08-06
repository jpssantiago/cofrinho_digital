import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/user_provider.dart';
import '/widgets/custom_app_bar.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool loading = true;

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  void initState() {
    super.initState();
    initialLoading();
  }

  void initialLoading() async {
    setLoading(true);

    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    bool loaded = await provider.loadUser();

    if (loaded) {
      Navigator.of(context).pushNamedAndRemoveUntil('/main', (route) => false);
    }

    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    const String text = '''
      Defina objetivos e metas para o futuro.
A parte dos calculos e estatísticas fica com a gente, a sua única tarefa é poupar.
    ''';

    Widget _buildImage() {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .4,
        child: Image.asset('assets/images/welcome.png'),
      );
    }

    Widget _buildTitle() {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'Seu cofrinho virtual',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Widget _buildText() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          text.trim(),
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF414141),
          ),
          textAlign: TextAlign.start,
        ),
      );
    }

    void handleTap() {
      Navigator.of(context).pushNamed('/setup');
    }

    Widget _buildButton() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 50,
          child: TextButton(
            onPressed: handleTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Continuar'),
                Container(width: 10),
                const Icon(Icons.chevron_right),
              ],
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor,
              ),
              foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildContent() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          const SizedBox(height: 30),
          _buildTitle(),
          const SizedBox(height: 15),
          _buildText(),
          const Spacer(),
          _buildButton(),
          const SizedBox(height: 40),
        ],
      );
    }

    Widget _buildLoading() {
      return const Center(
        child: SizedBox(
          width: 36,
          height: 36,
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar.buildWhiteAppBar(),
      body: Container(
        color: Colors.white,
        child: loading ? _buildLoading() : _buildContent(),
      ),
    );
  }
}
