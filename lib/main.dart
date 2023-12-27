import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_box/services/firebaseservice.dart';
import 'package:guess_the_box/screen/auth/loginscreen.dart';
import 'package:guess_the_box/screen/homepage/homescreen.dart';
import 'package:guess_the_box/screen/homepage/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessingServices.getCurrentToken();

  FirebaseMessingServices.setupFirebase();
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);
  FirebaseMessingServices.backgroundNotification();
  FirebaseMessingServices.foregroundNotification();
  FirebaseMessingServices.setupInteractMessage();

// send notification to all devices
  FirebaseMessaging.instance.subscribeToTopic('all_devices');
  FirebaseMessaging.instance.subscribeToTopic('specific_devices');

  runApp(const MyApp());
}

// handle background notification
@pragma('vm:entry-point')
Future firebaseBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null) {
              return const LogInPage();
            } else {
              return const SplashScreen();
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      routes: {
        HomePage.routename: (context) => const HomePage(),
      },
    );
  }
}
