import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TargetGraphSenior extends StatelessWidget {
  final double cash;
  final double visits;
  final double target;
  final double newStores;
  final bool isFieldForce;
  final Function onTab;
  final bool loading;

  TargetGraphSenior({
    this.cash = 0.0,
    this.visits = 0.0,
    this.target = 0.0,
    this.newStores = 0.0,
    this.isFieldForce = false,
    this.loading = false,
    this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    var data = [
      isFieldForce
          ? ClicksPerYear(
              tr('senior_profile.newStore'), newStores.round(), Colors.red)
          : ClicksPerYear(tr('senior_profile.cash'), cash.round(), Colors.red),
      ClicksPerYear(tr('senior_profile.visits'), visits.round(), Colors.yellow),
      ClicksPerYear(tr('senior_profile.target'), target.round(), Colors.green),
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
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 30,
      ),
      child: SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          chartWidget,
          loading
              ? CircularProgressIndicator()
              : RaisedButton(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    tr('extra.refresh'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  color: Colors.green,
                  onPressed: () {
                    onTab();
                  },
                ),
        ],
      ),
    );
  }
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
