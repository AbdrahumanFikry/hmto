import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/sellsProvider.dart';
import 'package:senior/sells/sellsNavigator.dart';
import 'package:easy_localization/easy_localization.dart';

class StartDay extends StatelessWidget {
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
        future: Provider.of<SallesData>(context, listen: false).fetchStartDayData(),
          builder: (context,dataSnapShot){
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              if(dataSnapShot.hasError){
                Center(
                  child: Text('No Internet Connection'),
                );
              }
            }
            return Consumer<SallesData>(builder: (context, data, child){
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
                              border: Border.all(color: Colors.grey, width: 1.0)),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '${data.seniorStartDayModel.ownMoney}',
                                style: TextStyle(fontSize: 20.0),
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
                        animationDuration: Duration(milliseconds: 200)),
                    header: Text(
                      tr('start_day.cart_products'),
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    expanded: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          title: Text(
                            'Chocolate',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          subtitle: Text(
                            '50 piece',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  ExpandablePanel(
                    theme: ExpandableThemeData(
                        animationDuration: Duration(milliseconds: 200)),
                    header: Text(
                      tr('start_day.new_products'),
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    expanded: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          title: Text(
                            'Chocolate',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          subtitle: Text(
                            '50 piece',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  ExpandablePanel(
                    theme: ExpandableThemeData(
                        animationDuration: Duration(milliseconds: 200)),
                    header: Text(
                      tr('start_day.return_products'),
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    expanded: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          title: Text(
                            'Chocolate',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          subtitle: Text(
                            '50 piece',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => SellsNavigator(),
                            ),
                          );
                        },
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
          }
      )
    );
  }
}
