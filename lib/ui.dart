// ignore_for_file: sized_box_for_whitespace

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
  List<Widget> containers = [
    Container(
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/rewardimage.png')),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.redAccent, offset: Offset(3, 4), blurRadius: 5)
        ],
      ),
    ),
    Container(
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/rewardimage.png')),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.redAccent, offset: Offset(3, 4), blurRadius: 5)
        ],
      ),
    ),
    Container(
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/rewardimage.png')),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.redAccent, offset: Offset(3, 4), blurRadius: 5)
        ],
      ),
    ),
    Container(
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/rewardimage.png')),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.redAccent, offset: Offset(3, 4), blurRadius: 5)
        ],
      ),
    ),
  ];

  /* -------------------------------- variable -------------------------------- */

  int rewardContainer = Random().nextInt(4);

  List<bool> isContainerTapped = [false, false, false, false];

  /* -------------------------------- function -------------------------------- */
  void onContainerTap(int selectedContainer) {
    if (selectedContainer == rewardContainer) {
      setState(() {
        isContainerTapped[selectedContainer] = true;
        print(rewardContainer);
      });
    } else {
      setState(() {
        isContainerTapped[selectedContainer] = true;
        print(selectedContainer);
      });
    }

    Future.delayed(const Duration(seconds: 1), () {
      if (selectedContainer == rewardContainer) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Column(
                children: [
                  const Text(
                    'congratulation!! you won the game',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/reward1.png',
                      color: Colors.transparent,
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,
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
                      },
                      child: const Text(
                        'play on ads',
                        style: TextStyle(fontSize: 16),
                      ))
                ],
              ),
            );

            //  AlertDialog(
            //   title: const Text('Congratulations!'),
            //   content: const Text('Youve won a reward!'),
            //   actions: <Widget>[
            //     TextButton(
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //       },
            //       child: const Text('OK'),
            //     ),
            //   ],
            // );
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
                    'Oops! you lose the game',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/reward1.png',
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
                  const Text('Your next Box is guaranted prize'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red)),
                          onPressed: () {
                            Navigator.of(context).pop();
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
  /*                                   widget                                   */
  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              textColor: Colors.white,
              titleAlignment: ListTileTitleAlignment.center,
              tileColor: ColorList.backgroundcolor,
              title: const Text(
                'Lucky Box',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              horizontalTitleGap: 20,
              trailing: const Icon(
                Icons.info_outline,
                color: Colors.blue,
              ),
            ),
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
              width: double.infinity,
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
              padding: const EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              width: double.infinity,
              color: const Color.fromARGB(255, 92, 25, 1),
              child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: List<Widget>.generate(containers.length, (index) {
                    return GestureDetector(
                        onTap: () {
                          if (!isContainerTapped[index]) {
                            onContainerTap(index);
                          }
                        },
                        child: containers[index]);
                  })),
            ),

            /* -------------------------------------------------------------------------- */
            /*                               ribbon section                               */
            /* -------------------------------------------------------------------------- */
            Container(
              color: ColorList.backgroundcolor,
              child: Column(
                children: [
                  Stack(alignment: Alignment.topCenter, children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -10,
                      top: -20,
                      child: Image.asset(
                        'assets/ribbon.png',
                        // height: 100,
                        // width: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width,
                      color: ColorList.bordercolor,
                    ),
                    const SizedBox(height: 20),
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
                  ElevatedButton(
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(10),
                          shadowColor: MaterialStatePropertyAll(Colors.black38),
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
          ],
        ),
      ),
    );
  }
}
