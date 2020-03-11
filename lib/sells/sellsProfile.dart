import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior/forceField/target.dart';
import 'package:senior/sells/itemTargetScreen.dart';
import 'package:senior/forceField/storesScreen.dart';

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
                    text: 'My Info',
                  ),
                  Tab(
                    text: 'Target',
                  ),
                  Tab(
                    text: 'Item Target',
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
                      background: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 50 * screenSize.aspectRatio),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: CachedNetworkImage(
                                  placeholder:
                                      (BuildContext context, String url) {
                                    return SizedBox(
                                        width: 200 * screenSize.aspectRatio,
                                        height: 210 * screenSize.aspectRatio,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  },
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      'https://images.pexels.com/photos/1073097/pexels-photo-1073097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                                  width: 200 * screenSize.aspectRatio,
                                  height: 210 * screenSize.aspectRatio,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Mohamed Gaber',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 38.3 * screenSize.aspectRatio),
                            ),
                          ),
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: SizedBox(
                              width: screenSize.width / 1.3,
                              height: 0.1 * screenSize.height,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.user,
                                        color: Colors.green,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16 * screenSize.aspectRatio),
                                        child: Text(
                                          '5',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.question,
                                        color: Colors.green,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16 * screenSize.aspectRatio),
                                        child: Text(
                                          '6',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.bomb,
                                        color: Colors.green,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16 * screenSize.aspectRatio),
                                        child: Text(
                                          '5',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
