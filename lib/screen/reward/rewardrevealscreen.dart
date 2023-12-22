import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:guess_the_box/constant/constant.dart';
import 'package:guess_the_box/rewardcard/card1.dart';
import 'package:guess_the_box/rewardcard/card2.dart';
import 'package:guess_the_box/rewardcard/card3.dart';

class RewardRevealScreen extends StatefulWidget {
  const RewardRevealScreen({super.key});

  @override
  State<RewardRevealScreen> createState() => _RewardRevealScreenState();
}

class _RewardRevealScreenState extends State<RewardRevealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.withOpacity(0.7),
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            width: 80,
            decoration: BoxDecoration(
                color: ColorList.backgroundcolor,
                borderRadius: const BorderRadius.all(Radius.circular(14))),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.attach_money_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    "100",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          const Gap(20)
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const CardOne(),
              const CardTwo(),
              const CardThree(),
              Image.asset(
                "assets/PngItem_577961.png",
                height: 150,
                width: 150,
              ).animate().fade(),
            ],
          ),
        ),
      ),
    );
  }
}
