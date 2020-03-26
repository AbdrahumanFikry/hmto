import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior/forceField/storesScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senior/widgets/accountInfo.dart';

class DriverProfile extends StatefulWidget {
  @override
  _DriverProfileState createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: NestedScrollView(
                body: ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      StoresScreen(
                        isDriver: true,
                        isSells: false,
                      ),
                    ],
                  ),
                ),
                //-------------------- User Info ------------------------------
                headerSliverBuilder: (_, x) => [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    expandedHeight: 325.250,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: AccountInfo(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
