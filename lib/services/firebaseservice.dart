// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_the_box/componennts/messagescreen.dart';
import 'package:guess_the_box/screen/homepage/homescreen.dart';
import 'package:rxdart/rxdart.dart';

final navigatorKey = GlobalKey<NavigatorState>();

/* -------------------------------------------------------------------------- */
/*                          firebase loggin services                          */
/* -------------------------------------------------------------------------- */

Future<bool> checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

class FirebaseLoginServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  static User? user;

  Future<User?> signInwithGoogle(BuildContext context) async {
    bool isConnected = await checkInternetConnection();
    if (isConnected) {
      try {
        final GoogleSignInAccount? googleSignInAccount =
            await _googleSignIn.signIn();
        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;
          final AuthCredential authCredential = GoogleAuthProvider.credential(
              accessToken: googleSignInAuthentication.accessToken,
              idToken: googleSignInAuthentication.idToken);
          final UserCredential userCredential =
              await _auth.signInWithCredential(authCredential);
          // final user = userCredential.additionalUserInfo!;
          user = userCredential.user;
          // print(user);
        }
        return user;
      } on FirebaseAuthException catch (e) {
        print(e.message);
        rethrow;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please check your internet Connection"),
        backgroundColor: Colors.red,
      ));
    }
    return null;
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}

class CoinManager {
  static final _firebasefirestore = FirebaseFirestore.instance;
  static User? user = FirebaseAuth.instance.currentUser;

  static Future<void> saveCoins(String userId, int localprogress) async {
    // await _firebasefirestore.collection('users').doc(userId).set({
    //   'coins': coins,
    // });

    try {
      await _firebasefirestore.collection('users').doc(userId).set({
        'coins': localprogress,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<int?> retrieveCoins(String userId) async {
    DocumentSnapshot snapshot =
        await _firebasefirestore.collection('users').doc(userId).get();
    return snapshot.exists ? snapshot['coins'] : null;
  }
}

/* -------------------------------------------------------------------------- */
/*                           FirebaseMessingServices                          */
/* -------------------------------------------------------------------------- */

class FirebaseMessingServices {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static String? userId = FirebaseAuth.instance.currentUser?.uid;

  void sendTokenToServer(String? token) async {
    // Retrieve the previous token stored for this user
    await FirebaseFirestore.instance
        .collection("fcmTokens")
        .doc(userId)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        // A previous token exists for this user
        String? previousToken = (snapshot.data() as Map<String, dynamic>?)?[
            'token']; // The token to compare with the new token

        if (previousToken == token) {
          // The new token is the same as the previous one, no need to update
          print("Token is the same. No action needed.");
        } else {
          // The new token is different, delete the previous one and add the new one
          print("Deleting previous token: $previousToken");
          FirebaseFirestore.instance
              .collection("fcmTokens")
              .doc(userId)
              .delete();

          print("Adding new token: $token");
          getFCMtoken(userId, token);
        }
      } else {
        // No previous token found for this user, add the new one
        print("Adding new token: $token");
        getFCMtoken(userId, token);
      }
    });
  }

  static void getFCMtoken(String? userid, String? token) async {
    print("userid in messegeservices = $userId");
    Map<String, dynamic> deviceToken = {
      "token": token,
      "timestamp": FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance
        .collection("fcmTokens")
        .doc(userId)
        .set(deviceToken)
        .then((value) {
      print("Firebase Token and timestamp added successfully");
    }).catchError((error) {
      print("Failed to add the FCM token $error");
    });
  }

  static void refreshedToken() async {
    _firebaseMessaging.onTokenRefresh.listen((String newToken) {
      print("new fcm token = $newToken");
      getFCMtoken(userId, newToken);
    });
  }

  static void getCurrentToken() async {
    await _firebaseMessaging.getToken().then((String? token) {
      print("current token = $token");
      getFCMtoken(userId, token);
    });
  }

  static Future<void> setupFirebase() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      criticalAlert: true,
      badge: true,
      sound: true,
      provisional: true,
      carPlay: true,
    );

    refreshedToken();
    getCurrentToken();
  }

  /* ---------------------- on background message tapped ---------------------- */

  static void backgroundNotification() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Background notification received");
      String payload = jsonEncode(message.data);
      navigatorKey.currentState!
          .pushNamed(HomePage.routename, arguments: message);
      displaySimpleNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payload,
      );
    });
  }

  // handle foreground notification
  static void foregroundNotification() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }

      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        String payload = jsonEncode(message.data);
        initLocalNotification(message);
        displaySimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payload,
        );
      }
    });
  }

  /* ---------------------- initialize local notification --------------------- */

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final onclickNotification = BehaviorSubject();

  /* ------------------------- on tap any notification ------------------------ */
  static void onNotificationTap(
      NotificationResponse notificationResponse) async {
    onclickNotification.add(notificationResponse.payload);
    navigatorKey.currentState!
        .pushNamed(HomePage.routename, arguments: notificationResponse.payload);
  }

  static Future initLocalNotification(RemoteMessage message) async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) {});

    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleNotification(message);
      },
      onDidReceiveBackgroundNotificationResponse: null,
    );
  }

  /* ----------------------- display simple notification ---------------------- */

  static Future displaySimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      1.toString(),
      'high impoertance notification',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'your channel discription ',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
    });
  }

  //handle tap on notification when app is in background or terminated
  static Future<void> setupInteractMessage() async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleNotification(initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleNotification(event);
    });
  }

  static void handleNotification(RemoteMessage message) {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => const HomePage()));
    navigatorKey.currentState!.pushNamed(HomePage.routename);
  }

  static Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
