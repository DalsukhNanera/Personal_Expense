
import 'package:flash_chat/main.dart';
import 'package:flutter/material.dart';
import '../roundbutton.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import './toastmessage.dart';
import '../MyHomePage.dart';

class LoginScreen extends StatefulWidget {
  static const routename = '/login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showspinning = false;
   final emailidtext = TextEditingController();
   final passwordtext = TextEditingController();

  final _auth = FirebaseAuth.instance;
  String email;
  String password;
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
              Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
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
                decoration: ktextfielddecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                 controller: passwordtext,
                 style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: ktextfielddecoration.copyWith(
                  hintText: 'Enter your PassWord',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
               roundbutton(
                  title: 'Log In',
                  color: Colors.blueAccent,
                  controller: () async {
                    setState(() {
                      showspinning = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.of(context).pushNamed(MyHomePage.routename , arguments: email);
                      }
                      setState(() {
                        showspinning = false;
                      });

                      if (user == null) {
                        toastmessage.errormessage('invalid credetails');
                       
                      }
                    } catch (e) {
                      setState(() {
                        showspinning = false;
                      });
                      toastmessage.errormessage(e.toString());
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
