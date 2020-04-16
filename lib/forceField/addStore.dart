import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:senior/models/answers.dart';
import 'package:senior/widgets/alertDialog.dart';
import 'package:senior/widgets/inputwidget.dart';
import 'package:senior/widgets/question.dart';
import 'package:senior/widgets/trueAndFalse.dart';
import 'dart:io';
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import '../providers/fieldForceProvider.dart';
import '../models/competitorPercent.dart';

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
  double rate, lat, long;
  List questionsAnswer = new List();
  List competitorData = new List();

  Future getImage() async {
    File holder = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 512, maxWidth: 512);
    image = holder;
  }

  Future<void> finish() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      if (images.length < 4) {
        GlobalAlertDialog.showErrorDialog(tr('extra.images'), context);
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
            rate: rate == null ? '5.0' : rate,
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
            competitorsData: json.encode({"data": competitorData}) == null
                ? '{"data":[]}'
                : json.encode({"data": competitorData}),
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tr('new_store.title'),
          ),
          actions: <Widget>[
            Provider.of<FieldForceData>(context, listen: false)
                        .dataForNewShop !=
                    null
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
                          ? 'Finishing ... '
                          : Provider.of<FieldForceData>(context).progress +
                              ' %',
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
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              tr('extra.check'),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            RaisedButton(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10.0,
                              ),
                              child: Text(
                                tr('extra.tryAgain'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                              color: Colors.green,
                              onPressed: () {
                                setState(() {
                                  Provider.of<FieldForceData>(context,
                                          listen: false)
                                      .dataForNewShop = null;
                                });
                              },
                            )
                          ],
                        ),
                      );
                    } else {
                      return Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
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
                                ),
                                InputWidget(
                                  labelText:
                                      tr('new_store.info_details.c_name'),
                                  onSaved: (value) {
                                    customerName = value;
                                  },
                                ),
                                InputWidget(
                                  labelText:
                                      tr('new_store.info_details.c_phone'),
                                  onSaved: (value) {
                                    customerPhone = value;
                                  },
                                ),
                                InputWidget(
                                  labelText:
                                      tr('new_store.info_details.s_name'),
                                  onSaved: (value) {
                                    sellsName = value;
                                  },
                                ),
                                InputWidget(
                                  labelText:
                                      tr('new_store.info_details.s_phone'),
                                  onSaved: (value) {
                                    sellsPhone = value;
                                  },
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
                                                      images.add(image);
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: images.length,
                                                itemBuilder: (ctx, index) {
                                                  return Container(
                                                    height: 90.0,
                                                    width: 90.0,
                                                    margin:
                                                        EdgeInsets.symmetric(
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
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
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
                                                                  images[
                                                                      index]);
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
//                                Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: Row(
//                                    mainAxisAlignment:
//                                        MainAxisAlignment.spaceBetween,
//                                    children: <Widget>[
//                                      Expanded(
//                                        child: Text(
//                                          tr('new_store.sale_out_hmto'),
//                                          style: TextStyle(
//                                            fontSize: 21.0,
//                                            color: Colors.black,
//                                            fontWeight: FontWeight.bold,
//                                          ),
//                                        ),
//                                      ),
//                                      SizedBox(
//                                        width: 20.0,
//                                      ),
//                                      Container(
//                                        width:
//                                            MediaQuery.of(context).size.width *
//                                                0.4,
//                                        child: TextFormField(
//                                          onSaved: null,
//                                          validator: validator,
//                                          decoration: InputDecoration(
//                                            border: OutlineInputBorder(
//                                              borderRadius:
//                                                  BorderRadius.circular(
//                                                5.0,
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
                                Consumer<FieldForceData>(
                                  builder: (context, data, child) =>
                                      ListView.builder(
                                    itemCount: data.competitors.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (ctx, index) {
                                      void onSaved(value) {
                                        int i = competitorData.indexWhere(
                                            (elem) =>
                                                data.competitors[index]
                                                    .competitorId ==
                                                elem.competitorId);
                                        print(':::::::::::' + i.toString());
                                        if (i == -1) {
                                          competitorData.add(
                                            CompetitorPercents(
                                              competitorId: data
                                                  .competitors[index]
                                                  .competitorId,
                                              sallesRateStock: value + '%',
                                            ),
                                          );
                                        } else {
                                          competitorData[i].sallesRateStock =
                                              value + '%';
                                        }
                                      }

                                      void onSavedValue(value) {
                                        int i = competitorData.indexWhere(
                                            (elem) =>
                                                data.competitors[index]
                                                    .competitorId ==
                                                elem.competitorId);
                                        if (i == -1) {
                                          competitorData.add(
                                            CompetitorPercents(
                                              competitorId: data
                                                  .competitors[index]
                                                  .competitorId,
                                              sallesRateMoney: value,
                                            ),
                                          );
                                        } else {
                                          competitorData[i].sallesRateMoney =
                                              value;
                                        }
                                      }

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                data.competitors[index].name,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                            ),
                                            Spacer(),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: TextFormField(
                                                onSaved: onSaved,
                                                validator: validator,
                                                decoration: InputDecoration(
                                                  hintText: 'offer',
                                                  contentPadding:
                                                      EdgeInsets.all(
                                                    16.0,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      5.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: TextFormField(
                                                onSaved: onSavedValue,
                                                validator: validator,
                                                decoration: InputDecoration(
                                                  hintText: 'value',
                                                  contentPadding:
                                                      EdgeInsets.all(
                                                    16.0,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      5.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
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
                                            questionId: data
                                                .longAnswerQuestion[index].id,
                                            answer: value,
                                          ),
                                        );
                                      }

                                      return Question(
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
      ),
    );
  }
}
