import 'package:flash_chat/totalspending.dart';
import 'package:flutter/material.dart';



import 'package:cloud_firestore/cloud_firestore.dart';
import './tr.dart';



class daybyday extends StatelessWidget {
  static const routename = '/daybyday';
  final firestore = FirebaseFirestore.instance;

  List<tr> oktr = [];

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: StreamBuilder(
        stream: firestore
            .collection(email)
            .orderBy("date", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); 
          }
          if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
            return const Center(child: Text('No Transaction yet'),);
          }

          final messages = snapshot.data.docs;

          for (var message in messages) {
            if (message.data() != null) {
              final messageData = message.data() as Map<String, dynamic>;

              final newtx = tr(
                id: messageData['id'].toString(),
                title: messageData['title'],
                amount: double.parse(messageData['amount'].toString()),
                date: (messageData['date'] as Timestamp).toDate(),
              );
              oktr.add(newtx);
            }
          }

          final chartData = List.generate(15, (index) {
            final weekday = DateTime.now().subtract(Duration(days: index));
            var totalsum = 0.0;

            for (int i = 0; i < oktr.length; i++) {
              if ((oktr[i].date.day == weekday.day) &&
                  (oktr[i].date.month == weekday.month) &&
                  (oktr[i].date.year == weekday.year)) {
                totalsum += oktr[i].amount;
              }
            }
            return {
              'day': weekday,
              'amount': totalsum,
            };
          });

         

          return Card(
            child:  SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...chartData.map((e) {
                    return totalspending(
                      amount: e['amount'] as double,
                      date: e['day'],
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
