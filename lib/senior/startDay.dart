import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:senior/senior/SeniorNavigator.dart';

class StartDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Day'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        children: <Widget>[
          Container(
            height: 60.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Text(
                  'Balance :',
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
                        '500',
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
              'Cart Product',
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
              'New Product',
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
              'Return Products',
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
                      builder: (context) => SeniorNavigator(),
                    ),
                  );
                },
                child: Text(
                  'Start Day',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
