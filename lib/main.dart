import 'package:flutter/material.dart';
import 'pages/get_started_page.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'package:provider/provider.dart';
import 'providers/favorites_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'getStarted': (context) => GetStartedPage(),
        'logIn': (context) => LogInPage(),
      },
      initialRoute: 'getStarted',
    );
  }
}
