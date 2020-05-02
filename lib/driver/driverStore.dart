import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior/sells/cartScreen.dart';
import 'package:easy_localization/easy_localization.dart';

class DriverStore extends StatelessWidget {
  var url =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQg2kWTuFxohnKTgpKwaQIav4P7pZDbPD-dydM2QdObm93Ia18-';
  List urls = [
    'https://assets.website-files.com/5c99f1fbf7d06d48eed8af7b/5cdebf7db9e0bc1fc589f277_eco01.jpg',
    'https://www.dw.com/image/37077830_303.jpg',
    'https://madosan.com.tr/assets/uploads/galeri/super-market-hiper-market/6b6ac887-23e6-49ac-b44d-e3d8ff6b52b8-jpg_1560158960.jpg'
  ];

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
              ),
            ),
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
              ),
            ),
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                tr('driver_profile.bills'),
                style: TextStyle(color: Colors.blue, fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      subtitle: Text('Has created count market'),
                      title: Text('info'),
                      trailing: Text(
                        tr('field_force_profile.status'),
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CartScreen(),
                          ),
                        );
                      },
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
          ],
        ),
      ),
    );
  }
}
