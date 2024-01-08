import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_box/componennts/components.dart';
import 'package:guess_the_box/screen/homepage/homescreen.dart';
import 'package:guess_the_box/screen/homepage/mainscreen.dart';

class CoinScreen extends StatefulWidget {
  int coin;
  VoidCallback playagain;
  CoinScreen({super.key, required this.coin, required this.playagain});

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backgroundd.jpg"), fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, top: 15),
                    child: Container(
                      height: 30,
                      width: 80,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 60, 21, 7),
                        borderRadius: BorderRadius.all(
                          Radius.circular(14),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/coinicon.png",
                            height: 25,
                            width: 25,
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              widget.coin.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 236, 229, 229),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                        "Congratulations!!",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: const Color.fromARGB(255, 230, 221, 218),
                            letterSpacing: 1,
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
              Text(
                "You have received",
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 240, 236, 236),
                    shadows: [
                      const Shadow(
                        color: Colors.brown,
                        offset: Offset(3, 3),
                        blurRadius: 15.0,
                      ),
                      const Shadow(
                        color: Colors.brown,
                        offset: Offset(3, 3),
                        blurRadius: 15.0,
                      ),
                      const Shadow(
                        color: Colors.brown,
                        offset: Offset(-3, -3),
                        blurRadius: 15.0,
                      ),
                      const Shadow(
                        color: Colors.brown,
                        offset: Offset(-3, -3),
                        blurRadius: 15.0,
                      ),
                    ]),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 3),
                curve: Curves.easeInOutCirc,
                child: Image.asset(
                  "assets/coinbox.png",
                  fit: BoxFit.cover,
                ).animate().boxShadow(
                    begin: const BoxShadow(color: Colors.black26),
                    end: BoxShadow(color: Colors.red.withOpacity(0)),
                    duration: 2.seconds),
              ),
              Countup(
                begin: 0,
                end: widget.coin.toDouble(),
                duration: const Duration(seconds: 2),
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Coins",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  CustomComponents.playsound("sounds/gearfastlock.wav");
                  Navigator.of(context)
                      .pushReplacementNamed(MainScreen.routename);
                },
                style: ButtonStyle(
                  side: const MaterialStatePropertyAll(BorderSide(
                      color: Color.fromARGB(255, 163, 248, 4), width: 2)),
                  elevation: const MaterialStatePropertyAll(10),
                  backgroundColor: const MaterialStatePropertyAll(
                      Color.fromARGB(255, 0, 186, 43)),
                  fixedSize: const MaterialStatePropertyAll(Size(200, 50)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                ),
                child: const Text(
                  "Ok",
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
