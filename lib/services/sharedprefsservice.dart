import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static void saveProgress(int localprogress) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("savedcoin", localprogress);
  }

  static Future<int> getLocalCoin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final localcoin = prefs.getInt('savedcoin') ?? 0;
    print("local coin from sharedprefs = $localcoin");
    return localcoin;
  }
}
