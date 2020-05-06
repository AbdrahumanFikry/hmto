import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:senior/forceField/target.dart';
import 'package:senior/providers/sellsProvider.dart';
import 'package:senior/sells/itemTargetScreen.dart';
import 'package:senior/forceField/storesScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senior/widgets/accountInfo.dart';
import '../providers/authenticationProvider.dart';

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
    return Scaffold(
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
//                  Tab(
//                    text: tr('sells_profile.tab_three'),
//                  ),
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
                    Consumer<SellsData>(
                      builder: (context, data, child) => StoresScreen(
                        isSells: true,
                        isDriver: false,
                        data: data.stores.data,
                      ),
                    ),
                    Target(
                      isSells: true,
                    ),
//                      ItemTargetScreen(),
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
                        name: auth.userName == null ? 'user' : auth.userName,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
