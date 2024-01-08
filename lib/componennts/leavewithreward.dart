// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_box/componennts/components.dart';
import 'package:guess_the_box/screen/homepage/homescreen.dart';
import 'package:guess_the_box/services/firebaseservice.dart';
import 'package:guess_the_box/screen/auth/loginscreen.dart';
import 'package:guess_the_box/screen/reward/wincoinscreen.dart';
import 'package:guess_the_box/services/sharedprefsservice.dart';

class LeaveWithReward extends StatefulWidget {
  final VoidCallback playAgain;
  int coin;
  String? userId;

  LeaveWithReward({
    super.key,
    required this.playAgain,
    required this.coin,
    required this.userId,
  });

  @override
  State<LeaveWithReward> createState() => _LeaveWithRewardState();
}

class _LeaveWithRewardState extends State<LeaveWithReward> {
  @override
  Widget build(BuildContext context) {
    // print(widget.userId);
    // print(widget.coin);
    String userID = widget.userId.toString();

    return widget.userId == null
        ? AlertDialog(
            backgroundColor: const Color.fromARGB(248, 178, 75, 37),
            elevation: 50,
            shadowColor: Colors.brown,
            alignment: Alignment.center,
            actionsAlignment: MainAxisAlignment.spaceBetween,
            content: Container(
              height: 300,
              width: 250,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  colors: [
                    Color.fromRGBO(110, 56, 19, 1),
                    Color.fromARGB(255, 57, 1, 1),
                  ],
                  radius: 1.5,
                  focal: Alignment.center,
                  focalRadius: 0.3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Please login to save your rewards",
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 246, 226, 206),
                    shadows: [
                      const Shadow(
                        color: Colors.brown,
                        offset: Offset(3, 3),
                        blurRadius: 15.0,
                      ),
                      const Shadow(
                        color: Colors.brown,
                        offset: Offset(-3, -3),
                        blurRadius: 15.0,
                      )
                    ]),
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  CustomComponents.playsound("sounds/gearfastlock.wav");
                  // User? user =
                  //     await FirebaseLoginServices().signInwithGoogle(context);
                  // if (user != null && mounted) {
                  // final localProgress = await SharedPrefs.getLocalCoin();
                  // await CoinManager.saveCoins(user.uid, localProgress);
                  //   await FirebaseMessingServices.displaySimpleNotification(
                  //       title: "Login successful",
                  //       body: "welcome ${user.displayName}!",
                  //       payload: "login_payload");
                  // }

                  Navigator.of(context).pushReplacementNamed(
                      LogInPage.routename,
                      arguments: true);
                },
                child: Container(
                  width: 100,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 164, 9, 7), width: 3),
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
                    // borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  CustomComponents.playsound("sounds/gearfastlock.wav");
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 100,
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
                    "Keep playing",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ],
          )
        /* --------------------------- if user is loggedin -------------------------- */
        : AlertDialog(
            backgroundColor: const Color.fromARGB(248, 178, 75, 37),
            elevation: 50,
            shadowColor: Colors.brown,
            alignment: Alignment.center,
            actionsAlignment: MainAxisAlignment.spaceBetween,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
            title: const Text(
              "Are you sure?",
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: 200,
              width: 200,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const RadialGradient(colors: [
                  Color.fromRGBO(110, 56, 19, 1),
                  Color.fromARGB(255, 57, 1, 1),
                ], radius: 1.5, focal: Alignment.center, focalRadius: 0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Are you sure you want to leave with your current rewards?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              InkWell(
                onTap: () async {
                  await CoinManager.saveCoins(
                      widget.userId.toString(), widget.coin);
                  CustomComponents.playsound("sounds/gearfastlock.wav");
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => CoinScreen(
                        coin: widget.coin, playagain: widget.playAgain),
                  ));
                  
                },
                child: Container(
                  width: 100,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 164, 9, 7), width: 3),
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
                    // borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  child: const Text(
                    "Leave",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  CustomComponents.playsound("sounds/gearfastlock.wav");
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 100,
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
                    "Keep playing",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ],
          );
  }
}
