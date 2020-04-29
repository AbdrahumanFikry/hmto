import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/sellsProvider.dart';
import 'package:senior/sells/sellsNavigator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senior/widgets/alertDialog.dart';
import 'package:senior/widgets/errorWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StartDay extends StatefulWidget {
  @override
  _StartDayState createState() => _StartDayState();
}

class _StartDayState extends State<StartDay> {
  void _startDay({int balance, bool transferred}) async {
    if (balance == 0 && transferred) {
      final prefs = await SharedPreferences.getInstance();
      final userData = {
        'date': DateTime.now().toIso8601String().substring(0, 10),
      };
      prefs.setString('startDayData', json.encode(userData));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SellsNavigator(),
        ),
      );
    } else {
      GlobalAlertDialog.showErrorDialog(tr('extra.noStartDay'), context);
      setState(() {
        Provider.of<SellsData>(context, listen: false).startDayData = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('start_day.start'),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Provider.of<SellsData>(context, listen: false).startDayData ==
                null
            ? Provider.of<SellsData>(context, listen: false).fetchStartDayData()
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
                    Provider.of<SellsData>(context, listen: false)
                        .startDayData = null;
                  });
                },
              );
            }
          }
          return Consumer<SellsData>(builder: (context, data, child) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              children: <Widget>[
                Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Text(
                        '${tr('start_day.balance')} :',
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
                              data.startDayData.ownMoney.toString(),
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
                ExpandablePanel(
                  theme: ExpandableThemeData(
                    animationDuration: Duration(
                      milliseconds: 200,
                    ),
                  ),
                  header: Text(
                    tr('start_day.cart_products'),
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  expanded: ListView.builder(
                    itemCount: data.startDayData.productsInOwnCar.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        title: Text(
                          data.startDayData.productsInOwnCar[index].productName,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        subtitle: Text(
                          data.startDayData.productsInOwnCar[index].quantity
                              .toString(),
                          style: TextStyle(fontSize: 16.0),
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
//                    ExpandablePanel(
//                      theme: ExpandableThemeData(
//                          animationDuration: Duration(milliseconds: 200)),
//                      header: Text(
//                        tr('start_day.new_products'),
//                        style: TextStyle(
//                            fontWeight: FontWeight.w700, fontSize: 20),
//                      ),
//                      expanded: ListView.builder(
//                        itemCount: 5,
//                        shrinkWrap: true,
//                        physics: NeverScrollableScrollPhysics(),
//                        itemBuilder: (ctx, index) {
//                          return ListTile(
//                            title: Text(
//                              'Chocolate',
//                              style: TextStyle(fontSize: 16.0),
//                            ),
//                            subtitle: Text(
//                              '50 piece',
//                              style: TextStyle(fontSize: 16.0),
//                            ),
//                          );
//                        },
//                      ),
//                    ),
//                    Divider(),
//                    ExpandablePanel(
//                      theme: ExpandableThemeData(
//                          animationDuration: Duration(milliseconds: 200)),
//                      header: Text(
//                        tr('start_day.return_products'),
//                        style: TextStyle(
//                            fontWeight: FontWeight.w700, fontSize: 20),
//                      ),
//                      expanded: ListView.builder(
//                        itemCount: 5,
//                        shrinkWrap: true,
//                        physics: NeverScrollableScrollPhysics(),
//                        itemBuilder: (ctx, index) {
//                          return ListTile(
//                            title: Text(
//                              'Chocolate',
//                              style: TextStyle(fontSize: 16.0),
//                            ),
//                            subtitle: Text(
//                              '50 piece',
//                              style: TextStyle(fontSize: 16.0),
//                            ),
//                          );
//                        },
//                      ),
//                    ),
//                    Divider(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: FlatButton(
                      onPressed: () => _startDay(
                        balance: data.startDayData.ownMoney,
                        transferred: data.startDayData.productTransferredToday,
                      ),
                      child: Text(
                        tr('start_day.submit'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          });
        },
      ),
    );
  }
}
