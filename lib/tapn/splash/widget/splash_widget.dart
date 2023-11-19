import 'package:flutter/material.dart';
import 'package:tapn_assignment/tapn/home/widget/home_widget.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    initializeLocationAndSave();
  }

  void initializeLocationAndSave() {
    Future.delayed(
        const Duration(seconds: 1),
        () => Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => const Home()), (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(child: Image.asset('assets/image/splash.png')),
    );
  }
}
