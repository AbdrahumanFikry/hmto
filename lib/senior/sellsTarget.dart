import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class SellsTarget extends StatelessWidget {
  final double monthlyTargetBalance;
  final double ownMonthlyBalance;
  final double ownDailyBalance;
  final String name;

  SellsTarget({
    this.name,
    this.monthlyTargetBalance = 0.0,
    this.ownDailyBalance = 0.0,
    this.ownMonthlyBalance = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    double myTarget = (ownMonthlyBalance / monthlyTargetBalance) * 100;
    print(":::::" + myTarget.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Text(
                    '${tr('start_day.balance')} :',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          ownDailyBalance.toString(),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.monetization_on,
                          size: 18.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            myTarget.isNaN
                ? Center(
                    child: Text(
                      tr('extra.noTarget'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  )
                : Row(
                    children: <Widget>[
                      Text(
                        tr('field_force_profile.my_target').split(' ')[1],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 18.0,
                        ),
                      ),
                      Spacer(),
                      new LinearPercentIndicator(
                        width: 220.0,
                        animation: true,
                        animationDuration: 1000,
                        lineHeight: 25.0,
                        percent: myTarget / 100,
                        center: Text(myTarget.toString() + '%'),
                        linearStrokeCap: LinearStrokeCap.butt,
                        progressColor: Colors.blue,
                      ),
                    ],
                  ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
