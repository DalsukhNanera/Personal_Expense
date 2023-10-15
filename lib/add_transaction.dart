import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class add_transaction extends StatefulWidget {
  @override
  State<add_transaction> createState() => _add_transactionState();
}

class _add_transactionState extends State<add_transaction> {
  final firestore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;
  User loggedinuser;

  final okmessage = TextEditingController();

  @override
  void initState() {
    getcurrentuser();
    super.initState();
  }

  Future<void> getcurrentuser() {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        loggedinuser = user;
        print(loggedinuser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selecteddate;

  void submitted() {
    final Title = titleController.text;
    final Amount = double.parse(amountController.text);

    if (Title.isEmpty || Amount <= 0 || selecteddate == null) {
      return;
    }

    String idh = DateTime.now().toString();
    DateTime newTimeDateTime = DateTime(
      selecteddate.year,
      selecteddate.month,
      selecteddate.day,
      DateTime.now().hour, // Set the new hour
      DateTime.now().minute,
      DateTime.now().second,
    );

    firestore.collection(loggedinuser.email).doc(idh).set({
      'id': DateTime.now(),
      'title': Title,
      'amount': Amount,
      'date': selecteddate,
    });

    Navigator.of(context).pop();
  }

  Future<void> showdate() async {
    // showDatePicker(
    //         context: context,
    //         initialDate: DateTime.now(),
    //         firstDate: DateTime(2020),
    //         lastDate: DateTime.now())

    //   DatePicker.showDatePicker(context,
    //                           showTitleActions: true,
    //                           minTime: DateTime(2018, 3, 5),
    //                           maxTime:DateTime.now(), onChanged: (date) {
    //                         print('change $date');
    //                       }, onConfirm: (date) {
    //                         print('confirm $date');
    //                       }, currentTime: DateTime.now(), locale: LocaleType.zh)

    //     .then((value) {
    //   if (value == Null) {
    //     return;
    //   }

    //   setState(() {
    //     selecteddate = value;
    //   });
    // });

    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: selecteddate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selecteddate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      } else {
        selecteddate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          DateTime.now().hour,
          DateTime.now().minute,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'title'),
                controller: titleController,
                // keyboardType: TextInputType.number,
                onSubmitted: (_) => submitted(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitted(),
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selecteddate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(selecteddate)}',
                      ),
                    ),
                    TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.blue),
                        onPressed: showdate,
                        child: Text(
                          'choose date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      onPrimary: Colors.blue, foregroundColor: Colors.white),
                  onPressed: submitted,
                  child: Text(
                    'submit',
                    style: TextStyle(fontSize: 15),
                  ))
            ],
          )),
    );
  }
}
