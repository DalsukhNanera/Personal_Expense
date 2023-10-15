import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class totalspending extends StatelessWidget {
  final  double amount ;
  final   DateTime  date;

  totalspending({Key key, @required this.amount,@required this.date}) : super(key: key);

 

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
                                   amount.toString()),
                              ),
                            )),
                        title: Text(
                         DateFormat('yyyy-MM-dd ').format(date),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        
                        ),
                        
                      );
  }
}
