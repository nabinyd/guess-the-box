// ignore_for_file: sized_box_for_whitespace

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_box/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuessTheBox extends StatefulWidget {
  const GuessTheBox({super.key});

  @override
  State<GuessTheBox> createState() => _GuessTheBoxState();
}

class _GuessTheBoxState extends State<GuessTheBox> {
  /* -------------------------------- List container------------------------------- */
  bool isGameOver = false;

  List<String> rewards = [
    "assets/reward1.jpg",
    "assets/reward2.jpg",
    "assets/reward3.jpg",
    "assets/bomby.jpg",
  ];
  /* -------------------------------- variable -------------------------------- */
  List<String>? suffledRewards;
  int bombcontainerindex = 0;
  int rewardcontainerindex = 0;
  List<bool> isContainerTapped = [false, false, false, false];
  String displaysuffledimage = '';
  int level = 1;
  int coin = 0;
  

  @override
  void initState() {
    super.initState();
    nextlevel();
    playAgain();
    loadCoin();
    savecoin();
  }

  /* -------------------------------- function -------------------------------- */

  void nextlevel() {
    suffledRewards = List<String>.from(rewards)..shuffle();
    rewardcontainerindex = Random().nextInt(4);
    bombcontainerindex = Random().nextInt(4);
    // displayImage = suffledRewards![rewardcontainerindex.toInt()];
    displaysuffledimage = suffledRewards![rewardcontainerindex.toInt()];
    setState(() {
      isGameOver = false;
      level++;
    });
    if (suffledRewards![rewardcontainerindex] == 'assets/reward1.jpg') {
      coin += 50;
    }
    if (suffledRewards![rewardcontainerindex] == 'assets/reward2.jpg') {
      coin += 200;
    }
    if (suffledRewards![rewardcontainerindex] == 'assets/reward3.jpg') {
      coin += 300;
    }
    if (suffledRewards![rewardcontainerindex] == 'assets/bomby.jpg') {
      coin += 0;
    }
  }

  void playAgain() {
    suffledRewards = List<String>.from(rewards)..shuffle();
    rewardcontainerindex = Random().nextInt(4);
    bombcontainerindex = Random().nextInt(4);
    isGameOver = false;
    setState(() {
      level = 1;
      coin = 0;
    });
  }

