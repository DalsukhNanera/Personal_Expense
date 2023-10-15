import './login_screen.dart';
import './registration_screen.dart';
import 'package:flutter/material.dart';
import '../roundbutton.dart';

class WelcomeScreen extends StatefulWidget {
  static const routename = '/welcomescreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation ;

  

  @override
  void initState() {
    controller = AnimationController(
   vsync: this, duration: Duration(seconds: 1), upperBound: 100);
   animation = ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                     Hero(
                        tag: 'hero',
                        child: Container(
                          child: Image.asset('images/logo.png'),
                          height: 100,
                        ),
                      ),
                    
                Expanded(
                  child: Text(
                    'Personal Expense',
                    style: TextStyle(
                      fontSize: 45.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            roundbutton(color: Colors.blueAccent,title: 'Log In', controller: (){
              Navigator.of(context).pushNamed(LoginScreen.routename);
            }),
            roundbutton(color: Colors.blueAccent, title:'Register' ,controller: (){
              Navigator.of(context).pushNamed(RegistrationScreen.routename);
            }),
          ],
        ),
      ),
    );
  }
}


