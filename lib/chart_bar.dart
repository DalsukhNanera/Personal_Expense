import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class chart_bar extends StatelessWidget {
  final double amount;
  final double percentage;
  final String day;
  chart_bar(this.amount, this.percentage, this.day);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(amount.toStringAsFixed(0)),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                child: null,
                decoration: BoxDecoration(
                    border: Border.all( 
                      color: Colors.grey,
                      width: 1,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(day.substring(0, 1)),
      ],
    );
  }
}
