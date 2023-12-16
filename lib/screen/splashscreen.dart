import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guess_the_box/screen/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/gradient.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Text(
          "GuessTheBox",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.1,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        )),
      ),
    );
  }
}
