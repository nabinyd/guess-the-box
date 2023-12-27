import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_box/screen/auth/loginscreen.dart';
import 'package:guess_the_box/screen/homepage/homescreen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
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
          child: GradientText(
            'Guess The Box',
            style: GoogleFonts.manrope(
              fontSize: 40,
              fontWeight: FontWeight.w900,
            ),
            colors: const [
              Color.fromARGB(255, 219, 181, 179),
              Color.fromARGB(255, 194, 164, 164),
            ],
          ),
        ),
      ),
    );
  }
}
