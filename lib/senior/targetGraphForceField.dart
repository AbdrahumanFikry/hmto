import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TargetGraphForceField extends StatefulWidget {
  @override
  _TargetGraphForceFieldState createState() => _TargetGraphForceFieldState();
}

class Clicks {
  final String year;
  final int clicks;
  final charts.Color color;

  Clicks(this.year, this.clicks, Color color)
      : this.color = charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _TargetGraphForceFieldState extends State<TargetGraphForceField> {
  @override
  Widget build(BuildContext context) {
    var data = [
      Clicks(tr('senior_profile.visits'), 42, Colors.yellow),
      Clicks(tr('senior_profile.newStore'), 80, Colors.green),
    ];

    var series = [
      charts.Series(
        domainFn: (Clicks clickData, _) => clickData.year,
        measureFn: (Clicks clickData, _) => clickData.clicks,
        colorFn: (Clicks clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            chartWidget,
          ],
        ),
      ),
    );
  }
}