import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior/forceField/target.dart';
import 'package:senior/sells/itemTargetScreen.dart';
import 'package:senior/forceField/storesScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senior/widgets/accountInfo.dart';

class SellsProfile extends StatefulWidget {
  @override
  _SellsProfileState createState() => _SellsProfileState();
}

class _SellsProfileState extends State<SellsProfile>
    with TickerProviderStateMixin {
  PageController pageController = PageController();
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
              child: TabBar(
                onTap: (index) {
                  this.tabIndex = index;
                  pageController.animateToPage(index,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn);
                },
                indicatorColor: Colors.green,
                labelColor: Colors.black,
                tabs: <Widget>[
                  Tab(
                    text: tr('sells_profile.tab_one'),
                  ),
                  Tab(
                    text: tr('sells_profile.tab_two'),
                  ),
                  Tab(
                    text: tr('sells_profile.tab_three'),
                  ),
                ],
                controller: TabController(length: 3, vsync: this),
              ),
            ),
            Expanded(
              child: NestedScrollView(
                body: ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: PageView(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      StoresScreen(
                        isSells: true,
                      ),
                      Target(),
                      ItemTargetScreen(),
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
