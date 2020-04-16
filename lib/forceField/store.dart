import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:senior/widgets/alertDialog.dart';
import '../widgets/trueAndFalse.dart';
import '../widgets/persent.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/dataForNewShop.dart';
import '../models/answers.dart';
import '../widgets/question.dart';
import 'dart:convert';

class Store extends StatefulWidget {
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
  final List<Question> products;

  Store({
    this.id,
    this.storeName,
    this.customerName,
    this.mobile,
    this.landmark,
    this.rate,
    this.imageIn,
    this.imageOut,
    this.imageStoreAds,
    this.imageStoreFront,
    this.trueAndFalse,
    this.longAnswerQuestion,
    this.products,
    this.competitors,
  });

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Map<String, double> competitorsData = {};
  List questionsAnswer = new List();
  List productsAnswer = new List();
  List<PercentChanger> competitorsPercents = [];
  bool _isLoading = false;

  Future<void> finish() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      setState(() {
        _isLoading = true;
      });
      try {
        // TODO -----
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
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
    List<String> images = [
      widget.imageIn,
      widget.imageOut,
      widget.imageStoreAds,
      widget.imageStoreFront,
    ];
    widget.competitors.forEach((competitor) {
      competitorsData[competitor.name] = 10.0;
//      competitorsPercents.add(
//        PercentChanger(
//          initValue: 0.0,
//        ),
//      );
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
                        items: images.map((url) {
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
                      PieChart(
                        colorList: [
                          Colors.purple,
                          Colors.blue,
                          Colors.orange,
                        ],
                        legendPosition: LegendPosition.left,
                        chartRadius: 250 * screenSize.aspectRatio,
                        legendStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                        chartValueStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        dataMap: competitorsData,
                      ),
//            Divider(),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                    'hmto',
//                    style: TextStyle(
//                      fontSize: 21.0,
//                      color: Colors.black,
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ),
//                  SizedBox(
//                    width: 20.0,
//                  ),
//                  Container(
//                    width: MediaQuery.of(context).size.width * 0.5,
//                    child: TextField(
//                      decoration: InputDecoration(
//                        contentPadding: EdgeInsets.only(
//                          right: 100.0,
//                        ),
//                        border: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(
//                            5.0,
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            ListView.builder(
//              itemCount: 3,
//              shrinkWrap: true,
//              physics: NeverScrollableScrollPhysics(),
//              itemBuilder: (ctx, index) {
//                return Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text(
//                        'others',
//                        style: TextStyle(
//                          fontSize: 21.0,
//                          color: Colors.black,
//                          fontWeight: FontWeight.bold,
//                        ),
//                      ),
//                      SizedBox(
//                        width: 20.0,
//                      ),
//                      Container(
//                        width: MediaQuery.of(context).size.width * 0.5,
//                        child: TextField(
//                          decoration: InputDecoration(
//                            contentPadding: EdgeInsets.all(
//                              16.0,
//                            ),
//                            border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(
//                                5.0,
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                );
//              },
//            ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20 * screenSize.aspectRatio,
                            vertical: 16 * screenSize.aspectRatio),
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
                                  itemCount: widget.products.length,
                                  itemBuilder: (context, index) {
                                    String answer = 'No answer yet';

                                    void onSavedTrue() {
                                      setState(() {
                                        answer = 'True';
                                      });
                                      productsAnswer.add(
                                        Answer(
                                          questionId: widget.products[index].id,
                                          answer: 'True',
                                        ),
                                      );
                                    }

                                    void onSavedFalse() {
                                      setState(() {
                                        answer = 'False';
                                      });
                                      productsAnswer.add(
                                        Answer(
                                          questionId: widget.products[index].id,
                                          answer: 'False',
                                        ),
                                      );
                                    }

                                    return TrueAndFalse(
                                      index: index + 1,
                                      question: widget.products[index].name,
                                      onSavedTrue: onSavedTrue,
                                      onSavedFalse: onSavedFalse,
                                      answer: answer,
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
                            vertical: 16 * screenSize.aspectRatio),
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
                                  itemCount: widget.trueAndFalse.length,
                                  itemBuilder: (context, index) {
                                    String answer = 'No answer yet';

                                    void onSavedTrue() {
                                      setState(() {
                                        answer = 'True';
                                      });
                                      questionsAnswer.add(
                                        Answer(
                                          questionId: widget.products[index].id,
                                          answer: 'True',
                                        ),
                                      );
                                    }

                                    void onSavedFalse() {
                                      setState(() {
                                        answer = 'False';
                                      });
                                      questionsAnswer.add(
                                        Answer(
                                          questionId: widget.products[index].id,
                                          answer: 'False',
                                        ),
                                      );
                                    }

                                    return TrueAndFalse(
                                      index: index + 1,
                                      question: widget.trueAndFalse[index].name,
                                      onSavedTrue: onSavedTrue,
                                      onSavedFalse: onSavedFalse,
                                      answer: answer,
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20 * screenSize.aspectRatio,
                            vertical: 16 * screenSize.aspectRatio),
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
                                itemCount: widget.longAnswerQuestion.length,
                                itemBuilder: (ctx, index) {
                                  void onSaved(value) {
                                    questionsAnswer.add(
                                      Answer(
                                        questionId:
                                            widget.longAnswerQuestion[index].id,
                                        answer: value,
                                      ),
                                    );
                                  }

                                  return QuestionHandler(
                                    index: index + 1,
                                    question:
                                        widget.longAnswerQuestion[index].name,
                                    onSaved: onSaved,
                                  );
                                },
                              ),
                            ],
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
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

//  void percentChanger(BuildContext context, int index) {
//    showModalBottomSheet(
//      context: context,
//      builder: (builder) {
//        return competitors[index];
//      },
//    );
//  }

//  void _showModalSheet(BuildContext context) {
//    showModalBottomSheet(
//      context: context,
//      builder: (builder) {
//        return Container(
//          height: 400,
//          child:  Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              //crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: <Widget>[
//                SizedBox(height: 20.0,),
//                Text(
//                  'Change percent',
//                  style: TextStyle(
//                    fontSize: 20.0,
//                    fontWeight: FontWeight.bold,
//                    color: Colors.blue,
//                  ),
//                  textAlign: TextAlign.center,
//                ),
//                Spacer(),
//                Container(
//                  height: 280,
//                  width: double.infinity,
//                  child: ListView.builder(
//                    itemCount: competitorsName.length,
//                    itemBuilder: (ctx, index) {
//                      return RaisedButton(
//                        onPressed: () => percentChanger(context, index),
//                        color: Colors.green,
//                        child: Text(
//                          competitorsName[index],
//                          style: TextStyle(
//                            fontSize: 20.0,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                      );
//                    },
//                  ),
//                ),
//              ],
//            ),
//
////          padding: EdgeInsets.all(40.0),
//        );
//      },
//    );
//  }
}
