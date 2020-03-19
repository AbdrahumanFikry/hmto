import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:senior/forceField/forceFieldMap.dart';
import 'package:senior/forceField/forceFieldProfile.dart';
import 'package:easy_localization/easy_localization.dart';

class ForceFieldNavigator extends StatefulWidget {
  @override
  _ForceFieldNavigatorState createState() => _ForceFieldNavigatorState();
}

class _ForceFieldNavigatorState extends State<ForceFieldNavigator> {
  int index = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    _pages = [
      ForceFieldMap(),
      ForceFieldProfile(),
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
        bottomNavigationBar: BottomNavigationBar(
          onTap: onPageChanged,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.map,
                color: index != 0 ? Colors.black : Colors.green,
              ),
              title: Text(
                tr('navigator.map'),
                style: TextStyle(
                  fontSize: 16,
                  color: index != 0 ? Colors.black : Colors.green,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.user,
                color: index != 1 ? Colors.black : Colors.green,
              ),
              title: Text(
                tr('navigator.profile'),
                style: TextStyle(
                  fontSize: 16,
                  color: index != 1 ? Colors.black : Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
