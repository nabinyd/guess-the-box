import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_box/constant/constant.dart';
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
          title: const Text('Confirm'),
          content: const Text('Do you want to exit game?'),
          actions: <Widget>[
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
          title: const Text('Confirm'),
          content: const Text('Do you want to exit game?'),
          actions: <Widget>[
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
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 131, 68, 45),
          title: ListTile(
            title: const Text(
              "Guess The Box",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            trailing: IconButton.outlined(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.redAccent,
              highlightColor: Colors.redAccent,
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white)),
              icon: const Icon(Icons.close),
            ),
          ),
          content: Container(
            height: 200,
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: -10,
                  offset: Offset(0, 1),
                  color: Color.fromARGB(255, 65, 29, 16),
                ),
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(0, 1),
                  color: Color.fromARGB(255, 102, 41, 17),
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    '1. Guess the box for a chance to win a prize',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    '2. The higher the level the higher the prizes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    '3. You will lose all rewaards if the wrong option is selected',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    '4. Jackpots have Guaranteed prizes!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
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
