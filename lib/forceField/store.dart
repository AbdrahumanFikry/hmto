import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:senior/forceField/forceFieldNavigator.dart';
import 'package:senior/widgets/alertDialog.dart';

import '../models/dataForNewShop.dart';
import '../providers/fieldForceProvider.dart';
import '../sells/closeReason.dart';
import '../widgets/persent.dart';
import '../widgets/question.dart';
import '../widgets/trueAndFalse.dart';

class FieldForceStore extends StatefulWidget {
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
  final List<Competitors> competitors;
  final List<Question> trueAndFalse;
  final List<Question> longAnswerQuestion;
  final List<Question> optionQuestion;
  final List<Question> products;

  FieldForceStore({
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
    this.trueAndFalse,
    this.longAnswerQuestion,
    this.optionQuestion,
    this.products,
    this.competitors,
  });

  @override
  _FieldForceStoreState createState() => _FieldForceStoreState();
}

class _FieldForceStoreState extends State<FieldForceStore> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Map<String, double> competitorsData = {};

  // List questionsAnswer = new List();
  // List productsAnswer = new List();
  List<PercentChanger> competitorsPercents = [];
  bool _isLoading = false;

  List<File> images = new List<File>();
  File image;
  var currentLocation = Position();
  bool searching = false;

  Future<Position> _getLocation() async {
    try {
      setState(() {
        searching = true;
      });
      LocationPermission permission = await checkPermission();
      if (permission == LocationPermission.denied) {
        await requestPermission();
      }
      final geo = GeolocatorPlatform.instance;
      Position position = await geo.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print(
        'UserLocation => \nlat : ' +
            position.latitude.toString() +
            '\nlong : ' +
            position.longitude.toString(),
      );
      setState(() {
        searching = false;
      });
      return position;
    } catch (e) {
      setState(() {
        searching = false;
      });
      print('Geolocator Error : ' + e.toString());
      return Position();
    }
  }

  Future getImage() async {
    try {
      File holder = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 700,
        maxHeight: 512,
      );
      image = holder;
    } catch (error) {
      throw error;
    }
  }

  Future<void> finish() async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      setState(() {
        _isLoading = true;
      });
      try {
        if (images.length == 4) {
          currentLocation = await _getLocation();
          await Provider.of<FieldForceData>(context, listen: false).addNewVisit(
            id: widget.id,
            answers: json.encode({
              "data": Provider.of<FieldForceData>(context, listen: false)
                  .questionsAnswer
            }),
            image1: images[0] == null ? 'Nothing' : images[0],
            image2: images[1] == null ? 'Nothing' : images[1],
            image3: images[2] == null ? 'Nothing' : images[2],
            image4: images[3] == null ? 'Nothing' : images[3],
            lat: currentLocation.latitude,
            lang: currentLocation.longitude,
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => ForceFieldNavigator(),
              ),
              (Route<dynamic> route) => false);
          setState(() {
            _isLoading = false;
          });
        } else {
          GlobalAlertDialog.showErrorDialog(tr('errors.lessData'), context);
        }
      } catch (error) {
        GlobalAlertDialog.showErrorDialog(error.toString(), context);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    List<String> constImages = [
      widget.imageIn,
      widget.imageOut,
      widget.imageStoreAds,
      widget.imageStoreFront,
    ];
    widget.competitors.forEach((competitor) {
      int index = Provider.of<FieldForceData>(context, listen: false)
          .competitorsPercents
          .indexWhere(
            (item) => item.competitorId == competitor.competitorId,
          );
      competitorsData[competitor.name] = double.tryParse(
        Provider.of<FieldForceData>(context, listen: false)
            .competitorsPercents[index]
            .sallesRateStock,
      );
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      //------------------------ Slider ------------------------------
                      CarouselSlider(
                        scrollPhysics: BouncingScrollPhysics(),
                        height: 384 * screenSize.aspectRatio,
                        items: constImages.map((url) {
                          return Padding(
                            padding:
                                EdgeInsets.all(13 * screenSize.aspectRatio),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                          padding: EdgeInsets.symmetric(
                            vertical: 16 * screenSize.aspectRatio,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                widget.storeName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 46 * screenSize.aspectRatio,
                                ),
                              ),
                              RatingBarIndicator(
                                itemCount: 7,
                                itemSize: 50 * screenSize.aspectRatio,
                                rating: double.tryParse(widget.rate.toString()),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            images.length >= 4
                                ? SizedBox(
                                    width: 1.0,
                                  )
                                : Container(
                                    height: 90.0,
                                    width: 90.0,
                                    margin: EdgeInsets.symmetric(
                                      vertical: 5.0,
                                      horizontal: 5.0,
                                    ),
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(Icons.camera_alt),
                                        onPressed: () async {
                                          await getImage();
                                          setState(() {
                                            if (image != null) {
                                              images.add(image);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                            images == null
                                ? SizedBox()
                                : Container(
                                    height: 100,
                                    width: images.length >= 4
                                        ? MediaQuery.of(context).size.width - 35
                                        : MediaQuery.of(context).size.width -
                                            130,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: images.length,
                                      itemBuilder: (ctx, index) {
                                        return Container(
                                          height: 90.0,
                                          width: 90.0,
                                          margin: EdgeInsets.symmetric(
                                            vertical: 5.0,
                                            horizontal: 5.0,
                                          ),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: FileImage(
                                                images[index],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(
                                                  Icons.cancel,
                                                  size: 18,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    images
                                                        .remove(images[index]);
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: Colors.green,
                                size: 25,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              widget.landmark,
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                                SizedBox(
                                  width: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(widget.mobile),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.user),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(widget.customerName),
                                )
                              ],
                            ),
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
                                SizedBox(
                                  width: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('Store'),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.city),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    widget.landmark.split(',')[0] == null
                                        ? widget.landmark
                                        : widget.landmark.split(',')[0],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () => _showModalSheet(context),
                        child: Consumer<FieldForceData>(
                          builder: (ctx, data, child) {
                            widget.competitors.forEach((competitor) {
                              int index = data.competitorsPercents.indexWhere(
                                (item) =>
                                    item.competitorId ==
                                    competitor.competitorId,
                              );
                              competitorsData[competitor.name] =
                                  double.tryParse(
                                data.competitorsPercents[index].sallesRateStock,
                              );
                            });
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: data.competitorsPercents
                                      .map(
                                        (item) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3.0,
                                          ),
                                          child: Text(item.sallesRateMoney),
                                        ),
                                      )
                                      .toList(),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                PieChart(
                                  colorList: [
                                    Colors.purple,
                                    Colors.red,
                                    Colors.orange,
                                    Colors.black,
                                    Colors.green,
                                    Colors.pink,
                                    Colors.teal,
                                    Colors.blueGrey,
                                    Colors.grey,
                                    Colors.yellow,
                                    Colors.cyan,
                                    Colors.brown,
                                  ],
                                  legendPosition: LegendPosition.left,
                                  chartRadius: 230 * screenSize.aspectRatio,
                                  legendStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                  chartValueStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  dataMap: competitorsData,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * screenSize.aspectRatio,
                          vertical: 16 * screenSize.aspectRatio,
                        ),
                        child: ExpandablePanel(
                          theme: ExpandableThemeData(
                            animationDuration: Duration(milliseconds: 200),
                          ),
                          header: Text(
                            tr('store.products'),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 33 * screenSize.aspectRatio,
                            ),
                          ),
                          expanded: Column(
                            children: <Widget>[
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.products?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return TrueAndFalse(
                                      index: index + 1,
                                      question: widget.products[index].name,
                                      qId: widget.products[index].id,
                                      options: ['صح', 'خطأ'],
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * screenSize.aspectRatio,
                          vertical: 16 * screenSize.aspectRatio,
                        ),
                        child: ExpandablePanel(
                          theme: ExpandableThemeData(
                            animationDuration: Duration(milliseconds: 200),
                          ),
                          header: Text(
                            tr('new_store.optionQ'),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 33 * screenSize.aspectRatio,
                            ),
                          ),
                          expanded: Column(
                            children: <Widget>[
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.optionQuestion?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return TrueAndFalse(
                                      index: index + 1,
                                      question:
                                          widget.optionQuestion[index].name,
                                      qId: widget.optionQuestion[index].id,
                                      options:
                                          widget.optionQuestion[index].options,
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * screenSize.aspectRatio,
                          vertical: 16 * screenSize.aspectRatio,
                        ),
                        child: ExpandablePanel(
                          theme: ExpandableThemeData(
                            animationDuration: Duration(milliseconds: 200),
                          ),
                          header: Text(
                            tr('new_store.t_f_questions'),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 33 * screenSize.aspectRatio,
                            ),
                          ),
                          expanded: Column(
                            children: <Widget>[
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.trueAndFalse?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return TrueAndFalse(
                                      index: index + 1,
                                      question: widget.trueAndFalse[index].name,
                                      qId: widget.trueAndFalse[index].id,
                                      options: ['صح', 'خطأ'],
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Divider(),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * screenSize.aspectRatio,
                          vertical: 16 * screenSize.aspectRatio,
                        ),
                        child: ExpandablePanel(
                          theme: ExpandableThemeData(
                            animationDuration: Duration(milliseconds: 200),
                          ),
                          header: Text(
                            tr('new_store.long_answer_questions'),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 33 * screenSize.aspectRatio,
                            ),
                          ),
                          expanded: Column(
                            children: <Widget>[
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    widget.longAnswerQuestion?.length ?? 0,
                                itemBuilder: (ctx, index) {
                                  return QuestionHandler(
                                    index: index + 1,
                                    question:
                                        widget.longAnswerQuestion[index].name,
                                    qId: widget.longAnswerQuestion[index].id,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: FlatButton(
                                onPressed: finish,
                                child: Text(
                                  tr('store.submit'),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => CloseReason(
                                        id: widget.id,
                                        isSells: false,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'اغلاق',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void percentChanger(BuildContext context, int id) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return PercentChanger(
          initValue: 0,
          id: id,
        );
      },
    );
  }

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
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
              Container(
                height: 280,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: widget.competitors.length,
                  itemBuilder: (ctx, index) {
                    return RaisedButton(
                      onPressed: () => percentChanger(
                          context, widget.competitors[index].competitorId),
                      color: Colors.green,
                      child: Text(
                        widget.competitors[index].name,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
