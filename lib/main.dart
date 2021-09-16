import 'package:flutter/material.dart';

import 'pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.blue),
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintStyle:const TextStyle(color:Colors.white),
              filled: true,
              fillColor: Colors.blueGrey[200])),
      home: const SplashScreen(),
    );
  }
}
