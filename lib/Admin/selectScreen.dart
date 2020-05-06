import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior/senior/tabBarForceField.dart';
import 'package:senior/senior/tabBarSells.dart';
import 'package:senior/senior/targetGraph.dart';
import 'package:senior/senior/targetGraphForceField.dart';

class SelectScreen extends StatefulWidget {
  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  @override
  //--------------------variables----------------------
  int index = 0;
  List<Widget> _pages = [];
  //--------------------methods------------------------
  void initState() {
    _pages = [
      TabBarForceFieldScreen(
        isAdmin: true,
      ),
      TabBarScreenSells(
        isAdmin: true,
      )
    ];
    super.initState();
  }

  void _changeScreen(value) {
    setState(() {
      index = value;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          InkWell(
            onTap: () {
              //todo---
            },
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
      ),
      body: _pages[index],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: _changeScreen,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              activeIcon: Icon(Icons.person_pin,color: Colors.green,),
              title: Text(
                "FieldForce Senior Target",
                style: TextStyle(
                  fontSize: 16,
                  color: index != 0 ? Colors.black : Colors.green,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              activeIcon: Icon(Icons.person,color: Colors.green,),
              title: Text(
                "Salles Senior Target",
                style: TextStyle(
                  fontSize: 16,
                  color: index != 0 ? Colors.green : Colors.black,
                ),
              ),
            ),
          ]
      ),
    );
  }
}
