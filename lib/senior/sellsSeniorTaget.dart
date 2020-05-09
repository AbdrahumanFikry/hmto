import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/seniorProvider.dart';
import 'package:senior/widgets/errorWidget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TargetSellsSeniorScreen extends StatefulWidget {
  @override
  _TargetSellsSeniorScreenState createState() =>
      _TargetSellsSeniorScreenState();
}

class _TargetSellsSeniorScreenState extends State<TargetSellsSeniorScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<SeniorData>(context, listen: false)
                  .sellsSeniorTarget ==
              null
          ? Provider.of<SeniorData>(context, listen: false).fetchTargetSells()
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
                  Provider.of<SeniorData>(context, listen: false)
                      .sellsSeniorTarget = null;
                });
              },
            );
          } else {
            return Consumer<SeniorData>(builder: (context, data, _) {
              double myTarget = data.sellsSeniorTarget.data.targetCompleted /
                  data.sellsSeniorTarget.data.targetRequired;
              return data.sellsSeniorTarget.data == null
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
                  : Padding(
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
                                  '${tr('target.target')} :',
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
                                        data.sellsSeniorTarget.data
                                                    .targetRequired
                                                    .toString() ==
                                                null
                                            ? '0'
                                            : data.sellsSeniorTarget.data
                                                .targetRequired
                                                .toString(),
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
                          Container(
                            height: 60.0,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '${tr('target.monthCash')} :',
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
                                        data.sellsSeniorTarget.data
                                                    .targetCompleted
                                                    .toString() ==
                                                null
                                            ? '0'
                                            : data.sellsSeniorTarget.data
                                                .targetCompleted
                                                .toString(),
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
                          myTarget.isNaN || myTarget.isInfinite
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
                                      tr('target.complete'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: LinearPercentIndicator(
                                        animation: true,
                                        animationDuration: 1000,
                                        lineHeight: 25.0,
                                        percent: myTarget,
                                        center: Text(
                                            myTarget.round().toString() + '%'),
                                        linearStrokeCap: LinearStrokeCap.butt,
                                        progressColor: Colors.blue,
                                      ),
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
                                Provider.of<SeniorData>(context, listen: false)
                                    .sellsSeniorTarget = null;
                              });
                            },
                          ),
                        ],
                      ),
                    );
            });
          }
        }
      },
    );
  }
}
