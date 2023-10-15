import 'package:flutter/material.dart';

class roundbutton extends StatelessWidget {
 final Function controller ;
 final String title ;
 final Color color ;

 roundbutton({this.color,this.title,this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: controller,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
           title,
          ),
        ),
      ),
    );
  }
}