import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class CashScreen extends StatelessWidget {
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
            itemCount: 6,
            itemBuilder: (ctx, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: GestureDetector(
                      onTap: () {
                        //todo----
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: LinearPercentIndicator(
//                              width: MediaQuery.of(context).size.width * 0.5,
                              animation: true,
                              animationDuration: 1000,
                              lineHeight: 25.0,
                              percent: 0.3,
                              center: Text("30.0%"),
                              linearStrokeCap: LinearStrokeCap.butt,
                              progressColor: Colors.red,
                            ),
                          ),
                          Text(
                            '10' + ' ' + tr('senior_profile.egp'),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            'https://specials-images.forbesimg.com/imageserve/5d2893a234a5c400084b2955/1920x0.jpg?cropX1=29&cropX2=569&cropY1=20&cropY2=560',
                        width: 50.0,
                        height: 50.0,
                      ),
                    ),
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
