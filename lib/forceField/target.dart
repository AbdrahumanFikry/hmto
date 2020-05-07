import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/fieldForceProvider.dart';
import 'package:senior/widgets/errorWidget.dart';
import 'package:senior/providers/sellsProvider.dart';

class Target extends StatefulWidget {
  final bool isSells;

  Target({
    this.isSells = false,
  });

  @override
  _TargetState createState() => _TargetState();
}

class _TargetState extends State<Target> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.isSells
            ? Provider.of<SellsData>(context, listen: false).target == null
                ? Provider.of<SellsData>(context, listen: false).fetchTarget()
                : null
            : Provider.of<FieldForceData>(context, listen: false).target == null
                ? Provider.of<FieldForceData>(context, listen: false)
                    .fetchTarget()
                : null,
        builder: (context, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapShot.hasError) {
              return ErrorHandler(
                toDO: () {
                  setState(() {
                    widget.isSells
                        ? Provider.of<SellsData>(context, listen: false)
                            .target = null
                        : Provider.of<FieldForceData>(context, listen: false)
                            .target = null;
                  });
                },
              );
            }
            return widget.isSells
                ? Consumer<SellsData>(builder: (context, data, child) {
                    return data.target == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                tr('extra.noTarget'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                              RaisedButton(
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
                                  setState(() {
                                    Provider.of<SellsData>(context,
                                            listen: false)
                                        .target = null;
                                  });
                                },
                              ),
                            ],
                          )
                        : ListView(
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
                                    percent: (double.tryParse(
                                                  data.target.completed
                                                      .split('%')[0],
                                                ) /
                                                100) >=
                                            1.0
                                        ? 1.0
                                        : (double.tryParse(
                                              data.target.completed
                                                  .split('%')[0],
                                            ) /
                                            100),
                                    center: Text(
                                        data.target.completed.split('.')[0] +
                                            '%'),
                                    linearStrokeCap: LinearStrokeCap.butt,
                                    progressColor: Colors.blue,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              RaisedButton(
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
                                  setState(() {
                                    Provider.of<SellsData>(context,
                                            listen: false)
                                        .target = null;
                                  });
                                },
                              ),
                            ],
                          );
                  })
                : Consumer<FieldForceData>(builder: (context, data, child) {
                    return data.target.data == null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                tr('extra.noTarget'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              RaisedButton(
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
                                  setState(() {
                                    Provider.of<FieldForceData>(context,
                                            listen: false)
                                        .target = null;
                                  });
                                },
                              ),
                            ],
                          )
                        : ListView(
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
                                    percent: double.tryParse(
                                              data.target.data.targetPer,
                                            ) >=
                                            100.0
                                        ? 1.0
                                        : double.tryParse(
                                              data.target.data.targetPer,
                                            ) /
                                            100,
                                    center: Text(double.tryParse(
                                          data.target.data.targetPer,
                                        ).round().toString() +
                                        '%'),
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
                                    percent: double.tryParse(
                                              data.target.data.visited,
                                            ) >=
                                            100.0
                                        ? 1.0
                                        : double.tryParse(
                                              data.target.data.visited,
                                            ) /
                                            100,
                                    center: Text(double.tryParse(
                                          data.target.data.visited,
                                        ).round().toString() +
                                        '%'),
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
                                    percent: double.tryParse(
                                              data.target.data.newStorePer,
                                            ) >=
                                            100.0
                                        ? 1.0
                                        : double.tryParse(
                                              data.target.data.newStorePer,
                                            ) /
                                            100,
                                    center: Text(double.tryParse(
                                          data.target.data.newStorePer,
                                        ).round().toString() +
                                        '%'),
                                    linearStrokeCap: LinearStrokeCap.butt,
                                    progressColor: Colors.yellow,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              RaisedButton(
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
                                  setState(() {
                                    Provider.of<FieldForceData>(context,
                                            listen: false)
                                        .target = null;
                                  });
                                },
                              ),
                            ],
                          );
                  });
          }
        });
  }
}
