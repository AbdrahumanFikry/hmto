import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senior/senior/agents.dart';
import 'package:senior/senior/targetGraphForceField.dart';
import 'package:senior/senior/targetGraphSells.dart';

class TabBarForceFieldScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.4,
          backgroundColor: Colors.white,
          leading: new Container(),
          bottom: TabBar(
            tabs: [
              Text(
                tr('senior_profile.agents'),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              Text(
                tr('senior_profile.target'),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Agents(),
            TargetGraphForceField(),
          ],
        ),
      ),
    );
  }
}
