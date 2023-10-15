
import './authentication/registration_screen.dart';
import './authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './authentication/welcome_screen.dart';

import './daybyday.dart';


import './MyHomePage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyDo9mUpfWL8wvPy8u7RRuAMI-PRTxHR7bM",
      appId: "1:856946943571:android:bc521be6a9636b037508a6",
      messagingSenderId: "856946943571",
      projectId: "personal-expense-cb914",
      storageBucket: null,
      databaseURL: null,
    ),);

    
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: WelcomeScreen(),
      routes: {
        WelcomeScreen.routename:(context) => WelcomeScreen(),
        LoginScreen.routename:(context) => LoginScreen(),
        RegistrationScreen.routename:(context) => RegistrationScreen(),
        MyHomePage.routename:(context) => MyHomePage(),
        daybyday.routename:(context) => daybyday(),
      },
    );
  }
}


