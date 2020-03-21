import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TargetGraphSenior extends StatefulWidget {
  @override
  _TargetGraphSeniorState createState() => _TargetGraphSeniorState();
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _TargetGraphSeniorState extends State<TargetGraphSenior> {
  @override
  Widget build(BuildContext context) {
    var data = [
      ClicksPerYear(tr('senior_profile.cash'), 22, Colors.red),
      ClicksPerYear(tr('senior_profile.visits'), 42, Colors.yellow),
      ClicksPerYear(tr('senior_profile.target'), 80, Colors.green),
    ];

    var series = [
      charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
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
