import 'package:flutter/material.dart';

import 'calculator_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      _navigateToMain();
    });
    super.initState();
  }

  void _navigateToMain() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CreditCalculatorScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      // child:Image.asset('name')
    );
  }
}
