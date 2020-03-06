import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior/seniorAds/tabName.dart';

class SeniorAdsProfile extends StatefulWidget {
  @override
  _SeniorAdsProfileState createState() => _SeniorAdsProfileState();
}

class _SeniorAdsProfileState extends State<SeniorAdsProfile>
    with TickerProviderStateMixin {
  int tabIndex = 0;
  PageController pageController = PageController();

  onTabTabBar(int tabIndex) {
    tabIndex = tabIndex;
    pageController.animateToPage(tabIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  var tabs = [
    {'name': 'Questions', 'add': TabName('Questions')},
    {'name': 'Competators', 'add': TabName('Competators')}
  ];

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
                      ListView.builder(
                        itemCount: 3,
                        itemBuilder: (ctx, index) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                subtitle: Text('Has created count market'),
                                title: Text('info'),
                                leading: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        'https://specials-images.forbesimg.com/imageserve/5d2893a234a5c400084b2955/1920x0.jpg?cropX1=29&cropX2=569&cropY1=20&cropY2=560',
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),
                                onTap: () {},
                              ),
                              Divider(
                                height: 2,
                                indent: 0,
                                endIndent: 50,
                              )
                            ],
                          );
                        },
                      ),
                      ListView(
                        children: <Widget>[
                          ExpandablePanel(
                            theme: ExpandableThemeData(
                              useInkWell: false,
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.center,
                              iconPlacement: ExpandablePanelIconPlacement.left,
                            ),
                            header: Row(
                              children: <Widget>[
                                Text(
                                  'Long answer questions',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: ButtonTheme(
                                    height: 50,
                                    minWidth: 50,
                                    child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        color: Colors.blue,
                                        child: Icon(
                                          FontAwesomeIcons.plus,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (_) => tabs[0]['add'],
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            expanded: ListView.builder(
                              itemCount: 3,
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                return ListTile(
                                  onTap: () {},
                                  title: Text('q'),
                                );
                              },
                            ),
                          ),
                          Divider(),
                          ExpandablePanel(
                            theme: ExpandableThemeData(
                                useInkWell: false,
                                headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                iconPlacement:
                                    ExpandablePanelIconPlacement.left),
                            header: Row(
                              children: <Widget>[
                                Text(
                                  'True/False Questions',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: ButtonTheme(
                                    height: 50,
                                    minWidth: 50,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      color: Colors.blue,
                                      child: Icon(
                                        FontAwesomeIcons.plus,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (_) => tabs[1]['add'],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            expanded: ListView.builder(
                              itemCount: 3,
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                return ListTile(
                                  onTap: () {},
                                  title: Text('q'),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
//                      ListView(
//                        children: <Widget>[
//                          for (int i = 0; i < 2; i++)
//                            Column(
//                              children: <Widget>[
//                                ListTile(
//                                  onTap: () {
//                                    showModalBottomSheet(
//                                        isScrollControlled: true,
//                                        context: context,
//                                        builder: (_) => Column(
//                                              children: <Widget>[
//                                                Spacer(
//                                                  flex: 1,
//                                                ),
//                                                Align(
//                                                  alignment:
//                                                      Alignment.centerLeft,
//                                                  child: Padding(
//                                                    padding:
//                                                        const EdgeInsets.only(
//                                                            left: 10),
//                                                    child: Text(
//                                                      'Edit Competator',
//                                                      style: TextStyle(
//                                                          fontSize: 25,
//                                                          fontWeight:
//                                                              FontWeight.w700),
//                                                    ),
//                                                  ),
//                                                ),
//                                                Spacer(
//                                                  flex: 1,
//                                                ),
//                                                Padding(
//                                                  padding:
//                                                      const EdgeInsets.all(8.0),
//                                                  child: TextField(
//                                                    maxLines: null,
//                                                    controller:
//                                                        TextEditingController(
//                                                            text: 'Cabury'),
//                                                  ),
//                                                ),
//                                                Spacer(
//                                                  flex: 3,
//                                                ),
//                                                Padding(
//                                                  padding:
//                                                      const EdgeInsets.only(
//                                                          top: 100),
//                                                  child: ButtonTheme(
//                                                    colorScheme:
//                                                        ColorScheme.dark(),
//                                                    height: 50,
//                                                    minWidth: 200,
//                                                    child: FlatButton(
//                                                        color: Colors.green,
//                                                        onPressed: () {},
//                                                        child: Text(
//                                                            'Submit update')),
//                                                  ),
//                                                ),
//                                                Padding(
//                                                  padding:
//                                                      const EdgeInsets.only(
//                                                          top: 20),
//                                                  child: ButtonTheme(
//                                                    colorScheme:
//                                                        ColorScheme.dark(),
//                                                    height: 50,
//                                                    minWidth: 200,
//                                                    child: FlatButton(
//                                                      color: Colors.red,
//                                                      onPressed: () {},
//                                                      child: Text('Deny'),
//                                                    ),
//                                                  ),
//                                                ),
//                                                Spacer(
//                                                  flex: 2,
//                                                ),
//                                              ],
//                                            ));
//                                  },
//                                  title: Text('name'),
//                                  trailing: Icon(Icons.arrow_forward_ios),
//                                ),
//                                Divider(
//                                  height: 2,
//                                  indent: 30,
//                                  endIndent: 30,
//                                )
//                              ],
//                            ),
//                        ],
//                      ),
                    ],
                  ),
                ),
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
