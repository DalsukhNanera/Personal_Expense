import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/daybyday.dart';
import 'package:flutter/material.dart';
import './add_transaction.dart';
import './Transaction.dart' as tr;
import './new_transaction.dart';
import './chart.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  static const routename = '/myhomepage';
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void startaddnewtx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: ((bctx) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: add_transaction(),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context).settings.arguments as String;
    return  Scaffold(
        appBar: AppBar(
          title: Text('Personal Expense'),
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(daybyday.routename, arguments: email);
                },
                icon: Icon(Icons.list))
            ,
            IconButton(
                onPressed: (() => startaddnewtx(context)),
                icon: Icon(Icons.add))
          ],
        ),
        body: 
           
             ListView(
                children: [
                  Container(height: 150, child:chart(email: email,) ,),
                  Container(height: 450, child: new_transaction(emailid: email),),
              
                ],
              
                     ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => startaddnewtx(context),
        ),
      );
    
  }
}
