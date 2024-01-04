import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_the_box/componennts/components.dart';
import 'package:guess_the_box/constant/constant.dart';
import 'package:guess_the_box/screen/homepage/homescreen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MainScreen extends StatefulWidget {
  static const String routename = "/mainscreen";
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    CustomComponents.playsound("sounds/Pikmin.mp3");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backgroundd.jpg"),
                fit: BoxFit.cover,
                opacity: 0.9),
          ),
          child: Column(
            children: [
              Column(
                children: [
                  // Container(
                  //   height: 50,
                  //   width: size.width,
                  //   color: Colors.transparent,
                  //   alignment: Alignment.centerRight,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Container(
                  //         height: 30,
                  //         width: 80,
                  //         alignment: Alignment.center,
                  //         margin: const EdgeInsets.only(left: 10),
                  //         decoration: const BoxDecoration(
                  //           color: Color.fromARGB(255, 60, 21, 7),
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(14),
                  //           ),
                  //         ),
                  //         child: Row(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             Image.asset(
                  //               "assets/coinicon.png",
                  //               height: 25,
                  //               width: 25,
                  //               fit: BoxFit.contain,
                  //             ),
                  //             const Padding(
                  //               padding: EdgeInsets.only(left: 10),
                  //               child: Text(
                  //                 "100",
                  //                 style: TextStyle(
                  //                   color: Color.fromARGB(255, 236, 229, 229),
                  //                   fontWeight: FontWeight.w700,
                  //                 ),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    color: const Color.fromARGB(255, 51, 15, 2),
                    child: Text(
                      'Guaranteed prizes every 5 level',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmMono(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: const Color.fromARGB(255, 235, 214, 207),
                          shadows: [
                            const Shadow(
                                color: Color.fromARGB(255, 133, 65, 40),
                                blurRadius: 10,
                                offset: Offset(1, 1))
                          ]),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(alignment: Alignment.bottomCenter, children: [
                Image.asset(
                  "assets/firework.png",
                  height: 250,
                  width: size.width,
                  fit: BoxFit.contain,
                ),
                Image.asset(
                  "assets/boxopen.png",
                  height: 200,
                  width: size.width,
                  fit: BoxFit.contain,
                )
                    .animate(
                        autoPlay: true,
                        onPlay: (controller) {
                          controller.repeat(reverse: true);
                        })
                    .moveY(
                        duration: 2.seconds,
                        curve: Curves.linear,
                        transformHitTests: true,
                        begin: 0,
                        end: -5)
                    .shake(
                        // delay: 200.ms,
                        duration: 5.seconds,
                        curve: Curves.linear,
                        hz: 0.26,
                        rotation: 0.08),
                // .shake(duration: 2.seconds, rotation: 0.2, hz: 0.5),
                GradientText(
                  'Guess The Box',
                  style: GoogleFonts.firaCode(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      shadows: [
                        const Shadow(
                          color: Color.fromARGB(255, 87, 62, 52),
                          offset: Offset(4, 4),
                          blurRadius: 15.0,
                        )
                      ]),
                  colors: const [
                    Color.fromARGB(255, 227, 215, 214),
                    Color.fromARGB(255, 223, 218, 218),
                  ],
                )
                    .animate(
                        autoPlay: true,
                        onPlay: (controller) {
                          controller.repeat();
                        })
                    .shake(
                        duration: 5.seconds,
                        // curve: Curves.ease,
                        hz: 0.2,
                        rotation: 0.02),
              ]),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text.rich(
                      TextSpan(
                        text: "Chance to earn even better \n rewards in ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                              text: "Super Jackpot ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 199, 112, 5))),
                          TextSpan(text: "levels")
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //container 1
                            Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage('assets/coinbox.png'),
                                      fit: BoxFit.cover,
                                      opacity: 0.6,
                                    ),
                                    color: ColorList.tilecolor,
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 244, 209, 54),
                                      width: 3,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: const Text(
                                    "500",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromARGB(255, 218, 208, 208),
                                        shadows: [
                                          Shadow(
                                            color: Colors.brown,
                                            offset: Offset(3, 3),
                                            blurRadius: 15.0,
                                          )
                                        ]),
                                  ),
                                ),
                                const Text("hidden in:")
                              ],
                            ),
                            const SizedBox(width: 10),
                            //container 2
                            Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage('assets/coinbox.png'),
                                      fit: BoxFit.cover,
                                      opacity: 0.6,
                                    ),
                                    color: ColorList.tilecolor,
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 244, 209, 54),
                                      width: 3,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: const Text(
                                    "500",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromARGB(255, 218, 208, 208),
                                        shadows: [
                                          Shadow(
                                            color: Colors.brown,
                                            offset: Offset(3, 3),
                                            blurRadius: 15.0,
                                          )
                                        ]),
                                  ),
                                ),
                                const Text("hidden in:")
                              ],
                            ),
                          ],
                        ),
                        Container(
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 1),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 236, 175, 7),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 1,
                                color: Color.fromARGB(255, 238, 193, 11),
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //container 1
                            Container(
                              height: 50,
                              width: 50,
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                color: ColorList.tilecolor,
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 244, 209, 54),
                                  width: 3,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    "Level",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromARGB(255, 218, 208, 208),
                                        shadows: [
                                          Shadow(
                                            color: Colors.brown,
                                            offset: Offset(3, 3),
                                            blurRadius: 15.0,
                                          )
                                        ]),
                                  ),
                                  Text(
                                    "20",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromARGB(255, 218, 208, 208),
                                        shadows: [
                                          Shadow(
                                            color: Colors.brown,
                                            offset: Offset(3, 3),
                                            blurRadius: 15.0,
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            //container 2
                            Container(
                              height: 50,
                              width: 50,
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                color: ColorList.tilecolor,
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 244, 209, 54),
                                  width: 3,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    "Level",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromARGB(255, 218, 208, 208),
                                        shadows: [
                                          Shadow(
                                            color: Colors.brown,
                                            offset: Offset(3, 3),
                                            blurRadius: 15.0,
                                          )
                                        ]),
                                  ),
                                  Text(
                                    "30",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromARGB(255, 218, 208, 208),
                                        shadows: [
                                          Shadow(
                                            color: Colors.brown,
                                            offset: Offset(3, 3),
                                            blurRadius: 15.0,
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 1),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 236, 175, 7),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 1,
                                color: Color.fromARGB(255, 238, 193, 11),
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, HomePage.routename);
                      },
                      child: Container(
                        height: 50,
                        width: size.width * 0.5,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 2, 150, 7),
                              Color.fromARGB(255, 29, 173, 3),
                            ]),
                            border: Border.all(
                                color: const Color.fromARGB(255, 153, 176, 97),
                                width: 3),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 78, 2, 2)
                                    .withOpacity(0.6),
                                spreadRadius: 4,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              )
                            ]),
                        child: const Text(
                          'Play Now',
                          style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