  void savecoin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('coin', coin);
  }

  void loadCoin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savecoin = prefs.getInt('coin') ?? 0;
    setState(() {
      coin = savecoin;
    });
  }

  void onContainerTap(int selectedContainer) {
    if (selectedContainer == rewardcontainerindex) {
      setState(() {
        isContainerTapped[selectedContainer] = true;
        level++;
      });
    } else if (selectedContainer == bombcontainerindex) {
      setState(() {
        isContainerTapped[selectedContainer] = true;
      });
    } else {
      setState(() {
        isContainerTapped[selectedContainer] = true;
      });
    }

    Future.delayed(const Duration(seconds: 1), () {
      if (selectedContainer == rewardcontainerindex) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor:
                  const Color.fromARGB(255, 115, 60, 40).withOpacity(0.6),
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Oops! you lose ',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Image.asset(
                    //     displaysuffledimage,
                    //     fit: BoxFit.cover,
                    //     height: 150,
                    //     width: 150,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Your all reward will be lost',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/reeward4.jpg'),
                                    fit: BoxFit.cover),
                                color: ColorList.tilecolor,
                                border: Border.all(
                                    color: ColorList.bordercolor, width: 3),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: const Text(
                              '1019',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/reward3.jpg'),
                                    fit: BoxFit.cover),
                                color: ColorList.tilecolor,
                                border: Border.all(
                                    color: ColorList.bordercolor, width: 3),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Your next Box is guaranted prize',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.red)),
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            child: const Text(
                              'Give Up',
                              style: TextStyle(fontSize: 16),
                            )),
                        ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 4, 217, 11))),
                            onPressed: () {
                              Navigator.of(context).pop();
                              nextlevel();
                              // Timer(const Duration(seconds: 1), () {
                              //   displaysuffledimage =
                              //       suffledRewards![selectedContainer];
                              // });
                            },
                            child: const Text(
                              'play on \$20',
                              style: TextStyle(fontSize: 16),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(Size(180, 50)),
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 4, 217, 11))),
                        onPressed: () {
                          Navigator.of(context).pop();
                          playAgain();
                          // Timer(const Duration(seconds: 1), () {
                          //   displaysuffledimage =
                          //       suffledRewards![selectedContainer];
                          // });
                        },
                        child: const Text(
                          'Play again',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        )),
                  ],
                ),
                Positioned(
                    top: 8,
                    right: 15,
                    child: IconButton(
                        tooltip: 'Close',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 26,
                        )))
              ]),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: AlertDialog(
                alignment: Alignment.center,
                backgroundColor: const Color.fromARGB(255, 181, 132, 121),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'congratulation!! you won',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        displaysuffledimage,
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                      ),
                    ),
                    const Text(
                      'you got the prize',
                      style: TextStyle(color: Color.fromARGB(255, 4, 49, 86)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/reeward4.jpg'),
                                    fit: BoxFit.cover),
                                color: ColorList.tilecolor,
                                border: Border.all(
                                    color: ColorList.bordercolor, width: 3),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: const Text(
                              '1019',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/reward3.jpg'),
                                    fit: BoxFit.cover),
                                color: ColorList.tilecolor,
                                border: Border.all(
                                    color: ColorList.bordercolor, width: 3),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Your next Box is guaranted prize',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.red)),
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            child: const Text(
                              'Give Up',
                              style: TextStyle(fontSize: 16),
                            )),
                        ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 4, 217, 11))),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Timer(const Duration(seconds: 2), () {
                                displaysuffledimage =
                                    suffledRewards![selectedContainer];
                              });
                              nextlevel();
                            },
                            child: const Text(
                              'play on \$20',
                              style: TextStyle(fontSize: 16),
                            ))
                      ],
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 4, 217, 11))),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Timer(const Duration(seconds: 1), () {
                            displaysuffledimage =
                                suffledRewards![selectedContainer];
                          });
                          isGameOver = true;
                          nextlevel();
                        },
                        child: const Text(
                          'Next level',
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }

  /* -------------------------------------------------------------------------- */
  /*                            widget build start                            */
  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        bool confirm = await showLeaveConfirmationDialog(context);

        // Return true if the user confirms, allowing the pop
        return confirm;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorList.appbarcolor,
          // title: Text('level: ${level.toString()} '),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                width: 80,
                decoration: BoxDecoration(
                    color: ColorList.backgroundcolor,
                    borderRadius: const BorderRadius.all(Radius.circular(14))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [Icon(Icons.diamond_rounded), Text('641')],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
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
                        Text(coin.toString())
                      ]),
                ),
              ),
            ),
          ],
        ),

        /* -------------------------------------------------------------------------- */
        /*                                    body                                    */
        /* -------------------------------------------------------------------------- */
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            color: Colors.red,
            child: Expanded(
              child: Column(
                children: [
                  ListTile(
                      textColor: Colors.white,
                      titleAlignment: ListTileTitleAlignment.center,
                      tileColor: ColorList.tilecolor,
                      title: const Text(
                        'Guess the box',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      horizontalTitleGap: 20,
                      trailing: IconButton(
                          onPressed: () {
                            InfoDialog(context);
                          },
                          icon: const Icon(
                            Icons.info_outline,
                            color: Colors.blue,
                          ))),
                  Container(
                    height: 5,
                    width: double.infinity,
                    color: ColorList.bordercolor,
                  ),
                  /* -------------------------------- level row ------------------------------- */
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      color: ColorList.backgroundcolor,
                      child: Row(
                        children: [
                          for (int i = 1; i < 1000; i++)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                alignment: Alignment.center,
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: level == i
                                        ? Colors.red
                                        : Colors.brown[i],
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    border: Border.all(
                                        color: level == i
                                            ? Colors.black
                                            : ColorList.bordercolor,
                                        width: 5)),
                                child: Text(
                                  '$i',
                                  style: TextStyle(
                                      color: level == i
                                          ? Colors.black
                                          : ColorList.bordercolor,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                    width: size.width,
                    color: ColorList.bordercolor,
                  ),
                  Container(
                    height: 50,
                    color: ColorList.tilecolor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Next Jackpot \nis a guaranted reward!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.transparent,
                                border: Border.all(color: Colors.black),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Color.fromARGB(255, 125, 62, 38)),
                                child: Text(
                                  '10',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: ColorList.bordercolor),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  /* -------------------------------------------------------------------------- */
                  /*                             reward box section                             */
                  /* -------------------------------------------------------------------------- */
                  Container(
                    height: 400,
                    width: size.width,
                    color: const Color.fromARGB(255, 119, 39, 9),
                    child: Center(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          // mainAxisSpacing: 5,
                          // crossAxisSpacing: 5,
                          crossAxisCount: 2,
                        ),
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              if (!isGameOver) {
                                onContainerTap(index);
                              }
                            },
                            child: Center(
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    boxShadow: const <BoxShadow>[
                                      BoxShadow(
                                          blurRadius: 15,
                                          spreadRadius: 3,
                                          color:
                                              Color.fromARGB(255, 73, 22, 2)),
                                    ],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(!isGameOver &&
                                                index == rewardcontainerindex
                                            ? (index == bombcontainerindex
                                                ? 'assets/bomby.jpg'
                                                : suffledRewards![index])
                                            : 'assets/rewardimage.png')
                                        // image: AssetImage(!isGameOver &&
                                        //         index == rewardcontainerindex
                                        //     ? suffledRewards![index]
                                        //     : 'assets/rewardimage.png')

                                        )),
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
                    child: Container(
                      color: ColorList.backgroundcolor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Stack(children: [
                              Positioned(
                                left: 10,
                                right: 10,
                                bottom: 5,
                                top: -10,
                                child: Image.asset(
                                  'assets/ribbon.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: 5,
                                width: MediaQuery.of(context).size.width,
                                color: ColorList.bordercolor,
                              ),
                              const SizedBox(height: 25),
                            ]),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/reeward4.jpg'),
                                            fit: BoxFit.cover),
                                        color: ColorList.tilecolor,
                                        border: Border.all(
                                            color: ColorList.bordercolor,
                                            width: 3),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: const Text(
                                      '1019',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/reward3.jpg'),
                                            fit: BoxFit.cover),
                                        color: ColorList.tilecolor,
                                        border: Border.all(
                                            color: ColorList.bordercolor,
                                            width: 3),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                  )
                                ],
                              ),
                            ),
                            ElevatedButton(
                                style: const ButtonStyle(
                                    elevation: MaterialStatePropertyAll(10),
                                    shadowColor: MaterialStatePropertyAll(
                                        Colors.black38),
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 6, 195, 12))),
                                onPressed: () {
                                  savecoin();

                                  SystemNavigator.pop();
                                },
                                child: const Text(
                                  'Leave with rewards',
                                  style:
                                      TextStyle(letterSpacing: 1, fontSize: 16),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> InfoDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          backgroundColor: const Color.fromARGB(255, 131, 68, 45),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Guess The box',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 219, 216, 211)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 26,
                      color: Colors.red,
                    )),
              )
            ],
          ),
          content: Container(
            height: 200,
            decoration: const BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: -10,
                  offset: Offset(0, 1),
                  color: Color.fromARGB(255, 65, 29, 16)),
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(0, 1),
                  color: Color.fromARGB(255, 102, 41, 17))
            ], borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
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
          ),
        );
      },
    );
  }

  showLeaveConfirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Do you really want to leave this screen?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
