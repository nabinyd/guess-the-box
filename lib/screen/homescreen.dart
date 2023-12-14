// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:guess_the_box/componennts/components.dart';
import 'package:guess_the_box/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routename = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* -------------------------------- variable -------------------------------- */
  bool isGameOver = false;
  List<String> rewards = [
    "assets/reward1.jpg",
    "assets/reward2.jpg",
    "assets/reward3.jpg",
    "assets/bomby.jpg",
  ];

  List<String>? suffledRewards;
  int bombcontainerindex = 0;
  int rewardcontainerindex = 0;
  List<bool> isContainerTapped = [false, false, false, false];
  String displaysuffledimage = '';
  int level = 1;
  int coin = 0;
  bool activelevel = false;

  /* -------------------------------- function -------------------------------- */

  savecoin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('coin', coin);
  }

  loadCoin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savecoin = prefs.getInt('coin') ?? 0;
    setState(() {
      coin = savecoin;
    });
  }

  void onContainerTap(int selectedContainer, BuildContext context) {
    suffledRewards = List<String>.from(rewards)..shuffle();
    var suffledbombindex = suffledRewards!.indexOf('assets/bomby.jpg');
    rewardcontainerindex = Random().nextInt(rewards.length);
    bombcontainerindex = suffledbombindex;
    print("suffledreward = $suffledRewards");
    print("selectedcontainer = $selectedContainer");
    print("rewardcontainerindex = $rewardcontainerindex");
    print("bombcontainerindex = $bombcontainerindex");

    if (selectedContainer == bombcontainerindex) {
      setState(() {
        isContainerTapped[selectedContainer] = true;

        Timer(const Duration(milliseconds: 100), () {
          isGameOver = true;
        });

        displaysuffledimage = suffledRewards![selectedContainer];
        print("bombcontainer image = $displaysuffledimage");
      });
    } else {
      setState(() {
        isContainerTapped[selectedContainer] = true;
        // Future.delayed(Duration.zero, () {
        //   isGameOver = true;
        // });
        displaysuffledimage = suffledRewards![selectedContainer];
        print("tapped container image = $displaysuffledimage");
      });
    }

    Future.delayed(const Duration(milliseconds: 800), () {
      if (selectedContainer == bombcontainerindex) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              backgroundColor: Colors.red.shade400.withOpacity(0.9),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Oops! you lost the game',
                    style: MyTextstyle.displaylarge,
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
                            image: AssetImage('assets/reeward4.jpg'),
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
                                image: AssetImage('assets/reward3.jpg'),
                                fit: BoxFit.cover),
                            color: ColorList.tilecolor,
                            border: Border.all(
                                color: ColorList.bordercolor, width: 3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
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
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          )),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 4, 217, 11),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'play on \$20',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(20),
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
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Play Again',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              backgroundColor: Colors.green.shade600.withOpacity(0.9),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Congratulation! you won',
                    style: MyTextstyle.displaylarge,
                  ),
                  const Gap(20),
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
                            image: AssetImage('assets/reeward4.jpg'),
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
                              image: AssetImage('assets/reward3.jpg'),
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
                            CustomComponents.showGiveUpWinBoxDialog(
                              context,
                            );
                          },
                          child: const Text(
                            'Give Up',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
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
                            playonCoin();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'play on \$200',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(20),
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
                        nextlevel(selectedContainer);
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Next level',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    });
  }

  void nextlevel(int selectedContainer) {
    setState(() {
      isGameOver = false;
      level++;
      activelevel = true;
    });
    if (suffledRewards![selectedContainer] == 'assets/reward1.jpg') {
      coin += 50;
    } else if (suffledRewards![selectedContainer] == 'assets/reward2.jpg') {
      coin += 200;
    } else if (suffledRewards![selectedContainer] == 'assets/reward3.jpg') {
      coin += 300;
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
  }

  playonCoin() {
    setState(() {
      isGameOver = false;
      coin -= 200;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /* -------------------------------------------------------------------------- */
  /*                            widget build start                            */
  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print("widget suffeledreward =  $displaysuffledimage ");
    print("widget bombcontainer index is = $bombcontainerindex");
    print("isgameover = $isGameOver");
    return Scaffold(
      backgroundColor: Colors.red.withOpacity(0.6),
      extendBody: true,
      appBar: AppBar(
        backgroundColor: ColorList.appbarcolor,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            width: 80,
            decoration: BoxDecoration(
              color: ColorList.backgroundcolor,
              borderRadius: const BorderRadius.all(
                Radius.circular(14),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.diamond_rounded),
                Text(
                  '641',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          Container(
            width: 80,
            decoration: BoxDecoration(
                color: ColorList.backgroundcolor,
                borderRadius: const BorderRadius.all(Radius.circular(14))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.money),
                  Text(
                    coin.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      /* -------------------------------------------------------------------------- */
      /*                                    body                                    */
      /* -------------------------------------------------------------------------- */
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Gap(25),
                  Text(
                    'GuessTheBox',
                    style: MyTextstyle.displaylarge,
                  ),
                  const Gap(25),
                  InkWell(
                    onTap: () {
                      CustomComponents.infoDialog(context);
                    },
                    child: const Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 5,
              width: size.width,
              color: ColorList.bordercolor,
            ),

            // /* -------------------------------- level row ------------------------------- */

            Container(
              height: 70,
              child: ListView.builder(
                itemCount: 1000,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: level == index + 1
                          ? Colors.red.withOpacity(0.6)
                          : const Color.fromARGB(255, 126, 39, 10),
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          color: level == index + 1
                              ? Colors.white
                              : ColorList.bordercolor,
                          width: 5),
                    ),
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        color: level == index + 1
                            ? Colors.white
                            : ColorList.bordercolor,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              height: 5,
              width: size.width,
              color: ColorList.bordercolor,
            ),
            const Gap(5),
            Container(
              height: 60,
              color: ColorList.tilecolor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Gap(20),
                  const Text(
                    'Next Jackpot \nis a guaranted reward!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
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
            const Gap(10),
            /* -------------------------------------------------------------------------- */
            /*                             reward box section                             */
            /* -------------------------------------------------------------------------- */
            Container(
              height: 380,
              width: size.width,
              padding: const EdgeInsets.all(10),
              // color: const Color.fromARGB(255, 119, 39, 9),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.1,
                ),
                itemCount: rewards.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (!isGameOver) {
                        onContainerTap(index, context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Colors.green,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            !isGameOver
                                ? 'assets/rewardimage.png'
                                : suffledRewards![index],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            /* -------------------------------------------------------------------------- */
            /*                               ribbon section                               */
            /* -------------------------------------------------------------------------- */
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/reeward4.jpg'),
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
                            color: Color.fromARGB(255, 54, 238, 244),
                          ),
                        ),
                      ),
                      const Gap(20),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/reward3.jpg'),
                            fit: BoxFit.cover,
                          ),
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
                  const Gap(10),
                  ElevatedButton(
                      style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(10),
                        shadowColor: MaterialStatePropertyAll(Colors.black38),
                        backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 6, 195, 12),
                        ),
                      ),
                      onPressed: () {
                        savecoin();
                        SystemNavigator.pop();
                      },
                      child: const Text(
                        'Leave with rewards',
                        style: TextStyle(letterSpacing: 1, fontSize: 16),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
