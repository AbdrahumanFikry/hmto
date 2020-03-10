import 'package:flutter/material.dart';
import 'package:senior/sells/startDay.dart';
import 'package:senior/forceField/forceFieldNavigator.dart';
import 'package:senior/senior/agents.dart';

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
                      builder: (context) => Agents(),
                    ),
                  );
                },
                color: Colors.green,
                child: Text(
                  'Senior',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
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
                  'Field Force',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
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
                  'Sells',
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
