import 'dart:math';

import 'package:flutter/material.dart';

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  _MyGameState createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  List<String> rewards = [
    "assets/reward1.jpg",
    "assets/reward2.jpg",
    "assets/reward3.jpg",
    "assets/bomby.jpg",
  ];

  List<String>? shuffledRewards;
  int? correctContainerIndex;
  int? bombContainerIndex;
  bool isGameOver = false;
  String message = '';
  String displayedImage = ''; // The displayed image
  int level = 1;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    // Shuffle the rewards list
    shuffledRewards = List<String>.from(rewards)..shuffle();
    // Assign a random correct container index
    correctContainerIndex = Random().nextInt(4);
    // Assign a random bomb container index
    bombContainerIndex = Random().nextInt(4);
    // Set the displayed image to the value from the 3rd index of rewards
    displayedImage = rewards.length > 2 ? rewards[2] : 'assets/rewardimage.png';
    // Reset the game state
    setState(() {
      isGameOver = false;
      message = '';
    });
  }

  void checkContainer(int index) {
    if (index == correctContainerIndex) {
      setState(() {
        isGameOver = true;
        message = 'Congratulations! You\'ve won: ${shuffledRewards![index]}';
        level++; // Increase the level upon a correct choice
      });

      // Show a dialog with the shuffled rewards
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Congratulations!'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Start a new game after the user acknowledges the dialog
                  startNewGame();
                },
                child: const Text('Next Level'),
              ),
            ],
          );
        },
      );
    } else if (index == bombContainerIndex) {
      // If the bomb container is selected, reset the game
      setState(() {
        isGameOver = true;
        message = 'Oh no! You hit a bomb. Game Over.';
      });

      // Show a dialog indicating game over
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Over!'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Start a new game after the user acknowledges the dialog
                  startNewGame();
                },
                child: const Text('Restart'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container Game - Level $level'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'hello',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(displayedImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (!isGameOver) {
                        checkContainer(index);
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      color: isGameOver && index == correctContainerIndex
                          ? Colors.green
                          : (isGameOver && index == bombContainerIndex
                              ? Colors.red
                              : Colors.blue),
                      child: Center(
                        child: Text(
                          index == bombContainerIndex
                              ? 'Bomb'
                              : 'Container $index',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
