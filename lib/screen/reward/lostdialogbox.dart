import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:guess_the_box/componennts/components.dart';
import 'package:guess_the_box/constant/constant.dart';
import 'package:guess_the_box/screen/homepage/homescreen.dart';

class LostDialogBox extends StatefulWidget {
  final String displaysuffledimage;
  final VoidCallback playAgain;
  bool? isGameOver;
  int? level;
  int? points = 0;

  LostDialogBox({
    super.key,
    required this.displaysuffledimage,
    required this.playAgain,
    required this.isGameOver,
    required this.level,
    this.points,
  });

  @override
  State<LostDialogBox> createState() => _LostDialogBoxState();
}

class _LostDialogBoxState extends State<LostDialogBox> {
  @override
  Widget build(BuildContext context) {
    print("coin = ${widget.points}");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: size.height * 0.15,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: Image.asset(
                      "assets/pngwing.com (3).png",
                      height: size.height * 0.07,
                      width: size.width * 0.9,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: Text(
                      "Wrong Choice!",
                      style: GoogleFonts.viga(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: const Color.fromARGB(255, 208, 190, 183),
                          shadows: [
                            const Shadow(
                              color: Colors.brown,
                              offset: Offset(3, 3),
                              blurRadius: 15.0,
                            )
                          ]),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 200,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Color.fromARGB(255, 56, 39, 33),
                      blurRadius: 20,
                      offset: Offset(8, 8)),
                  BoxShadow(
                      color: Color.fromARGB(255, 56, 39, 33),
                      blurRadius: 20,
                      offset: Offset(-8, -8)),
                ],
                image: DecorationImage(
                  image: AssetImage(widget.displaysuffledimage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text(
              'You are about to lose all your rewards:',
              style: TextStyle(
                  fontSize: 21,
                  color: Color.fromARGB(255, 219, 189, 182),
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.brown,
                      offset: Offset(3, 3),
                      blurRadius: 15.0,
                    )
                  ]),
            ),
            Container(
              height: 80,
              width: 80,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/coinbox.png'),
                  fit: BoxFit.cover,
                  opacity: 0.6,
                ),
                color: ColorList.tilecolor,
                border: Border.all(
                  color: const Color.fromARGB(255, 244, 209, 54),
                  width: 3,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                "${widget.points}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 218, 208, 208),
                    shadows: [
                      Shadow(
                        color: Colors.brown,
                        offset: Offset(3, 3),
                        blurRadius: 15.0,
                      )
                    ]),
              ),
            ),
            // Text(
            //   "Your next box is a guaranteed prize!",
            //   style: GoogleFonts.manrope(
            //       color: const Color.fromARGB(255, 221, 172, 137),
            //       fontSize: 18,
            //       fontWeight: FontWeight.w800,
            //       shadows: [
            //         const Shadow(
            //           color: Colors.brown,
            //           offset: Offset(3, 3),
            //           blurRadius: 15.0,
            //         )
            //       ]),
            // ),
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      CustomComponents.showGiveUpDialog(context);
                    },
                    child: Container(
                      width: 150,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 164, 9, 7),
                            width: 3),
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 195, 18, 6),
                              Color.fromRGBO(210, 3, 3, 1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.8]),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 79, 1, 1)
                                .withOpacity(0.8),
                            spreadRadius: 6,
                            blurRadius: 50,
                            offset: const Offset(3, 3),
                          )
                        ],
                      ),
                      child: const Text(
                        "Give Up",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 1,
                            shadows: [
                              Shadow(
                                color: Colors.brown,
                                offset: Offset(3, 3),
                                blurRadius: 15.0,
                              )
                            ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.isGameOver = true;
                      });
                      Timer(const Duration(milliseconds: 400), () {
                        widget.playAgain();
                      });
                      Navigator.of(context)
                          .pushReplacementNamed(HomePage.routename);
                    },
                    child: Container(
                      width: 150,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 147, 191, 28),
                            width: 3),
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 2, 150, 7),
                              Color.fromARGB(255, 29, 173, 3),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.8]),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 79, 1, 1)
                                .withOpacity(0.8),
                            spreadRadius: 6,
                            blurRadius: 50,
                            offset: const Offset(3, 3),
                          )
                        ],
                      ),
                      child: const Text(
                        "Play Again",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 1,
                            shadows: [
                              Shadow(
                                color: Colors.brown,
                                offset: Offset(3, 3),
                                blurRadius: 15.0,
                              )
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
