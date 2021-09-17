import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            builder: (context) => const CreditCalculatorScreen()));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.blue[300] as Color,
              Colors.blue,
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          ),
          child: Center(
            child: Container(
              height: 200,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child:
                  const Text('MyCreditloans', style: TextStyle(fontSize: 25,color: Colors.blue)),
            ),
          )),
    );
  }
}
