import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/fieldForceProvider.dart';
import 'package:senior/providers/seniorFieldForceProvider.dart';

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
      Clicks(tr('senior_profile.visits'), 60, Colors.yellow),
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

    return FutureBuilder(
        future: Provider.of<SeniorFieldForceData>(context, listen: false)
            .fetchTargetSenior(),
        builder: (context, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapShot.hasError) {
              Center(
                child: Text(
                  tr('extra.check'),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              );
            }
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
        });
  }
}
