import 'dart:convert';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:senior/models/answers.dart';
import 'package:senior/models/dataForNewShop.dart';
import 'package:senior/widgets/alertDialog.dart';
import 'package:senior/widgets/errorWidget.dart';
import 'package:senior/widgets/inputwidget.dart';
import 'package:senior/widgets/question.dart';
import 'package:senior/widgets/trueAndFalse.dart';
import 'dart:io';
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import '../providers/fieldForceProvider.dart';
import '../widgets/persent.dart';

//import 'package:image/image.dart' as Im;
//import 'package:path_provider/path_provider.dart';
//import 'dart:math' as Math;

class AdsAddStore extends StatefulWidget {
  final double lat;
  final double long;
  final String address;

  AdsAddStore({
    this.lat,
    this.long,
    this.address,
  });

  @override
  _AdsAddStoreState createState() => _AdsAddStoreState();
}

class _AdsAddStoreState extends State<AdsAddStore> {
  int competitorLength = 0;
  File image;
  bool _isLoading = false;
  List<File> images = new List<File>();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String shopName,
      customerName,
      customerPhone,
      sellsName,
      sellsPhone,
      landmark,
      position,
      answers;
  double rate;
  List questionsAnswer = new List();
  List<Competitors> competitors = new List<Competitors>();
  Map<String, double> competitorsData = {};

