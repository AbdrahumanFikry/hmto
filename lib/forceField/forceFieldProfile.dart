import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior/forceField/storesScreen.dart';
import 'package:senior/forceField/target.dart';

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
    pageController.animateToPage(tabIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
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
                    text: 'My Info',
                  ),
                  Tab(
                    text: 'Target',
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
                      //-------------------Target Screen -----------------------
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
                      background: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: 20.0,
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: CachedNetworkImage(
                                placeholder:
                                    (BuildContext context, String url) {
                                  return SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://images.pexels.com/photos/1073097/pexels-photo-1073097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'name',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 38.3,
                              ),
                            ),
                          ),
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.3,
                              height: 0.08 * MediaQuery.of(context).size.height,
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
                                          left: 16,
                                        ),
                                        child: Text(
                                          'ads',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
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
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          'qs',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
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
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          'comp'.length.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
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
