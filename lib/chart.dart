
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import './tr.dart';
import 'package:flutter/material.dart';
import './chart_bar.dart';



class chart extends StatelessWidget {
  String email ;
  chart({this.email});

  final firestore = FirebaseFirestore.instance ;

  List<tr> recenettransaction = [];

  

  @override
  Widget build(BuildContext context) {
    

        
 return StreamBuilder(
  stream: firestore.collection(email).orderBy("date", descending: true).snapshots(),
  builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator(); // You can show a loading indicator.
  }
  if (!snapshot.hasData) {
    return Text('No data available'); // Handle the case where there's no data.
  }
  
  final messages = snapshot.data.docs;
  recenettransaction.clear();
  
   final now = DateTime.now();
  final oneWeekAgo = now.subtract(Duration(days: 7));

  for (var message in messages) {
    final messageData = message.data() as Map<String, dynamic>;
   
   final transactionDate = (messageData['date'] as Timestamp).toDate();

   if (transactionDate.isAfter(oneWeekAgo)) {

    final newtx = tr(
      id: messageData['id'].toString(),
      title: messageData['title'],
      amount: double.parse(messageData['amount'].toString()),
      date: (messageData['date'] as Timestamp).toDate(),
    );
    recenettransaction.add(newtx); 
    // Add the new transaction to the list.
  }
  }

    final chartData = List.generate(7, (index) {
        final weekday = now.subtract(Duration(days: index));
        double totalsum = 0.0;
        for (int i = 0; i < recenettransaction.length; i++) {
          if ((recenettransaction[i].date.day == weekday.day) &&
              (recenettransaction[i].date.month == weekday.month) &&
              (recenettransaction[i].date.year == weekday.year)) {
            totalsum += recenettransaction[i].amount;
          }
        }
        return {
          'day': DateFormat.E().format(weekday).substring(0, 1),
          'amount': totalsum,
        };
      });

      

      double totalspending = chartData.fold(0.0, (sum, element) {
        return sum += element['amount'] as double;
      });



    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...chartData.map((e) {
            return Flexible(
              fit: FlexFit.tight,
                child: chart_bar( 
              e['amount'] as double,
              totalspending == 0
                  ? 0.0
                  : (e['amount'] as double) / totalspending,
              e['day'] as String,
            ));
          }).toList(),
        ],
      ),
    );
},
);
  }
}
