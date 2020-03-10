import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import '../widgets/trueAndFalse.dart';

class Store extends StatelessWidget {
  var url =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQg2kWTuFxohnKTgpKwaQIav4P7pZDbPD-dydM2QdObm93Ia18-';
  List urls = [
    'https://assets.website-files.com/5c99f1fbf7d06d48eed8af7b/5cdebf7db9e0bc1fc589f277_eco01.jpg',
    'https://www.dw.com/image/37077830_303.jpg',
    'https://madosan.com.tr/assets/uploads/galeri/super-market-hiper-market/6b6ac887-23e6-49ac-b44d-e3d8ff6b52b8-jpg_1560158960.jpg'
  ];

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Change percent',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  RaisedButton(
                    onPressed: () {},
                    color: Colors.green,
                    child: Text(
                      'Cabury',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: Colors.green,
                    child: Text(
                      'Our Products',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: Colors.green,
                    child: Text(
                      'Shamaadn',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            padding: EdgeInsets.all(40.0),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            //----------------------------------slider-------------------------------
            CarouselSlider(
              scrollPhysics: BouncingScrollPhysics(),
              height: 384 * screenSize.aspectRatio,
              items: urls.map((url) {
                return Padding(
                  padding: EdgeInsets.all(13 * screenSize.aspectRatio),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      height: 0.3 * screenSize.height,
                      width: screenSize.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
              enlargeCenterPage: true,
            ),
            //--------------------------------------------------------------------------
            Center(
                child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 16 * screenSize.aspectRatio),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Bobo Market',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 46 * screenSize.aspectRatio),
                  ),
                  RatingBarIndicator(
                    itemCount: 7,
                    itemSize: 50 * screenSize.aspectRatio,
                    rating: 4.5,
                    itemBuilder: (BuildContext context, int index) {
                      return Icon(
                        Icons.star,
                        color: Colors.orange,
                      );
                    },
                  )
                ],
              ),
            )),
            Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  color: Colors.green,
                  size: 25,
                ),
                Text('el hadded St in front of This Long Name'),
              ],
            )),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.phone),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('01201684644'),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.user),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Mohamed'),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.city),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Cairo'),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.store),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Mini market'),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            //------------------------------------chart----------------------------------//
            GestureDetector(
              onTap: () {
                _showModalSheet(context);
              },
              child: PieChart(
                colorList: [
                  Colors.purple,
                  Colors.blue,
                  Colors.orange,
                ],
                legendPosition: LegendPosition.left,
                chartRadius: 250 * screenSize.aspectRatio,
                legendStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                chartValueStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                dataMap: {
                  'Cabury': 50,
                  'Our product': 20,
                  'Shamaadn': 30,
                },
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'hmto',
                    style: TextStyle(
                      fontSize: 21.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          right: 100.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            5.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'others',
                    style: TextStyle(
                      fontSize: 21.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(
                          16.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            5.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20 * screenSize.aspectRatio,
                  vertical: 16 * screenSize.aspectRatio),
              child: ExpandablePanel(
                  theme: ExpandableThemeData(
                      animationDuration: Duration(milliseconds: 200)),
                  header: Text(
                    'Products',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 33 * screenSize.aspectRatio),
                  ),
                  expanded: Column(
                    children: <Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return TrueAndFalse(
                              index: index + 1,
                              question: 'Molto',
                            );
                          }),
                    ],
                  )),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20 * screenSize.aspectRatio,
                  vertical: 16 * screenSize.aspectRatio),
              child: ExpandablePanel(
                  theme: ExpandableThemeData(
                      animationDuration: Duration(milliseconds: 200)),
                  header: Text(
                    'Qustions',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 33 * screenSize.aspectRatio),
                  ),
                  expanded: Column(
                    children: <Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return TrueAndFalse(
                              index: index + 1,
                              question: 'do you have question',
                            );
                          }),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: "Add Comment",
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                  contentPadding: EdgeInsets.all(
                    16.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      5.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: FlatButton(
                  onPressed: () {
                    //todo------
                  },
                  child: Text(
                    'submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
