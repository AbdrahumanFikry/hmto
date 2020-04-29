import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senior/widgets/properties.dart';

class SellsStore extends StatelessWidget {
  final int id;
  final String storeName;
  final String customerName;
  final String mobile;
  final String landmark;
  final int rate;
  final String imageIn;
  final String imageOut;
  final String imageStoreAds;
  final String imageStoreFront;

  SellsStore({
    this.id,
    this.storeName = 'NULL',
    this.customerName = 'NULL',
    this.mobile = 'NULL',
    this.landmark = 'NULL',
    this.rate = 0,
    this.imageIn = 'NULL',
    this.imageOut = 'NULL',
    this.imageStoreAds = 'NULL',
    this.imageStoreFront = 'NULL',
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    List<String> images = [
      imageIn,
      imageOut,
      imageStoreAds,
      imageStoreFront,
    ];
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            CarouselSlider(
              scrollPhysics: BouncingScrollPhysics(),
              height: 384 * screenSize.aspectRatio,
              items: images.map((image) {
                return Padding(
                  padding: EdgeInsets.all(13 * screenSize.aspectRatio),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      height: 0.3 * screenSize.height,
                      width: screenSize.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
              enlargeCenterPage: true,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                storeName,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 33 * screenSize.aspectRatio,
                vertical: 16 * screenSize.aspectRatio,
              ),
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                  animationDuration: Duration(
                    milliseconds: 200,
                  ),
                ),
                header: Text(
                  tr('sells_store.cash'),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                    fontSize: 33 * screenSize.aspectRatio,
                  ),
                ),
                expanded: Properties(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 33 * screenSize.aspectRatio,
                vertical: 16 * screenSize.aspectRatio,
              ),
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                  animationDuration: Duration(
                    milliseconds: 200,
                  ),
                ),
                header: Text(
                  tr('sells_store.debit'),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                    fontSize: 33 * screenSize.aspectRatio,
                  ),
                ),
                expanded: Properties(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 33 * screenSize.aspectRatio,
                vertical: 16 * screenSize.aspectRatio,
              ),
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                  animationDuration: Duration(
                    milliseconds: 200,
                  ),
                ),
                header: Text(
                  tr('sells_store.return'),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                    fontSize: 33 * screenSize.aspectRatio,
                  ),
                ),
                expanded: Properties(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 33 * screenSize.aspectRatio,
                vertical: 16 * screenSize.aspectRatio,
              ),
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                  animationDuration: Duration(
                    milliseconds: 200,
                  ),
                ),
                header: Text(
                  tr('sells_store.summary'),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                    fontSize: 33 * screenSize.aspectRatio,
                  ),
                ),
                expanded: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              tr('sells_store.summary_details.old'),
                              style: TextStyle(
                                fontSize: 21.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
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
                          Expanded(
                            child: Text(
                              tr('sells_store.summary_details.paid'),
                              style: TextStyle(
                                fontSize: 21.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
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
                          Expanded(
                            child: Text(
                              tr('sells_store.summary_details.rest'),
                              style: TextStyle(
                                fontSize: 21.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
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
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            //todo----
                          },
                          child: Text(
                            tr('sells_store.done'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
