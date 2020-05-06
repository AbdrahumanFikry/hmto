import 'package:flutter/material.dart';
import 'package:senior/senior/sells.dart';
import '../senior/targetGraph.dart';
import 'cash.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/authenticationProvider.dart';
import 'package:provider/provider.dart';
import '../auth/loginScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabBarScreenSells extends StatelessWidget {
  final bool isAdmin;
  TabBarScreenSells({this.isAdmin=false});
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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tr('sells_profile.type'),
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.4,
          backgroundColor: Colors.white,
          leading: new Container(),
          actions: <Widget>[
            isAdmin?Container():
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
                tr('sells_profile.type'),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              Text(
                tr('senior_profile.cash'),
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
            SellsScreen(),
            CashScreen(),
            TargetGraphSenior(),
          ],
        ),
      ),
    );
  }
}
