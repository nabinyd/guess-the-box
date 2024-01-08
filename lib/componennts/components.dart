import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_box/screen/homepage/homescreen.dart';
import 'package:guess_the_box/screen/homepage/mainscreen.dart';

mixin CustomComponents {
  static Future showGiveUpDialog(
    BuildContext context,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(248, 178, 75, 37),
          elevation: 50,
          shadowColor: Colors.brown,
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.spaceBetween,
          titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2),
          title: const Text(
            "Confirm",
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
              "You will lose your prizes by leaving.",
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
              onTap: () {
                CustomComponents.playsound("sounds/gearfastlock.wav");
                Navigator.pushReplacementNamed(context, MainScreen.routename);
              },
              child: Container(
                width: 120,
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
                      color:
                          const Color.fromARGB(255, 79, 1, 1).withOpacity(0.8),
                      spreadRadius: 6,
                      blurRadius: 50,
                      offset: const Offset(3, 3),
                    )
                  ],
                  // borderRadius: const BorderRadius.all(Radius.circular(40)),
                ),
                child: const Text(
                  "Yes",
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
                Navigator.of(context).popAndPushNamed(HomePage.routename);
              },
              child: Container(
                width: 120,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 147, 191, 28), width: 3),
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
                      color:
                          const Color.fromARGB(255, 79, 1, 1).withOpacity(0.8),
                      spreadRadius: 6,
                      blurRadius: 50,
                      offset: const Offset(3, 3),
                    )
                  ],
                ),
                child: const Text(
                  "No",
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
      },
    );
  }

  static Future<dynamic> infoDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 131, 68, 45),
          title: ListTile(
            title: const Text(
              "Guess The Box",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            trailing: IconButton.outlined(
              onPressed: () {
                CustomComponents.playsound("sounds/gearfastlock.wav");
                Navigator.of(context).pop();
              },
              color: Colors.red,
              highlightColor: Colors.redAccent,
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              icon: const Icon(Icons.close),
            ),
          ),
          content: Container(
            height: 250,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 114, 53, 30),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '1. Guess the box for a chance to win a prize',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '2. The higher the level the higher the prizes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '3. You will lose all rewaards if the wrong option is selected',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '4. Jackpots have Guaranteed prizes!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void playsound(String soundFilename) async {
    AudioPlayer player = AudioPlayer()..setPlayerMode(PlayerMode.lowLatency);
    await player.play(
      AssetSource(soundFilename),
    );
  }

  static void playSoundInLoop(String soundFilename) async {
    final player = AudioPlayer()
      ..setPlayerMode(PlayerMode.mediaPlayer)
      ..setReleaseMode(ReleaseMode.loop);
    await player.play(AssetSource(soundFilename));
  }
}
