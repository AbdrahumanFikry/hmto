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
//                          Text(
//                            '20',
//                            style: TextStyle(
//                              fontSize: 16.0,
//                              color: Colors.black,
//                            ),
//                          ),
//                          SizedBox(
//                            width: 10.0,
//                          ),
//                          Text(
//                            tr('senior_profile.one_visit'),
//                            style: TextStyle(
//                              fontSize: 12.0,
//                              color: Colors.blue,
//                            ),
//                          ),
                      ],
                    ),
                    leading: Image.asset(
                      'assets/user.png',
                      fit: BoxFit.cover,
                      height: 50.0,
                      width: 50.0,
                    ),
                    trailing: Text(
                      data[index].ownMonthlyBalance.toString() +
                          ' ' +
                          tr('senior_profile.egp'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                      ),
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
