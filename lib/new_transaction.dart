import 'package:flash_chat/listdesign.dart';
import 'package:flutter/material.dart';
import './Transaction.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './Transaction.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class new_transaction extends StatefulWidget {
  final String emailid;
  new_transaction({this.emailid});

  @override
  State<new_transaction> createState() => _new_transactionState();
}

class _new_transactionState extends State<new_transaction> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // print(widget.emailid);
    // return  StreamBuilder(
    //       stream:  firestore
    //               .collection(widget.emailid)
    //               .orderBy("date", descending: true)
    //               .snapshots(),
    //       builder: (context, snapshot) {
    //         List<Map<String,dynamic>> ok = snapshot.data.docs.toList();
    //         if (!snapshot.hasData) {
    //           return Center(child: CircularProgressIndicator());
    //         }
    //         return  ListView.builder(
    //             itemBuilder: (context, index) {
    //               return Card(
    //                   elevation: 5,
    //                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
    //                   child: ListTile(
    //                     leading: CircleAvatar(
    //                         radius: 30,
    //                         child: Padding(
    //                           padding: EdgeInsets.all(15),
    //                           child: FittedBox(
    //                             child: Text(
    //                                 '${ok[index]['amount']}'),
    //                           ),
    //                         )),
    //                     title: Text(
    //                       snapshot.data.docs[index]['title'],
    //                       style: TextStyle(
    //                           fontWeight: FontWeight.bold, fontSize: 15),
    //                     ),
    //                     subtitle: Text(DateFormat.yMMMd()
    //                         .format(ok[index][index]['date'])),
    //                     trailing: IconButton(
    //                       onPressed: () => ok[index][index].delete,
    //                       icon: Icon(Icons.delete),
    //                       color: Colors.red,
    //                     ),
    //                   ));
    //             },
    //             itemCount: ok.length,
    //           );

    //       });

    return  StreamBuilder(
          stream: firestore
              .collection(widget.emailid)
              .orderBy("date", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

             final messages = snapshot.data.docs;
            return ListView.builder(itemBuilder: ((context, index) {
              String id1 =  messages[index].reference.id ;
              return listdesign(
                amount: messages[index]['amount'].toString(),
                date: (messages[index]['date'] as Timestamp).toDate(),
                title: messages[index]['title'],
                id: id1,
                index: index,
                ok: ( String id) {
                  setState(() {

                    FirebaseFirestore.instance.collection(widget.emailid).doc(id).delete();
                    
                  });
                },
              );
            }),
            itemCount: messages.length,
            );
          },
        
      );
    
  }
}
