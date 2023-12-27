// ignore_for_file: sized_box_for_whitespace, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guess_the_box/componennts/components.dart';
import 'package:guess_the_box/componennts/leavewithreward.dart';
import 'package:guess_the_box/componennts/messagescreen.dart';
import 'package:guess_the_box/componennts/pushnotification.dart';
import 'package:guess_the_box/constant/constant.dart';
import 'package:guess_the_box/services/firebaseservice.dart';
import 'package:guess_the_box/screen/auth/loginscreen.dart';
import 'package:guess_the_box/screen/reward/lostdialogbox.dart';
import 'package:guess_the_box/services/sharedprefsservice.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routename = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  /* -------------------------------- variable -------------------------------- */
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  final ItemScrollController itemScrollController = ItemScrollController();

  bool isGameOver = false;

  List<String> rewards = [
    "assets/reward1.jpg",
    "assets/reward2.jpeg",
    "assets/reward4.jpg",
    "assets/rewardbox.jpg",
    // "assets/bomby.jpg",
  ];

  List<String>? suffledRewards;
  int bombcontainerindex = 0;
  int rewardcontainerindex = 0;
  List<bool> isContainerTapped = [false, false, false, false];
  String displaysuffledimage = '';
  int level = 1;
  int totalcoin = 0;
  late int coin = 0;
  int countbox = 0;
  int jackpotlevel = 5;
  bool showLeaveWithRewardButton = false;

  /* -------------------------------- function -------------------------------- */
  loadCoin() async {
    coin = await CoinManager.retrieveCoins(userId.toString()) ?? 0;
  }

  @override
  void initState() {
    super.initState();
    loadCoin();
  }

  

  void onContainerTap(int selectedContainer, BuildContext context) {
    suffledRewards = List<String>.from(rewards)..shuffle();
    var suffledbombindex = suffledRewards!.indexOf('assets/bomby.jpg');
    rewardcontainerindex = Random().nextInt(rewards.length);
    bombcontainerindex = suffledbombindex;
    SharedPrefs.saveProgress(coin);

    if (selectedContainer == bombcontainerindex) {
      setState(() {
        isContainerTapped[selectedContainer] = true;
        Timer(const Duration(milliseconds: 100), () {
          isGameOver = true;
        });

        displaysuffledimage = suffledRewards![selectedContainer];
      });
    } else {
      setState(() {
        isContainerTapped[selectedContainer] = true;
        displaysuffledimage = suffledRewards![selectedContainer];
        if (level == 3) {
          rewards.add("assets/bomby.jpg");
        }
        if (level % 5 == 0) {
          jackpotlevel = level + 5;
        }
      });
    }

    Future.delayed(const Duration(seconds: 1), () {
      if (selectedContainer == bombcontainerindex) {
        showDialog(
          context: context,
          builder: (_) {
            return LostDialogBox(
                displaysuffledimage: displaysuffledimage,
                playAgain: playAgain,
                isGameOver: isGameOver,
                level: level,
                points: coin);
          },
        );
      } else {
        setState(() {
          isGameOver = true;
        });
        Timer(const Duration(seconds: 1), () {
          nextlevel(selectedContainer);
        });
      }
    });
  }

  void nextlevel(int selectedContainer) {
    itemScrollController.scrollTo(
        index: level,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear);
    setState(() {
      isGameOver = false;
      level++;
      if (level >= 3) {
        showLeaveWithRewardButton = true;
      }
    });

    if (suffledRewards![selectedContainer] == 'assets/reward1.jpg') {
      coin += 50;
    } else if (suffledRewards![selectedContainer] == 'assets/reward2.jpeg') {
      coin += 100;
    } else if (suffledRewards![selectedContainer] == 'assets/reward4.jpg') {
      coin += 200;
    } else if (suffledRewards![selectedContainer] == 'assets/bomby.jpg') {
      coin += 0;
    } else if (suffledRewards![selectedContainer] == "assets/rewardbox.jpg") {
      setState(() {
        countbox++;
      });
    }
  }

  void playAgain() async {
    setState(() {
      isGameOver = false;
      level = 1;
      coin = 0;
      countbox = 0;
      jackpotlevel = 5;
      itemScrollController.scrollTo(
          index: level - 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear);
      showLeaveWithRewardButton = false;
      if (level < 3) {
        rewards.remove("assets/bomby.jpg");
      }
    });
  }

  /* -------------------------------------------------------------------------- */
  /*                            widget build start                            */
  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print("userID = $userId");

    return Scaffold(
      extendBody: false,
      extendBodyBehindAppBar: false,
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
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: size.width,
                      color: Colors.transparent,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
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
                                    coin.toString(),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 236, 229, 229),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          userId == null
                              ? IconButton(
                                  onPressed: () async {
                                    await FirebaseLoginServices().signOut();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LogInPage()));
                                  },
                                  icon: const Icon(
                                    Icons.login,
                                    color: Colors.white,
                                    size: 28,
                                  ))
                              : IconButton(
                                  onPressed: () async {
                                    await FirebaseLoginServices().signOut();
                                    // await CoinManager.saveCoins(
                                    //     userId.toString(), coin);
                                    //   saving coin to firebase before logging out
                                    // final localProgress =
                                    //     await SharedPrefs.getLocalCoin();
                                    // await CoinManager.saveCoins(
                                    //     userId.toString(), localProgress);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LogInPage()));
                                  },
                                  icon: const Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                    size: 24,
                                  ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 112, 43, 18),
                                Color.fromARGB(255, 106, 29, 1),
                                Color.fromARGB(255, 112, 43, 18),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Gap(20),
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
                                Color.fromARGB(255, 210, 185, 182),
                                Color.fromARGB(255, 218, 176, 176),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                CustomComponents.infoDialog(context);
                                PushnotificationApi.sendNotification();
                              },
                              child: const Icon(Icons.info_outline_rounded,
                                  color: Colors.lightBlueAccent, size: 28),
                            ),
                          ],
                        ),
                      ),
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
                    /* -------------------------------- level row ------------------------------- */
                    levelRow(
                        itemScrollController: itemScrollController,
                        level: level),
                    Material(
                      elevation: 20,
                      child: Container(
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 1),
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 5,
                              color: Color.fromARGB(255, 128, 60, 1),
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        elevation: 20,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 112, 43, 18),
                                  Color.fromARGB(255, 106, 29, 1),
                                  Color.fromARGB(255, 112, 43, 18),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 79, 1, 1)
                                    .withOpacity(0.4),
                                spreadRadius: 6,
                                blurRadius: 10,
                                offset: const Offset(1, 1),
                              )
                            ],
                            color: const Color.fromARGB(255, 147, 55, 22),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Text(
                                  'Next Jackpot\nis a guaranted reward!',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dmMono(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: const Color.fromARGB(
                                          255, 235, 214, 207),
                                      shadows: [
                                        const Shadow(
                                            color: Color.fromARGB(
                                                255, 133, 65, 40),
                                            blurRadius: 10,
                                            offset: Offset(1, 1))
                                      ]),
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                margin: const EdgeInsets.only(right: 8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.red.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 231, 183, 10),
                                    width: 3,
                                  ),
                                ),
                                child: Text(
                                  '$jackpotlevel',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 227, 199, 189),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              /* -------------------------------------------------------------------------- */
              /*                             reward box section                             */
              /* -------------------------------------------------------------------------- */
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          if (!isGameOver) {
                            onContainerTap(index, context);
                          }
                          print("the selected box = $index");
                        },
                        child: !isGameOver
                            ? Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 79, 1, 1)
                                        .withOpacity(0.4),
                                    spreadRadius: 8,
                                    blurRadius: 25,
                                    offset: const Offset(1, 1),
                                  )
                                ]),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: Image.asset(
                                    'assets/rewardimage.jpeg',
                                    fit: BoxFit.cover,
                                  ).animate().shake(
                                      duration: 300.milliseconds,
                                      delay: 500.milliseconds),
                                )
                                    .animate()
                                    .moveY(duration: 400.ms, begin: -800)
                                    .shake(
                                      duration: 500.milliseconds,
                                      delay: 500.milliseconds,
                                    ),
                              )
                            : Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 79, 1, 1)
                                        .withOpacity(0.4),
                                    spreadRadius: 8,
                                    blurRadius: 10,
                                    offset: const Offset(1, 1),
                                  )
                                ]),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: Image.asset(
                                    suffledRewards![index],
                                    fit: BoxFit.cover,
                                  )
                                      .animate()
                                      .shake(duration: 400.milliseconds)
                                      .then(delay: 200.milliseconds)
                                      .moveX(end: -500),
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ),

              /* -------------------------------------------------------------------------- */
              /*                               ribbon section                               */
              /* -------------------------------------------------------------------------- */
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: size.height * 0.15,
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 196, 154, 2),
                            ),
                          ),
                          Positioned(
                            child: Image.asset(
                              "assets/pngwing.com (3).png",
                              height: size.height * 0.06,
                              width: size.width * 0.8,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Positioned(
                            child: Text(
                              "Rewards",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(255, 241, 193, 175)),
                            ),
                          )
                        ],
                      ),
                    ),
                    showLeaveWithRewardButton
                        ? Flexible(
                            child: InkWell(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) {
                                      return LeaveWithReward(
                                        playAgain: playAgain,
                                        userId: userId,
                                        coin: coin,
                                      );
                                    });
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
                                        color: const Color.fromARGB(
                                            255, 153, 176, 97),
                                        width: 3),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            const Color.fromARGB(255, 78, 2, 2)
                                                .withOpacity(0.6),
                                        spreadRadius: 4,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      )
                                    ]),
                                child: const Text(
                                  'Leave with rewards',
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ).animate().fade(duration: 1.seconds).show()
                        : Container(),
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

