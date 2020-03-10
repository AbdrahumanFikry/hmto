import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:senior/sells/sellsMap.dart';
import 'package:senior/sells/sellsProfile.dart';

class SellsNavigator extends StatefulWidget {
  @override
  _SellsNavigatorState createState() => _SellsNavigatorState();
}

class _SellsNavigatorState extends State<SellsNavigator> {
  int index = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    _pages = [
      SellsMap(),
      SellsProfile(),
    ];
    super.initState();
  }

  void onPageChanged(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[index],
        bottomNavigationBar: FancyBottomNavigation(
          barBackgroundColor: Colors.white,
          circleColor: Colors.green,
          inactiveIconColor: Color(0xff737373),
          onTabChangedListener: onPageChanged,
          tabs: [
            TabData(
              iconData: FontAwesomeIcons.map,
              title: 'Map',
            ),
            TabData(
              iconData: FontAwesomeIcons.user,
              title: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
