import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/seniorProvider.dart';
import 'package:senior/senior/targetGraph.dart';
import 'package:senior/widgets/errorWidget.dart';

class Agents extends StatefulWidget {
  @override
  _AgentsState createState() => _AgentsState();
}

class _AgentsState extends State<Agents> {
  bool _isLoading = false;

  Future<void> onRefresh() async {
    await Provider.of<SeniorData>(context, listen: false).fetchAgents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: FutureBuilder(
          future: Provider.of<SeniorData>(context, listen: false).agents == null
              ? Provider.of<SeniorData>(context, listen: false).fetchAgents()
              : null,
          builder: (context, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapShot.hasError) {
                print(':::::::::' + dataSnapShot.error.toString());
                return ErrorHandler(
                  toDO: () {
                    setState(() {
                      Provider.of<SeniorData>(context, listen: false).agents =
                          null;
                    });
                  },
                );
              } else {
                return Consumer<SeniorData>(
                  builder: (context, data, child) => data.agents.data.length ==
                          null
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
                      : ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data.agents.data.length,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: GestureDetector(
                                        onTap: data.agents.data[index]
                                                    .analysis ==
                                                null
                                            ? () {}
                                            : () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        TargetGraphSenior(
                                                      isFieldForce: true,
                                                      visits: double.tryParse(
                                                        data.agents.data[index]
                                                            .analysis.visited,
                                                      ),
                                                      target: double.tryParse(
                                                        data.agents.data[index]
                                                            .analysis.targetPer,
                                                      ),
                                                      newStores:
                                                          double.tryParse(
                                                        data
                                                            .agents
                                                            .data[index]
                                                            .analysis
                                                            .newStorePer,
                                                      ),
                                                      loading: _isLoading,
                                                      onTab: () async {
                                                        _isLoading = true;
                                                        await Provider.of<
                                                                    SeniorData>(
                                                                context,
                                                                listen: false)
                                                            .fetchAgents();
                                                        _isLoading = false;
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.23,
                                              child: Text(
                                                data.agents.data[index].name,
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
                                                percent: data.agents.data[index]
                                                            .analysis ==
                                                        null
                                                    ? 0.0
                                                    : double.parse(
                                                              data
                                                                  .agents
                                                                  .data[index]
                                                                  .analysis
                                                                  .targetPer,
                                                            ) >=
                                                            100.0
                                                        ? 1.0
                                                        : double.tryParse(
                                                              data
                                                                  .agents
                                                                  .data[index]
                                                                  .analysis
                                                                  .targetPer,
                                                            ) /
                                                            100,
                                                center: Text(
                                                  data.agents.data[index]
                                                              .analysis ==
                                                          null
                                                      ? 'No Target'
                                                      : data
                                                              .agents
                                                              .data[index]
                                                              .analysis
                                                              .targetPer
                                                              .split('.')[0] +
                                                          '%',
                                                ),
                                                linearStrokeCap:
                                                    LinearStrokeCap.butt,
                                                progressColor: Colors.red,
                                              ),
                                            ),
                                            Text(
                                              '',
//                                              data.agents.data[index]
//                                                          .analysis ==
//                                                      null
//                                                  ? ''
//                                                  : data.agents.data[index]
//                                                      .analysis.visited,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            data.agents.data[index].analysis ==
                                                    null
                                                ? Text('')
                                                : Text(
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
                                        child: Image.asset(
                                          'assets/user.png',
                                          fit: BoxFit.cover,
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
          },
        ),
      ),
    );
  }
}
