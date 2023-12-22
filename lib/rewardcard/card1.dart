import 'package:flutter/material.dart';

class CardOne extends StatelessWidget {
  const CardOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: 150,
      child: Card(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Coins",
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Image.asset(
              "assets/pngwing.com.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const Text(
              "400",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
