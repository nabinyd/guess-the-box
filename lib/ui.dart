// ignore_for_file: sized_box_for_whitespace

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guess_the_box/constant/constant.dart';

class GuessTheBox extends StatefulWidget {
  const GuessTheBox({super.key});

  @override
  State<GuessTheBox> createState() => _GuessTheBoxState();
}

class _GuessTheBoxState extends State<GuessTheBox> {
  /* -------------------------------- List container------------------------------- */
  bool isGameOver = false;
  //   Container(
  //     width: 150,
  //     height: 150,
  //     decoration: const BoxDecoration(
  //       image: DecorationImage(image: AssetImage('assets/rewardimage.png')),
  //       borderRadius: BorderRadius.all(Radius.circular(20)),
  //       boxShadow: <BoxShadow>[
  //         BoxShadow(
  //             color: Colors.redAccent, offset: Offset(3, 4), blurRadius: 5)
  //       ],
  //     ),
  //   ),
  //   Container(
  //     width: 150,
  //     height: 150,
  //     decoration: const BoxDecoration(
  //       image: DecorationImage(image: AssetImage('assets/rewardimage.png')),
  //       borderRadius: BorderRadius.all(Radius.circular(20)),
  //       boxShadow: <BoxShadow>[
  //         BoxShadow(
  //             color: Colors.redAccent, offset: Offset(3, 4), blurRadius: 5)
  //       ],
  //     ),
  //   ),
  //   Container(
  //     width: 150,
  //     height: 150,
  //     decoration: const BoxDecoration(
  //       image: DecorationImage(image: AssetImage('assets/rewardimage.png')),
  //       borderRadius: BorderRadius.all(Radius.circular(20)),
  //       boxShadow: <BoxShadow>[
  //         BoxShadow(
  //             color: Colors.redAccent, offset: Offset(3, 4), blurRadius: 5)
  //       ],
  //     ),
  //   ),
  //   Container(
  //     width: 150,
  //     height: 150,
  //     decoration: const BoxDecoration(
  //       image: DecorationImage(image: AssetImage('assets/rewardimage.png')),
  //       borderRadius: BorderRadius.all(Radius.circular(20)),
  //       boxShadow: <BoxShadow>[
  //         BoxShadow(
  //             color: Colors.redAccent, offset: Offset(3, 4), blurRadius: 5)
  //       ],
  //     ),
  //   ),
  // ];

  List<String> rewards = [
    "assets/reward1.jpg",
    "assets/reward2.jpeg",
    "assets/reward3.jpg",
    "assets/reeward4.jpg",
  ];
  /* -------------------------------- variable -------------------------------- */

  List<String>? suffledRewards;
  int? rewardContainer;
  List<bool> isContainerTapped = [false, false, false, false];
  String displayImage = '';
  String displayImage1 = '';

  @override
  void initState() {
    super.initState();
    rewardContainer = Random().nextInt(4);
    suffledRewards = List<String>.from(rewards)..shuffle();
    displayImage = 'assets/${suffledRewards![rewardContainer!]}';
    print("display Image : $displayImage");
  }

  /* -------------------------------- function -------------------------------- */

