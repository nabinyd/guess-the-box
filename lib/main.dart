import 'package:flutter/material.dart';
import 'dart:math';

import 'package:guess_the_box/ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GuessTheBox(),
    );
  }
}

class ContainerGame extends StatefulWidget {
  const ContainerGame({super.key});

  @override
  _ContainerGameState createState() => _ContainerGameState();
}

class _ContainerGameState extends State<ContainerGame> {
  int rewardContainer = Random().nextInt(4);
  List<bool> isContainerTapped = [false, false, false, false];

  void onContainerTap(int selectedContainer) {
    if (selectedContainer == rewardContainer) {
      setState(() {
        isContainerTapped[selectedContainer] = true;
      });
    } else {
      setState(() {
        isContainerTapped[selectedContainer] = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess the box'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isContainerTapped[rewardContainer]
                  ? 'Congratulations! You won the reward!'
                  : 'Tap the correct container to win a reward.',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return GestureDetector(
                  onTap: () {
                    if (!isContainerTapped[index]) {
                      onContainerTap(index);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      height: 100,
                      color: isContainerTapped[index]
                          ? (index == rewardContainer
                              ? Colors.green
                              : Colors.red)
                          : Colors.blue,
                      child: Center(
                        child: Text(
                          'Container ${index + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
