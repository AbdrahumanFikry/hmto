import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:senior/forceField/forceFieldMap.dart';
import 'package:senior/forceField/forceFieldProfile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
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
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Check your internet connection',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          child: Text(
                            'Refresh',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                          color: Colors.green,
                          onPressed: () {
                            setState(() {
                              Provider.of<FieldForceData>(context,
                                      listen: false)
                                  .stores = null;
                            });
                          },
                        )
                      ],
                    ),
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
