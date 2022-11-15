import 'package:flutter/material.dart';
import 'package:pixabay/view/widget/app_text_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    intWord(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: appTextView(name: 'Splash Screen', isBold: true),
      ),
    );
  }

  void intWord(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () =>
          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false),
    );
  }
}
