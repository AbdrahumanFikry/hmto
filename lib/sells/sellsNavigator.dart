import 'package:font_awesome_flutter/font_awesome_flutter.dart';import 'package:flutter/material.dart';import 'package:senior/driver/driverScreen.dart';import 'package:senior/sells/sellsMap.dart';import 'package:senior/sells/sellsProfile.dart';import 'package:easy_localization/easy_localization.dart';import 'package:provider/provider.dart';import '../providers/sellsProvider.dart';import '../widgets/errorWidget.dart';class SellsNavigator extends StatefulWidget {  final bool isDriver;  SellsNavigator({    this.isDriver = false,  });  @override  _SellsNavigatorState createState() => _SellsNavigatorState();}class _SellsNavigatorState extends State<SellsNavigator> {  int index = 0;  List<Widget> _pages = [];  @override  void initState() {    Provider.of<SellsData>(context, listen: false).stores = null;    _pages = [      SellsMap(//        isDriver: widget.isDriver,          ),      widget.isDriver ? DriverProfile() : SellsProfile(),    ];    super.initState();  }  void onPageChanged(int value) {    setState(() {      index = value;    });  }  @override  Widget build(BuildContext context) {    return Scaffold(      body: FutureBuilder(          future: Provider.of<SellsData>(context, listen: false).stores == null              ? Provider.of<SellsData>(context, listen: false).allStores()              : null,          builder: (context, dataSnapShot) {            if (dataSnapShot.connectionState == ConnectionState.waiting) {              return Center(                child: CircularProgressIndicator(),              );            } else {              if (dataSnapShot.hasError) {                return ErrorHandler(                  toDO: () {                    setState(() {                      Provider.of<SellsData>(context, listen: false).stores =                          null;                    });                  },                );              } else {                return _pages[index];              }            }          }),      bottomNavigationBar: BottomNavigationBar(        onTap: onPageChanged,        items: [          BottomNavigationBarItem(            icon: Icon(              FontAwesomeIcons.map,              color: index != 0 ? Colors.black : Colors.green,            ),            title: Text(              tr('navigator.map'),              style: TextStyle(                fontSize: 16,                color: index != 0 ? Colors.black : Colors.green,              ),            ),          ),          BottomNavigationBarItem(            icon: Icon(              FontAwesomeIcons.user,              color: index != 1 ? Colors.black : Colors.green,            ),            title: Text(              tr('navigator.profile'),              style: TextStyle(                fontSize: 16,                color: index != 1 ? Colors.black : Colors.green,              ),            ),          ),        ],      ),    );  }}