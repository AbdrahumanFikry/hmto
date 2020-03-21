import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:senior/driver/driverScreen.dart';
import 'package:senior/sells/sellsMap.dart';
import 'package:senior/sells/sellsProfile.dart';
import 'package:easy_localization/easy_localization.dart';

class SellsNavigator extends StatefulWidget {
  final bool isDriver;

  SellsNavigator({this.isDriver = false});

  @override
  _SellsNavigatorState createState() => _SellsNavigatorState();
}

class _SellsNavigatorState extends State<SellsNavigator> {
  int index = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    _pages = [
      SellsMap(
        isDriver: widget.isDriver,
      ),
      widget.isDriver ? DriverProfile() : SellsProfile(),
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
    return Scaffold(
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
    );
  }
}
