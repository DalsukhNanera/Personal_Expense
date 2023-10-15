import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/main.dart';
import './toastmessage.dart';
import '../MyHomePage.dart';

import 'package:flutter/material.dart';
import '../roundbutton.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const routename = '/registretion_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showspinning = false;
   final emailidtext = TextEditingController();
   final passwordtext = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void ok() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print("Error initializing Firebase: $e");
    }
  }

  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinning,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'hero',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                 style: TextStyle(color: Colors.black),
                controller: emailidtext,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    ktextfielddecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(height: 10.0,),
              TextField(
                 style: TextStyle(color: Colors.black),
                obscureText: true,
                controller: passwordtext,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: ktextfielddecoration.copyWith(
                    hintText: 'Enter Your Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
             roundbutton(
                  title: 'Register',
                  color: Colors.blueAccent,
                  controller: () async {
                    setState(() {
                      showspinning = true;
                    });
                    try {
                      final newuser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newuser != null) {
                        Navigator.of(context).pushNamed(MyHomePage.routename, arguments: email);
                      }

                      setState(() {
                        showspinning = false;
                      });
                    } catch (e) {
                      setState(() {
                        showspinning = false;
                      });
                      toastmessage.errormessage(e.toString());
                      //Navigator.of(context).pushNamed(WelcomeScreen.routename);
                    }
                  },
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}
