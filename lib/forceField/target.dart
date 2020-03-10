import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Target extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'My Target',
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
              percent: 0.5,
              center: Text("50.0%"),
              linearStrokeCap: LinearStrokeCap.butt,
              progressColor: Colors.blue,
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          children: <Widget>[
            Text(
              'Visits',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 18.0,
              ),
            ),
            Spacer(),
            new LinearPercentIndicator(
              width: 220.0,
              animation: true,
              animationDuration: 1000,
              lineHeight: 25.0,
              percent: 0.7,
              center: Text("70.0%"),
              linearStrokeCap: LinearStrokeCap.butt,
              progressColor: Colors.red,
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          children: <Widget>[
            Text(
              'New',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
                fontSize: 18.0,
              ),
            ),
            Spacer(),
            new LinearPercentIndicator(
              width: 220.0,
              animation: true,
              animationDuration: 1000,
              lineHeight: 25.0,
              percent: 0.2,
              center: Text("20.0%"),
              linearStrokeCap: LinearStrokeCap.butt,
              progressColor: Colors.yellow,
            ),
          ],
        ),
      ],
    );
  }
}
