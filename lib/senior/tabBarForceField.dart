import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:senior/senior/agents.dart';
import 'package:senior/senior/targetGraphForceField.dart';
import '../providers/authenticationProvider.dart';
import 'package:provider/provider.dart';
import '../auth/loginScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabBarForceFieldScreen extends StatelessWidget {
  void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (Route<dynamic> route) => false);
    Provider.of<Auth>(context, listen: false).logout();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.4,
          backgroundColor: Colors.white,
          leading: new Container(),
          actions: <Widget>[
            InkWell(
              onTap: () => _logout(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.signOutAlt,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      tr('login_screen.logout'),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
