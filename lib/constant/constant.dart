import 'package:flutter/material.dart';

class ColorList {
  static Color backgroundcolor = const Color.fromARGB(255, 61, 20, 6);
  List<Color> gradient = [
    const Color.fromARGB(255, 46, 24, 16),
    Colors.brown,
    const Color.fromARGB(255, 46, 24, 16)
  ];
  static Color appbarcolor = const Color.fromARGB(255, 154, 97, 76);
  static Color bordercolor = const Color.fromARGB(255, 249, 212, 0);
  static Color tilecolor = const Color.fromARGB(255, 70, 20, 2);
  static Color rewardbanner = const Color.fromARGB(255, 255, 68, 0);
}

class MyTextstyle {
  static TextStyle displaylarge = const TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}
