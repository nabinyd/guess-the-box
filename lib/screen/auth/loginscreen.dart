// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_box/screen/homepage/mainscreen.dart';

import 'package:guess_the_box/services/firebaseservice.dart';
import 'package:guess_the_box/screen/homepage/homescreen.dart';
import 'package:guess_the_box/services/sharedprefsservice.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LogInPage extends StatefulWidget {
  static const String routename = "/loginpage";
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    bool isleavingWithReward =
        ModalRoute.of(context)!.settings.arguments != null;
    print("isleaving with reward = $isleavingWithReward");
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/backgroundd.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(top: 45, right: 25),
                  child: GestureDetector(
                    onTap: () async {
                      await FirebaseLoginServices().signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MainScreen()));
                    },
                    child: Container(
                      height: 30,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 82, 23, 0),
                      ),
                      child: Text(
                        "Skip",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  spreadRadius: 15,
                  color:
                      const Color.fromARGB(255, 165, 14, 14).withOpacity(0.2),
                  offset: const Offset(2, 2),
                ),
                BoxShadow(
                  blurRadius: 20,
                  spreadRadius: 15,
                  color:
                      const Color.fromARGB(255, 165, 14, 14).withOpacity(0.2),
                  offset: const Offset(-2, -2),
                ),
                BoxShadow(
                  blurRadius: 20,
                  spreadRadius: 15,
                  color:
                      const Color.fromARGB(255, 165, 14, 14).withOpacity(0.2),
                  offset: const Offset(1, -1),
                ),
                BoxShadow(
                  blurRadius: 20,
                  spreadRadius: 15,
                  color:
                      const Color.fromARGB(255, 165, 14, 14).withOpacity(0.2),
                  offset: const Offset(-1, 1),
                ),
              ]),
              child: GradientText(
                "Guess The Box",
                style: GoogleFonts.roboto(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    shadows: [
                      const Shadow(
                        color: Color.fromARGB(255, 174, 53, 53),
                        offset: Offset(3, 3),
                        blurRadius: 15.0,
                      ),
                      const Shadow(
                        color: Color.fromARGB(255, 174, 53, 53),
                        offset: Offset(-3, -3),
                        blurRadius: 15.0,
                      ),
                      const Shadow(
                        color: Color.fromARGB(255, 174, 53, 53),
                        offset: Offset(2, -2),
                        blurRadius: 15.0,
                      ),
                      const Shadow(
                        color: Color.fromARGB(255, 174, 53, 53),
                        offset: Offset(-2, 2),
                        blurRadius: 15.0,
                      ),
                    ]),
                colors: const [
                  Color.fromARGB(255, 209, 206, 202),
                  Color.fromARGB(255, 233, 222, 216),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                User? user =
                    await FirebaseLoginServices().signInwithGoogle(context);
                if (user != null && mounted) {
                  final localProgress = isleavingWithReward
                      ? await SharedPrefs.getLocalCoin()
                      : null;

                  isleavingWithReward
                      ? await CoinManager.saveCoins(
                          user.uid, localProgress!.toInt())
                      : null;

                  await Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                }
                // if (user != null) {
                //   await FirebaseMessingServices.displaySimpleNotification(
                //       title: "Login successful",
                //       body: "welcome ${user.displayName}!",
                //       payload: "login_payload");
                // }
              },
              child: Container(
                height: 50,
                width: 250,
                margin: const EdgeInsets.only(bottom: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/googleIcon.png",
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      "Sign in with Google",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 18, 18, 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
