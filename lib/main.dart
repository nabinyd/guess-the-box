import 'package:flutter/material.dart';

import 'package:guess_the_box/screen/homescreen.dart';
import 'package:guess_the_box/screen/splashscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        HomePage.routename: (context) => const HomePage(),
      },
    );
  }
}