class levelRow extends StatelessWidget {
  const levelRow({
    super.key,
    required this.itemScrollController,
    required this.level,
  });

  final ItemScrollController itemScrollController;
  final int level;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ScrollablePositionedList.builder(
        scrollDirection: Axis.horizontal,
        itemScrollController: itemScrollController,
        itemCount: 1000,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 40,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 203, 63, 12),
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              border: Border.all(
                color: level == index + 1
                    ? const Color.fromARGB(255, 241, 217, 4)
                    : Colors.transparent,
                width: 4,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 15,
                  color: Color.fromARGB(255, 93, 47, 4),
                  offset: Offset(1, 1),
                ),
                BoxShadow(
                  blurRadius: 15,
                  color: Color.fromARGB(255, 103, 54, 4),
                  offset: Offset(-1, -1),
                ),
              ],
            ),
            width: 50,
            child: (index + 1) % 5 == 0
                ? const Icon(
                    Icons.star,
                    size: 26,
                    color: Color.fromARGB(255, 249, 216, 5),
                  )
                : Text(
                    "${index + 1}",
                    style: GoogleFonts.manrope(
                        color: const Color.fromARGB(255, 206, 214, 57),
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          const Shadow(
                            color: Color.fromARGB(255, 166, 141, 52),
                            offset: Offset(1, 1),
                            blurRadius: 8.0,
                          ),
                          const Shadow(
                            color: Color.fromARGB(255, 166, 141, 52),
                            offset: Offset(-1, -1),
                            blurRadius: 8.0,
                          ),
                          const Shadow(
                            color: Color.fromARGB(255, 166, 141, 52),
                            offset: Offset(1, -1),
                            blurRadius: 8.0,
                          ),
                          const Shadow(
                            color: Color.fromARGB(255, 166, 141, 52),
                            offset: Offset(-1, 1),
                            blurRadius: 8.0,
                          ),
                        ]),
                  ),
          );
        },
      ),
    );
  }
}
