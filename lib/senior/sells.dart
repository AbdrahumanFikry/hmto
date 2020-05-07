import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senior/senior/sellsTarget.dart';
import '../models/sellsAgents.dart';
import '../senior/targetGraph.dart';

class SellsScreen extends StatelessWidget {
  final List<Data> data;

  SellsScreen({
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
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          data[index].name,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Spacer(),
                      ],
                    ),
                    leading: Image.asset(
                      'assets/user.png',
                      fit: BoxFit.cover,
                      height: 50.0,
                      width: 50.0,
                    ),
                    trailing: Text(
                      data[index].ownDailyBalance.toString() +
                          ' ' +
                          tr('senior_profile.egp'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SellsTarget(
                            name: data[index].name,
                            ownMonthlyBalance: data[index].ownMonthlyBalance,
                            ownDailyBalance: data[index].ownDailyBalance,
                            monthlyTargetBalance:
                                data[index].targetMonthlyBalance,
                          ),
                        ),
                      );
                    },
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
