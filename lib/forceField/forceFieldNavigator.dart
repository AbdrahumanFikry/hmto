import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:senior/forceField/forceFieldMap.dart';
import 'package:senior/forceField/forceFieldProfile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:senior/widgets/errorWidget.dart';
import '../providers/fieldForceProvider.dart';

class ForceFieldNavigator extends StatefulWidget {
  @override
  _ForceFieldNavigatorState createState() => _ForceFieldNavigatorState();
}

class _ForceFieldNavigatorState extends State<ForceFieldNavigator> {
  int index = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    Provider.of<FieldForceData>(context, listen: false).stores = null;
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
        body: FutureBuilder(
            future:
                Provider.of<FieldForceData>(context, listen: false).stores ==
                        null
                    ? Provider.of<FieldForceData>(context, listen: false)
                        .fetchStores()
                    : null,
            builder: (context, dataSnapShot) {
              if (dataSnapShot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (dataSnapShot.hasError) {
                  return ErrorHandler(
                    toDO: () {
                      setState(() {
                        Provider.of<FieldForceData>(context, listen: false)
                            .stores = null;
                      });
                    },
                  );
                } else {
                  return _pages[index];
                }
              }
            }),
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
