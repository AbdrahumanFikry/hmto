import 'package:flutter/material.dart';
import 'package:senior/sells/sellsNavigator.dart';
import 'package:senior/sells/startDay.dart';
import 'package:senior/forceField/forceFieldNavigator.dart';
import 'package:senior/senior/selectType.dart';
import 'package:easy_localization/easy_localization.dart';

class Select extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SelectTypeScreen(),
                    ),
                  );
                },
                color: Colors.green,
                child: Text(
                  tr('senior_profile.type'),
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
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ForceFieldNavigator(),
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
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => StartDay(),
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
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 50.0,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SellsNavigator(
                        isDriver: true,
                      ),
                    ),
                  );
                },
                color: Colors.green,
                child: Text(
                  tr('driver_profile.type'),
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
      ),
    );
  }
}