  Future getImage() async {
    try {
      File holder = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 700,
        maxHeight: 512,
      );
      image = holder;
//    var h = await holder.readAsBytes();
//    print('Before:::::::' + h.length.toString());
//    final tempDir = await getTemporaryDirectory();
//    final path = tempDir.path;
//    int rand = new Math.Random().nextInt(10000);
//
//    Im.Image imageHandler = Im.decodeImage(holder.readAsBytesSync());
//    image = new File('$path/img_$rand.jpg')
//      ..writeAsBytesSync(Im.encodeJpg(imageHandler, quality: 85));
//    var enc = await image.readAsBytes();
//    print('After::::::::' + enc.length.toString());
    } catch (error) {
      throw error;
    }
  }

  Future<void> finish() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      if (images.length < 4 ||
          rate == null ||
          shopName == null ||
          customerName == null ||
          customerPhone == null ||
          sellsName == null ||
          sellsPhone == null ||
          widget.long == null ||
          widget.lat == null) {
        GlobalAlertDialog.showErrorDialog(tr('errors.lessData'), context);
      } else {
        setState(() {
          _isLoading = true;
        });
        try {
          await Provider.of<FieldForceData>(context, listen: false).addNewShop(
            shopName: shopName == null ? 'no data' : shopName,
            customerName: customerName == null ? 'no data' : customerName,
            customerPhone: customerPhone == null ? 'no data' : customerPhone,
            sellsName: sellsName == null ? 'no data' : sellsName,
            sellsPhone: sellsPhone == null ? 'no data' : sellsPhone,
            rate: rate == null ? 0.0 : rate,
            image1: images[0] == null ? 'Nothing' : images[0],
            image2: images[1] == null ? 'Nothing' : images[1],
            image3: images[2] == null ? 'Nothing' : images[2],
            image4: images[3] == null ? 'Nothing' : images[3],
            answers: json.encode({"data": questionsAnswer}) == null
                ? '{"data":[]}'
                : json.encode({"data": questionsAnswer}),
            lat: widget.lat.toString() == null
                ? '31.000'
                : widget.lat.toString(),
            long: widget.long.toString() == null
                ? '31.00'
                : widget.long.toString(),
            landmark: widget.address == null ? 'no data' : widget.address,
            position: widget.address == null ? 'no data' : widget.address,
          );
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
  }

  String validator(value) {
    if (value == null) {
      return 'this field is requred!';
    }
    return null;
  }

  @override
  void initState() {
    Provider.of<FieldForceData>(context, listen: false).dataForNewShop = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    competitors =
        Provider.of<FieldForceData>(context, listen: false).competitors;
    if (Provider.of<FieldForceData>(context, listen: false).dataForNewShop !=
        null) {
      competitors.forEach((competitor) {
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
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('new_store.title'),
        ),
        actions: <Widget>[
          Provider.of<FieldForceData>(context, listen: false).dataForNewShop !=
                      null ||
                  _isLoading == false
              ? IconButton(
                  icon: Icon(Icons.done),
                  onPressed: finish,
                )
              : SizedBox()
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    Provider.of<FieldForceData>(context).progress == '100'
                        ? 'Please wait ... '
                        : Provider.of<FieldForceData>(context).progress + ' %',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : FutureBuilder(
              future: Provider.of<FieldForceData>(context, listen: false)
                          .dataForNewShop ==
                      null
                  ? Provider.of<FieldForceData>(context, listen: false)
                      .fetchQuestions()
                  : null,
              builder: (context, dataSnapShot) {
                if (dataSnapShot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapShot.hasError) {
                    return ErrorHandler(
                      toDO: () {
                        setState(() {
                          Provider.of<FieldForceData>(context, listen: false)
                              .dataForNewShop = null;
                        });
                      },
                    );
                  } else {
                    return Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                tr('new_store.info'),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              InputWidget(
                                labelText: tr('new_store.info_details.name'),
                                onSaved: (value) {
                                  shopName = value;
                                },
                                validator: validator,
                              ),
                              InputWidget(
                                labelText: tr('new_store.info_details.c_name'),
                                onSaved: (value) {
                                  customerName = value;
                                },
                                validator: validator,
                              ),
                              InputWidget(
                                labelText: tr('new_store.info_details.c_phone'),
                                onSaved: (value) {
                                  customerPhone = value;
                                },
                                validator: validator,
                              ),
                              InputWidget(
                                labelText: tr('new_store.info_details.s_name'),
                                onSaved: (value) {
                                  sellsName = value;
                                },
                                validator: validator,
                              ),
                              InputWidget(
                                labelText: tr('new_store.info_details.s_phone'),
                                onSaved: (value) {
                                  sellsPhone = value;
                                },
                                validator: validator,
                              ),
                              Text(
                                tr('new_store.images'),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
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
                                    Spacer(),
                                    images == null
                                        ? SizedBox()
                                        : Container(
                                            height: 100,
                                            width: images.length >= 4
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    35
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width -
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
                                                          images[index]),
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
                                                            images.remove(
                                                                images[index]);
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
                              images.length == 4
                                  ? SizedBox(
                                      height: 0.5,
                                    )
                                  : Text(
                                      tr('extra.images'),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.red,
                                      ),
                                    ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                tr('new_store.rating'),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Center(
                                child: RatingBar(
                                  glowColor: Colors.yellow,
                                  allowHalfRating: true,
                                  initialRating: 0.0,
                                  onRatingUpdate: (double value) {
                                    setState(() {
                                      rate = value;
                                    });
                                  },
                                  itemCount: 7,
                                  itemSize: 30,
                                  itemBuilder: (_, int index) => Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                              Divider(),
                              GestureDetector(
                                onTap: () => _showModalSheet(context),
                                child: Consumer<FieldForceData>(
                                  builder: (ctx, data, child) {
                                    data.competitors.forEach((competitor) {
                                      int index =
                                          data.competitorsPercents.indexWhere(
                                        (item) =>
                                            item.competitorId ==
                                            competitor.competitorId,
                                      );
                                      competitorsData[competitor.name] =
                                          double.tryParse(
                                        data.competitorsPercents[index]
                                            .sallesRateStock,
                                      );
                                    });
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          children: data.competitorsPercents
                                              .map(
                                                (item) => Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 3.0,
                                                  ),
                                                  child: Text(
                                                      item.sallesRateMoney),
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
                                          chartRadius:
                                              230 * screenSize.aspectRatio,
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
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  tr('new_store.t_f_questions'),
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Consumer<FieldForceData>(
                                builder: (context, data, child) =>
                                    ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: data.trueAndFalse.length,
                                  itemBuilder: (ctx, index) {
                                    String answer = 'No answer yet';

                                    void onSavedTrue() {
                                      setState(() {
                                        answer = 'True';
                                      });
                                      questionsAnswer.add(
                                        Answer(
                                          questionId:
                                              data.trueAndFalse[index].id,
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
                                          questionId:
                                              data.trueAndFalse[index].id,
                                          answer: 'False',
                                        ),
                                      );
                                    }

                                    return TrueAndFalse(
                                      index: index + 1,
                                      question: data.trueAndFalse[index].name,
                                      onSavedTrue: onSavedTrue,
                                      onSavedFalse: onSavedFalse,
                                      answer: answer,
                                    );
                                  },
                                ),
                              ),
                              Text(
                                tr('new_store.long_answer_questions'),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Consumer<FieldForceData>(
                                builder: (context, data, child) =>
                                    ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: data.longAnswerQuestion.length,
                                  itemBuilder: (ctx, index) {
                                    void onSaved(value) {
                                      questionsAnswer.add(
                                        Answer(
                                          questionId:
                                              data.longAnswerQuestion[index].id,
                                          answer: value,
                                        ),
                                      );
                                    }

                                    return QuestionHandler(
                                      index: index + 1,
                                      question:
                                          data.longAnswerQuestion[index].name,
                                      onSaved: onSaved,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }
              }),
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
    List<Competitors> competitorsItems =
        Provider.of<FieldForceData>(context, listen: false).competitors;
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
                  itemCount: competitorsItems.length,
                  itemBuilder: (ctx, index) {
                    return RaisedButton(
                      onPressed: () => percentChanger(
                          context, competitorsItems[index].competitorId),
                      color: Colors.green,
                      child: Text(
                        competitorsItems[index].name,
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
