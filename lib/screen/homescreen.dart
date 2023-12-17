// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:guess_the_box/componennts/components.dart';
import 'package:guess_the_box/constant/constant.dart';
import 'package:scroll_to_id/scroll_to_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routename = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  /* -------------------------------- variable -------------------------------- */

  ScrollToId? scrollToId;
  final ScrollController scrollController = ScrollController();

  bool isGameOver = false;
  List<String> rewards = [
    "assets/reward1.jpg",
    "assets/reward2.jpeg",
    "assets/reward4.jpg",
    "assets/bomby.jpg",
  ];

  List<String>? suffledRewards;
  int bombcontainerindex = 0;
  int rewardcontainerindex = 0;
  List<bool> isContainerTapped = [false, false, false, false];
  String displaysuffledimage = '';
  int level = 1;
  late int coin = 0;

  /* -------------------------------- function -------------------------------- */

  void nextlevel(int selectedContainer) {
    setState(() {
      isGameOver = false;
      level++;
    });
    scrollToId!.animateTo('$level',
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    if (suffledRewards![selectedContainer] == 'assets/reward1.jpg') {
      coin += 50;
    } else if (suffledRewards![selectedContainer] == 'assets/reward2.jpeg') {
      coin += 100;
    } else if (suffledRewards![selectedContainer] == 'assets/reward4.jpg') {
      coin += 200;
    } else if (suffledRewards![selectedContainer] == 'assets/bomby.jpg') {
      coin += 0;
    }
  }

  void playAgain() {
    setState(() {
      isGameOver = false;
      level = 1;
      coin = 0;
    });
    scrollToId!.animateTo('$level',
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  void initState() {
    loadData();
    super.initState();

    scrollToId = ScrollToId(scrollController: scrollController);
    scrollController.addListener(() {
      if (scrollToId != null) {
        scrollToId!.idPosition();
      } else {
        // print("nullvalue");
      }
    });
    scrollToId!.animateTo('$level',
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      coin = prefs.getInt("coin") ?? 0;
    });
  }

  void onContainerTap(int selectedContainer, BuildContext context) {
    suffledRewards = List<String>.from(rewards)..shuffle();
    var suffledbombindex = suffledRewards!.indexOf('assets/bomby.jpg');
    rewardcontainerindex = Random().nextInt(rewards.length);
    bombcontainerindex = suffledbombindex;
    // print("suffledreward = $suffledRewards");
    // print("selectedcontainer = $selectedContainer");
    // print("rewardcontainerindex = $rewardcontainerindex");
    // print("bombcontainerindex = $bombcontainerindex");

    if (selectedContainer == bombcontainerindex) {
      setState(() {
        isContainerTapped[selectedContainer] = true;

        Timer(const Duration(milliseconds: 100), () {
          isGameOver = true;
        });

        displaysuffledimage = suffledRewards![selectedContainer];
        // print("bombcontainer image = $displaysuffledimage");
      });
    } else {
      setState(() {
        isContainerTapped[selectedContainer] = true;
        displaysuffledimage = suffledRewards![selectedContainer];
        // print("tapped container image = $displaysuffledimage");
      });
    }

    Future.delayed(const Duration(seconds: 1), () {
      if (selectedContainer == bombcontainerindex) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Oops! you lost the game',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Gap(10),
                  const Text(
                    'Your all reward will be lost',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      image: DecorationImage(
                        image: AssetImage(displaysuffledimage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Gap(20),
                  const Text(
                    'Your next Box is guaranted prize',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/10199.jpg'),
                            fit: BoxFit.cover,
                          ),
                          color: ColorList.tilecolor,
                          border: Border.all(
                            color: ColorList.bordercolor,
                            width: 3,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '1019',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('assets/reward4.jpg'),
                              fit: BoxFit.cover),
                          color: ColorList.tilecolor,
                          border: Border.all(
                              color: ColorList.bordercolor, width: 3),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red),
                          ),
                          onPressed: () {
                            CustomComponents.showGiveUpDialog(context);
                          },
                          child: const Text(
                            'Give Up',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 4, 217, 11),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isGameOver = true;
                          });
                          Timer(const Duration(seconds: 1), () {
                            playAgain();
                            scrollToId!.animateTo('$level',
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Play Again',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                ],
              ),
            );
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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  /* -------------------------------------------------------------------------- */
  /*                            widget build start                            */
  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("current level is $level");

    return Scaffold(
      backgroundColor: Colors.red.withOpacity(0.6),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            /* ------------------------------- first part ------------------------------- */

            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: AppBar(
                        backgroundColor: ColorList.appbarcolor,
                        automaticallyImplyLeading: false,
                        // leadingWidth: 120,
                        // leading: Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 14, horizontal: 10),
                        //   child: Container(
                        //     height: 30,
                        //     decoration: BoxDecoration(
                        //       color: ColorList.backgroundcolor,
                        //       borderRadius: const BorderRadius.all(
                        //         Radius.circular(14),
                        //       ),
                        //     ),
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       "Level $level",
                        //       style: const TextStyle(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.w700,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        actions: [
                          Container(
                            width: 80,
                            decoration: BoxDecoration(
                                color: ColorList.backgroundcolor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(14))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    Icons.attach_money_outlined,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    coin.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Gap(20)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Gap(25),
                          const Text(
                            'GuessTheBox',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const Gap(25),
                          InkWell(
                            onTap: () {
                              CustomComponents.infoDialog(context);
                            },
                            child: const Icon(
                              Icons.info_outline,
                              color: Colors.lightBlueAccent,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: ColorList.bordercolor,
                  ),
                  // /*     -------------------------------- level row ------------------------------- */
                  Container(
                    width: size.width,
                    // color: Colors.amber,
                    height: 50,
                    child: InteractiveScrollViewer(
                      scrollDirection: Axis.horizontal,
                      scrollToId: scrollToId,
                      children: List.generate(
                        1000,
                        (index) {
                          return ScrollContent(
                            id: "${index + 1}",
                            child: Container(
                              alignment: Alignment.center,
                              // padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border: Border.all(
                                  color: ColorList.bordercolor,
                                  width: 4,
                                ),
                              ),
                              width: 60,
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  color: ColorList.bordercolor,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: ColorList.bordercolor,
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      color: ColorList.tilecolor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Expanded(
                            child: Text(
                              'Next Jackpot is a guaranted reward!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
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
                                border:
                                    Border.all(color: ColorList.bordercolor)),
                            child: Text(
                              '10',
                              style: TextStyle(
                                fontSize: 20,
                                color: ColorList.bordercolor,
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
            ),

            /* -------------------------------------------------------------------------- */
            /*                             reward box section                             */
            /* -------------------------------------------------------------------------- */
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 2.3),
                  ),
                  itemCount: rewards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (!isGameOver) {
                          onContainerTap(index, context);
                        }
                      },
                      child: !isGameOver
                          ? ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: Image.asset(
                                'assets/rewardimage.jpeg',
                                fit: BoxFit.cover,
                              ).animate().shake(
                                  duration: 300.milliseconds,
                                  delay: 500.milliseconds),
                            ).animate().shake(
                                duration: 300.milliseconds,
                                delay: 500.milliseconds,
                              )
                          : ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: Image.asset(
                                suffledRewards![index],
                                fit: BoxFit.cover,
                              )
                                  .animate()
                                  .shake(duration: 400.milliseconds)
                                  .then(delay: 200.milliseconds)
                                  .moveX(end: -500),
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
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        width: 60,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/10199.jpg'),
                            fit: BoxFit.cover,
                          ),
                          color: ColorList.tilecolor,
                          border: Border.all(
                            color: ColorList.bordercolor,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      const Gap(20),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/reward4.jpg'),
                            fit: BoxFit.cover,
                          ),
                          color: ColorList.tilecolor,
                          border: Border.all(
                            color: ColorList.bordercolor,
                            width: 3,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                      )
                    ],
                  ),
                  const Gap(10),
                  Flexible(
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(10),
                        shadowColor: MaterialStatePropertyAll(Colors.black38),
                        backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 6, 195, 12),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          loadData();
                        });
                        SystemNavigator.pop();
                      },
                      child: const Text(
                        'Leave with rewards',
                        style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 16,
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
    );
  }
}
