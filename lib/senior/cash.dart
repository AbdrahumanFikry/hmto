import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/sellsAgents.dart';

class CashScreen extends StatelessWidget {
  final List<Data> data;

  CashScreen({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (ctx, index) {
              Data sells = data[index];
              double target =
                  (sells.ownMonthlyBalance / sells.targetMonthlyBalance) * 100;
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        target.isNaN
                            ? Text(
                                tr('extra.noTarget'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              )
                            : Expanded(
                                child: LinearPercentIndicator(
                                  animation: true,
                                  animationDuration: 1000,
                                  lineHeight: 25.0,
                                  percent: target / 100,
                                  center: Text(target.toString() + ' %'),
                                  linearStrokeCap: LinearStrokeCap.butt,
                                  progressColor: Colors.red,
                                ),
                              ),
                        Text(
                          sells.ownMonthlyBalance.toString() +
                              ' ' +
                              tr('senior_profile.egp'),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    leading: Image.asset(
                      'assets/user.png',
                      fit: BoxFit.cover,
                      height: 50.0,
                      width: 50.0,
                    ),
//                    ClipRRect(
//                      borderRadius: BorderRadius.all(
//                        Radius.circular(10),
//                      ),
//                      child: CachedNetworkImage(
//                        fit: BoxFit.cover,
//                        imageUrl:
//                            'https://specials-images.forbesimg.com/imageserve/5d2893a234a5c400084b2955/1920x0.jpg?cropX1=29&cropX2=569&cropY1=20&cropY2=560',
//                        width: 50.0,
//                        height: 50.0,
//                      ),
//                    ),
                  ),
                  Divider(
                    height: 2,
                    indent: 0,
                    endIndent: 50,
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
