import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:expandable/expandable.dart';

class ItemTargetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ExpandablePanel(
            theme: ExpandableThemeData(
              animationDuration: Duration(milliseconds: 200),
            ),
            header: Row(
              children: <Widget>[
                Text(
                  'Category',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new LinearPercentIndicator(
                    width: 170.0,
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 20.0,
                    percent: 0.5,
                    center: Text("50.0%"),
                    linearStrokeCap: LinearStrokeCap.butt,
                    progressColor: Colors.red,
                  ),
                ),
              ],
            ),
            expanded: Column(
              children: <Widget>[
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            onTap: () {},
                            subtitle: Row(
                              children: <Widget>[
                                Text('150 point'),
                                Spacer(),
                              ],
                            ),
                            title: Text('Cabury'),
                          ),
                          Divider(
                            height: 2,
                          )
                        ],
                      );
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