  void onContainerTap(int selectedContainer) {
    if (selectedContainer == rewardContainer) {
      setState(() {
        isContainerTapped[selectedContainer] = true;
      });
    } else {
      setState(() {
        isContainerTapped[selectedContainer] = false;
      });
    }

    Future.delayed(const Duration(seconds: 1), () {
      if (selectedContainer == rewardContainer) {
        setState(() {
          isGameOver = true;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Column(
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
                      suffledRewards![selectedContainer],
                      fit: BoxFit.cover,
                      height: 150,
                      width: 150,
                    ),
                  ),
                  const Text(
                    'you got the prize',
                    style: TextStyle(color: Colors.white),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
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
                            Navigator.of(context).pop();
                            setState(() {
                              isGameOver = true;
                            });
                            Timer(const Duration(seconds: 2), () {
                              displayImage1 =
                                  suffledRewards![rewardContainer!.toInt()];
                            });
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
                            setState(() {
                              isGameOver = true;
                            });
                            Timer(const Duration(seconds: 2), () {
                              displayImage1 =
                                  suffledRewards![rewardContainer!.toInt()];
                            });
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
                        setState(() {
                          isGameOver = true;
                        });
                        Timer(const Duration(seconds: 2), () {
                          displayImage1 =
                              suffledRewards![rewardContainer!.toInt()];
                        });
                      },
                      child: const Text(
                        'play on ads',
                        style: TextStyle(fontSize: 16),
                      ))
                ],
              ),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Column(
                children: [
                  const Text(
                    'Oops! you lose ',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      suffledRewards![selectedContainer],
                      color: Colors.transparent,
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  const Text(
                    'you didnt get prize',
                    style: TextStyle(color: Colors.white),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                        )
                      ],
                    ),
                  ),
                  const Text(
                    'Your next Box is guaranted prize',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              isGameOver = true;
                            });
                            Timer(const Duration(seconds: 2), () {
                              displayImage1 =
                                  suffledRewards![rewardContainer!.toInt()];
                            });
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
                            setState(() {
                              isGameOver = true;
                            });
                            Timer(const Duration(seconds: 2), () {
                              displayImage1 =
                                  suffledRewards![rewardContainer!.toInt()];
                            });
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
                        setState(() {
                          isGameOver = false;
                        });
                        // Timer(const Duration(seconds: 2), () {
                        //   displayImage1 =
                        //       suffledRewards![rewardContainer!.toInt()];
                        // });
                      },
                      child: const Text(
                        'play on ads',
                        style: TextStyle(fontSize: 16),
                      )),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 4, 217, 11))),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          isGameOver = true;
                        });
                        Timer(const Duration(seconds: 2), () {
                          displayImage1 =
                              suffledRewards![rewardContainer!.toInt()];
                        });
                      },
                      child: const Text(
                        'ok',
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
            );
          },
        );
      }
    });
  }

  // void checkAllContainers() {
  //   bool allContainersChecked = true;
  //   for (int i = 0; i < containers.length; i++) {
  //     if (!isContainerTapped[i]) {
  //       allContainersChecked = false;
  //       break;
  //     }
  //   }

  //   if (allContainersChecked) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('All containers checked!'),
  //           content:
  //               const Text('Congratulations, you\'ve won all the rewards!'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  /* -------------------------------------------------------------------------- */
  /*                            widget build start                            */
  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorList.appbarcolor,
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
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [Icon(Icons.money), Text('3714')],
                ),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  color: ColorList.backgroundcolor,
                  child: Row(
                    children: [
                      for (int i = 0; i < 10; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.brown,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                    color: ColorList.bordercolor, width: 3)),
                            child: Text(
                              '$i',
                              style: TextStyle(
                                  color: ColorList.bordercolor, fontSize: 21),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
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
                                  fontSize: 20, color: ColorList.bordercolor),
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
                height: 380,
                width: size.width,
                color: const Color.fromARGB(255, 119, 39, 9),
                child: Center(
                  heightFactor: 5,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      crossAxisCount: 2,
                    ),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          if (!isGameOver || isContainerTapped[index]) {
                            onContainerTap(index);
                          }
                        },
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                      blurRadius: 15,
                                      spreadRadius: 3,
                                      color: Color.fromARGB(255, 73, 22, 2)),
                                ],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(isGameOver
                                        ? suffledRewards![index]
                                        : 'assets/rewardimage.png'))),
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
                                        image:
                                            AssetImage('assets/reeward4.jpg'),
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
                        ElevatedButton(
                            style: const ButtonStyle(
                                elevation: MaterialStatePropertyAll(10),
                                shadowColor:
                                    MaterialStatePropertyAll(Colors.black38),
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 6, 195, 12))),
                            onPressed: () {},
                            child: const Text(
                              'Leave with rewards',
                              style: TextStyle(letterSpacing: 1, fontSize: 16),
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
    );
  }

  Future<dynamic> InfoDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          backgroundColor: const Color.fromARGB(255, 131, 68, 45),
          title: const Text(
            'Guess The box',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 219, 216, 211)),
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
}
