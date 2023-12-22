import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:guess_the_box/constant/constant.dart';
import 'package:guess_the_box/screen/reward/rewardrevealscreen.dart';


class ChestScreen extends StatefulWidget {
  const ChestScreen({super.key});

  @override
  State<ChestScreen> createState() => _ChestScreenState();
}

class _ChestScreenState extends State<ChestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.withOpacity(0.7),
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
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
              const Gap(20),
              SizedBox(
                height: 100,
                child: Stack(
                  children: [
                    Image.asset("assets/ribbon.png"),
                    Positioned(
                      top: 33,
                      left: MediaQuery.of(context).size.width / 2.7,
                      child: const Text(
                        "Congratulation",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Text(
                "You have received",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              Image.asset(
                "assets/5a1c3f48d2cf12.5032447115118006488635.png",
                fit: BoxFit.cover,
              )
                  .animate(delay: 2.seconds)
                  .moveY(begin: 100)
                  .fade(duration: 800.ms)
                  .shake(duration: 800.ms, delay: 1.seconds),
              Image.asset(
                "assets/PngItem_577961.png",
                height: 150,
                width: 150,
              ).animate().fade(),
              // AnimatedContainer(
              //   duration: const Duration(seconds: 3),
              //   curve: Curves.easeInOutCirc,
              //   child: Image.asset(
              //     "assets/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2lt.png",
              //     fit: BoxFit.cover,
              //   ).animate().boxShadow(
              //       begin: const BoxShadow(color: Colors.black26),
              //       end: BoxShadow(color: Colors.red.withOpacity(0)),
              //       duration: 2.seconds),
              // ),
              const Gap(30),
              const Text(
                "x3",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                "Bronze Chest",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const RewardRevealScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  side: const MaterialStatePropertyAll(BorderSide(
                      color: Color.fromARGB(255, 163, 248, 4), width: 2)),
                  elevation: const MaterialStatePropertyAll(10),
                  backgroundColor: const MaterialStatePropertyAll(
                      Color.fromARGB(255, 0, 186, 43)),
                  fixedSize: const MaterialStatePropertyAll(Size(200, 40)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                ),
                child: const Text(
                  "Ok",
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
