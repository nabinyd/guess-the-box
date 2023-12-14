import 'package:flutter/material.dart';

import 'package:guess_the_box/screen/homescreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        HomePage.routename: (context) => const HomePage(),
      },
    );
  }
}
