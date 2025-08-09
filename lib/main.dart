import 'package:flutter/material.dart';
import 'screens/onboarding_page.dart';
import './screens/homepage/home_page.dart';
import './screens/quarter/quarter1_page.dart';
import './screens/quarter/quarter2_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingView(),
        '/home': (context) => const HomePage(),
        '/quarter1': (context) => const Quarter1Page(),
        '/quarter2': (context) => const Quarter2Page(),
      },
    );
  }
}
