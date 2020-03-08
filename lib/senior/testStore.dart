import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/testStoreWidget.dart';

class TestStore extends StatefulWidget {
  @override
  _TestStoreState createState() => _TestStoreState();
}

class _TestStoreState extends State<TestStore> {
  var url =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQg2kWTuFxohnKTgpKwaQIav4P7pZDbPD-dydM2QdObm93Ia18-';
  List urls = [
    'https://assets.website-files.com/5c99f1fbf7d06d48eed8af7b/5cdebf7db9e0bc1fc589f277_eco01.jpg',
    'https://www.dw.com/image/37077830_303.jpg',
    'https://madosan.com.tr/assets/uploads/galeri/super-market-hiper-market/6b6ac887-23e6-49ac-b44d-e3d8ff6b52b8-jpg_1560158960.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            SizedBox(height: 20.0,),
            CarouselSlider(
              scrollPhysics: BouncingScrollPhysics(),
              height: 384 * screenSize.aspectRatio,
              items:
              urls.map((url) {
                return
                  Padding(
                    padding: EdgeInsets.all(13 * screenSize.aspectRatio),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: CachedNetworkImage(
                        imageUrl: url,
                        height: 0.3 * screenSize.height,
                        width: screenSize.width,
                        fit: BoxFit.cover,
                      ),
                    ),);
              }).toList(),
              enlargeCenterPage: true,
            ),
            SizedBox(height: 20,),
            Center(
              child: Text('Test Store',style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 33 * screenSize.aspectRatio,
                  vertical: 16 * screenSize.aspectRatio),
              child: ExpandablePanel(
                theme: ExpandableThemeData(
                    animationDuration: Duration(milliseconds: 200)),
                header: Text(
                  'Some Categories',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                      fontSize: 33 * screenSize.aspectRatio),
                ),
                expanded: Column(
                  children: <Widget>[
                    ListView.builder(
                shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                        itemBuilder: (context,index){
                        return TestStoreWidget();
              }
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Total',style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),),
                          Text('2600 EGP',style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('prise',style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),),
                          Text('5000 EGP',style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),),
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
                        child: FlatButton(onPressed: (){
                          //todo----
                        }, child: Text('Print',style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),)
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
