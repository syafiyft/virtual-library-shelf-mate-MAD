import 'package:flutter/material.dart';
import 'pages/get_started_page.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'getStarted': (context) => GetStartedPage(),
        'logIn': (context) => LogInPage(),
        'home': (context) => Home(),
      },
      initialRoute: 'getStarted',
    );
  }
}
