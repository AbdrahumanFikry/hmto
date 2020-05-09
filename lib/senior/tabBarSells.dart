import 'package:flutter/material.dart';
import 'package:senior/senior/sells.dart';
import 'package:senior/senior/sellsSeniorTaget.dart';
import '../senior/targetGraph.dart';
import 'cash.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/authenticationProvider.dart';
import 'package:provider/provider.dart';
import '../auth/loginScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/seniorProvider.dart';
import '../widgets/errorWidget.dart';

class TabBarScreenSells extends StatefulWidget {
  final bool isAdmin;

  TabBarScreenSells({
    this.isAdmin = false,
  });

  @override
  _TabBarScreenSellsState createState() => _TabBarScreenSellsState();
}

class _TabBarScreenSellsState extends State<TabBarScreenSells> {
  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (Route<dynamic> route) => false);
    Provider.of<Auth>(context, listen: false).logout();
  }

  Future<void> onRefresh() async {
    await Provider.of<SeniorData>(context, listen: false).fetchSellsAgents();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            InkWell(
              onTap: _logout,
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
                tr('senior_profile.target'),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: FutureBuilder(
            future:
                Provider.of<SeniorData>(context, listen: false).sellsAgents ==
                        null
                    ? Provider.of<SeniorData>(context, listen: false)
                        .fetchSellsAgents()
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
                        Provider.of<SeniorData>(context, listen: false)
                            .sellsAgents = null;
                      });
                    },
                  );
                }
                return Consumer<SeniorData>(
                  builder: (context, data, _) => TabBarView(
                    children: [
                      SellsScreen(
                        data: data.sellsAgents.data,
                      ),
                      TargetSellsSeniorScreen(),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
