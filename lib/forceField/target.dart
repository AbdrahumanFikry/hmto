import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:senior/models/target.dart';
import 'package:senior/providers/fieldForceProvider.dart';

class Target extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            Provider.of<FieldForceData>(context, listen: false).fetchTarget(),
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
            return Consumer<FieldForceData>(
                builder: (context,data,child){
                  return ListView(
                    padding: EdgeInsets.all(10.0),
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            tr('field_force_profile.my_target'),
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
                            percent: double.parse(data.target.data.targetPer,)/100,
                            center: Text("${data.target.data.targetPer}%"),
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
                            tr('field_force_profile.visits'),
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
                            percent: double.parse(data.target.data.visited,)/100,
                            center: Text("${data.target.data.visited}%"),
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
                            tr('field_force_profile.new'),
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
                            percent: double.parse(data.target.data.newStorePer,)/100,
                            center: Text("${data.target.data.newStorePer}%"),
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: Colors.yellow,
                          ),
                        ],
                      ),
                    ],
                  );
                }
            );
          }
        });
  }
}
