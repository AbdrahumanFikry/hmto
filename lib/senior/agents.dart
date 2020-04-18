import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/fieldForceProvider.dart';
import 'package:senior/senior/targetGraphSells.dart';

class Agents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:  Provider.of<FieldForceData>(context, listen: false).fetchAgents(),
          builder: (context,dataSnapShot){
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              if(dataSnapShot.hasError){
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
              return Consumer<FieldForceData>(builder: (context, data, child){
                return data.agentsModel.data.length == null
                    ?Center(
                  child: Text(
                    tr('extra.noTarget'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ): ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.agentsModel.data.length,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TargetGraphSenior(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.23,
                                      child: Text(
                                        data.agentsModel.data[index].name,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: LinearPercentIndicator(
//                              width: MediaQuery.of(context).size.width * 0.3,
                                        animation: true,
                                        animationDuration: 1000,
                                        lineHeight: 25.0,
                                        percent: data.agentsModel.data[index].analysis==null? 0.0:
                                            double.parse(data.agentsModel.data[index].analysis.visited)/100,
                                        center: Text("${data.agentsModel.data[index].analysis==null? 'No Target':
                                        data.agentsModel.data[index].analysis.visited
                                        }"),
                                        linearStrokeCap: LinearStrokeCap.butt,
                                        progressColor: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      "${data.agentsModel.data[index].analysis==null? '':data.agentsModel.data[index].analysis.visited}",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      tr('senior_profile.one_visit'),
                                      style: TextStyle(
                                        fontSize: 12.0,
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
                                child: Image.asset('assets/user.png'),
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
                );
              });
            }
          }
      ),
    );
  }
}
