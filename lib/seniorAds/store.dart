import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_chart/pie_chart.dart';

class Store extends StatelessWidget {
  //--------------------------------------------------images------------------------------------------//
  var url =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQg2kWTuFxohnKTgpKwaQIav4P7pZDbPD-dydM2QdObm93Ia18-';
  List urls = [
    'https://assets.website-files.com/5c99f1fbf7d06d48eed8af7b/5cdebf7db9e0bc1fc589f277_eco01.jpg',
    'https://www.dw.com/image/37077830_303.jpg',
    'https://madosan.com.tr/assets/uploads/galeri/super-market-hiper-market/6b6ac887-23e6-49ac-b44d-e3d8ff6b52b8-jpg_1560158960.jpg'
  ];
  //------------------------------------------------------------------------------------------------------------------------------------

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
              items: [
                for (var x in urls)
                  Padding(
                      padding: EdgeInsets.all(13 * screenSize.aspectRatio),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: CachedNetworkImage(
                          imageUrl: x,
                          height: 0.3 * screenSize.height,
                          width: screenSize.width,
                          fit: BoxFit.cover,
                        ),
                      ))
              ],
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
                        itemCount: 5,
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
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.dollarSign),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('Cash'),
                      )
                    ],
                  ),

                ],
              ),
            ),
            //------------------------------------descreption----------------------
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 33 * screenSize.aspectRatio,
                  vertical: 16 * screenSize.aspectRatio),
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                    animationDuration: Duration(milliseconds: 200)),
                header: Text(
                  'Description',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 33 * screenSize.aspectRatio),
                ),
                expanded: Text(
                    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, s, sometimes by accident, sometimes on purpose (injected humour and the like).'),
              ),
            ),
            Divider(),
            //---------------------------------------------------------------------------
            //------------------------------------chart----------------------------------//
            PieChart(
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
            Divider(),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 33 * screenSize.aspectRatio),
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                    animationDuration: Duration(milliseconds: 200)),
                header: Text(
                  'True / False info',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30 * screenSize.aspectRatio),
                ),
                expanded: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('is he good ?'),
                      trailing: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    ),
                    ListTile(
                      title: Text('is he bad ?'),
                      trailing: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 0.03 * screenSize.height,
            ),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 33 * screenSize.aspectRatio),
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                    animationDuration: Duration(milliseconds: 200)),
                header: Text(
                  'Long answers info',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30 * screenSize.aspectRatio),
                ),
                expanded: Padding(
                  padding: EdgeInsets.only(left: 33 * screenSize.aspectRatio),
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Question 1',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30 * screenSize.aspectRatio),
                          ),
                          Text(
                              'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, s, sometimes by accident, sometimes on purpose (injected humour and the like).'),
                          Divider()
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Question 2',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30 * screenSize.aspectRatio),
                          ),
                          Text(
                              'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, s, sometimes by accident, sometimes on purpose (injected humour and the like).'),
                          Divider()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
