import 'package:flutter/material.dart';
import 'package:senior/senior/tabBarForceField.dart';
import 'package:senior/senior/tabBarSells.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 50.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TabBarForceFieldScreen(
                      isAdmin: false,
                    ),
                  ),
                );
              },
              color: Colors.green,
              child: Text(
                tr('field_force_profile.type'),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 50.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TabBarScreenSells(
//                      isAdmin: false,
                        ),
                  ),
                );
              },
              color: Colors.green,
              child: Text(
                tr('sells_profile.type'),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
