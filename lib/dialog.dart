import 'package:flutter/material.dart';
import 'package:guess_the_box/constant/constant.dart';

class DialogpopUp extends StatelessWidget {
  const DialogpopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          const Text('Congratulation You Won'),
          Image.asset(
            'assets/reward1.png',
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          const Text('you Got Bomb'),
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
                      border:
                          Border.all(color: ColorList.bordercolor, width: 3),
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
                      border:
                          Border.all(color: ColorList.bordercolor, width: 3),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                )
              ],
            ),
          ),
          const Text('Your next Box is guaranted prize'),
          Row(
            children: [
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
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
  }
}
