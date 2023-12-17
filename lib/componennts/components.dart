import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:guess_the_box/screen/homescreen.dart';

mixin CustomComponents {
  static Future showLeaveConfirmationDialog(
      BuildContext context, bool exit) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Do you want to give up?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(exit);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(exit);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static Future showGiveUpDialog(
    BuildContext context,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Do you want to exit game?',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, HomePage.routename);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static Future showGiveUpWinBoxDialog(BuildContext context) async {
    return showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Do you want to exit game?',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(HomePage.routename));
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('Yes'),
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
}
