import 'package:provider/provider.dart';
import '../providers/authenticationProvider.dart';
import 'package:flutter/material.dart';
import 'package:senior/forceField/storesScreen.dart';
import 'package:senior/widgets/accountInfo.dart';

class DriverProfile extends StatefulWidget {
  @override
  _DriverProfileState createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
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
                      background: Consumer<Auth>(
                        builder: (context, auth, _) => AccountInfo(
                          name: auth.userName,
                        ),
                      ),
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
