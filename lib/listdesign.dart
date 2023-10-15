import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class listdesign extends StatelessWidget {

  final String amount ;
 final  String title ; 
  final DateTime date ;
  final Function ok ;
  final String id ;
  int index ;


  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss'); // Customize this format

DateTime timestampToDateTime(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}


listdesign({this.amount,this.title,this.date,this.ok,this.id,this.index});
  @override
  Widget build(BuildContext context) {
    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 30,
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: FittedBox(
                                child: Text(
                                  double.parse(amount).toStringAsFixed(0) ),
                              ),
                            )),
                        title: Text(
                         title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        
                        subtitle: Text(DateFormat().format(date)),
                        trailing: IconButton(
                          onPressed: () => ok(id),
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        ),
                        ),
                        
                      );
  }
}