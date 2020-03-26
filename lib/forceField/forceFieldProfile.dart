import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior/forceField/storesScreen.dart';
import 'package:senior/forceField/target.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senior/widgets/accountInfo.dart';

class ForceFieldProfile extends StatefulWidget {
  @override
  _ForceFieldProfileState createState() => _ForceFieldProfileState();
}

class _ForceFieldProfileState extends State<ForceFieldProfile>
    with TickerProviderStateMixin {
  int tabIndex = 0;
  PageController pageController = PageController();

  onTabTabBar(int tabIndex) {
    tabIndex = tabIndex;
    pageController.animateToPage(
      tabIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 3, left: 20, right: 20),
              child: TabBar(
                onTap: onTabTabBar,
                indicatorColor: Colors.green,
                labelColor: Colors.black,
                tabs: <Widget>[
                  Tab(
                    text: tr('field_force_profile.tab_one'),
                  ),
                  Tab(
                    text: tr('field_force_profile.tab_two'),
                  )
                ],
                controller: TabController(length: 2, vsync: this),
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
                      StoresScreen(),
                      Target(),
                    ],
                  ),
                ),
                //---------------------- User info ----------------------------
                headerSliverBuilder: (_, x) => [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    expandedHeight: 320,
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
