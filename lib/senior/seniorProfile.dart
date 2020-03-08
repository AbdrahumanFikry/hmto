import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SeniorProfile extends StatefulWidget {
  @override
  _SeniorProfileState createState() => _SeniorProfileState();
}

class _SeniorProfileState extends State<SeniorProfile>
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
                    text: 'ads',
                  ),
                  Tab(
                    text: 'Questions',
                  ),
                  Tab(
                    text: 'Competators',
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
                      ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                subtitle: Text('Has created 50 market'),
                                title: Text('Monir Monir'),
                                leading: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        'https://specials-images.forbesimg.com/imageserve/5d2893a234a5c400084b2955/1920x0.jpg?cropX1=29&cropX2=569&cropY1=20&cropY2=560',
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
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
                      ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return Align(
                            alignment: Alignment.center,
                            child: Card(
                              elevation: 1,
                              margin: EdgeInsets.all(12),
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            '12/10/2019 at 5:00',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w100),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (_) => Column(
                                            children: <Widget>[
                                              Spacer(
                                                flex: 1,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    'Edit Competator',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                              Spacer(
                                                flex: 1,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  maxLines: null,
                                                  controller:
                                                      TextEditingController(
                                                          text: 'Cabury'),
                                                ),
                                              ),
                                              Spacer(
                                                flex: 3,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 100),
                                                child: ButtonTheme(
                                                  colorScheme:
                                                      ColorScheme.dark(),
                                                  height: 50,
                                                  minWidth: 200,
                                                  child: FlatButton(
                                                      color: Colors.green,
                                                      onPressed: () {},
                                                      child: Text(
                                                          'Submit update')),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: ButtonTheme(
                                                  colorScheme:
                                                      ColorScheme.dark(),
                                                  height: 50,
                                                  minWidth: 200,
                                                  child: FlatButton(
                                                      color: Colors.red,
                                                      onPressed: () {},
                                                      child: Text('Deny')),
                                                ),
                                              ),
                                              Spacer(
                                                flex: 2,
                                              ),
                                            ],
                                          ));
                                },
                                subtitle: Text('12/10/2005 at 5:00'),
                                title: Text('Cabury'),
                              ),
                              Divider(
                                height: 2,
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 50.0,
                    ),
                    color: Colors.green,
                    child: Text(
                      'Add Ads',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 50.0,
                    ),
                    color: Colors.green,
                    child: Text(
                      'Add Question',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 50.0,
                    ),
                    color: Colors.green,
                    child: Text(
                      'Add Comptator',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Icon(
            Icons.add,
            size: 20.0,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
