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
          print(
              ':::: $shopName\n$customerName\n$customerPhone\n$sellsName\n$sellsPhone\n$rate\n${json.encode({
            "data": questionsAnswer
          })}\n${widget.lat}\n${widget.long}');
          await Provider.of<FieldForceData>(context, listen: false).addNewShop(
            shopName: shopName,
            customerName: customerName,
            customerPhone: customerPhone,
            sellsName: sellsName,
            sellsPhone: sellsPhone,
            rate: rate,
            image1: images[0],
            image2: images[1],
            image3: images[2],
            image4: images[3],
            answers: json.encode({"data": questionsAnswer}),
            lat: widget.lat.toString(),
            long: widget.long.toString(),
            landmark: widget.address,
            position: widget.address,
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
            Provider.of<FieldForceData>(context, listen: false).questionsList !=
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
                            .questionsList ==
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
                              'Check your internet connection',
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
                                'Refresh',
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
                                      .questionsList = null;
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
//                            Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceBetween,
//                                children: <Widget>[
//                                  Expanded(
//                                    child: Text(
//                                      tr('new_store.sale_out_hmto'),
//                                      style: TextStyle(
//                                        fontSize: 21.0,
//                                        color: Colors.black,
//                                        fontWeight: FontWeight.bold,
//                                      ),
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    width: 20.0,
//                                  ),
//                                  Container(
//                                    width:
//                                        MediaQuery.of(context).size.width * 0.5,
//                                    child: TextField(
//                                      decoration: InputDecoration(
//                                        contentPadding: EdgeInsets.only(
//                                          right: 100.0,
//                                        ),
//                                        border: OutlineInputBorder(
//                                          borderRadius: BorderRadius.circular(
//                                            5.0,
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                            Padding(
//                              padding: EdgeInsets.symmetric(
//                                horizontal: 5.0,
//                              ),
//                              child: Row(
//                                children: <Widget>[
//                                  Text(
//                                    tr('new_store.competitor'),
//                                    style: TextStyle(
//                                      fontSize: 21.0,
//                                      color: Colors.black,
//                                      fontWeight: FontWeight.bold,
//                                    ),
//                                  ),
//                                  Spacer(),
//                                  competitorLength == 0
//                                      ? SizedBox()
//                                      : IconButton(
//                                          icon: Icon(
//                                            Icons.remove,
//                                            size: 25.0,
//                                            color: Colors.red,
//                                          ),
//                                          onPressed: () {
//                                            setState(() {
//                                              competitorLength--;
//                                            });
//                                          },
//                                        ),
//                                  IconButton(
//                                    icon: Icon(
//                                      Icons.add,
//                                      size: 25.0,
//                                    ),
//                                    onPressed: () {
//                                      setState(() {
//                                        competitorLength++;
//                                      });
//                                    },
//                                  )
//                                ],
//                              ),
//                            ),
//                            competitorLength == 0
//                                ? SizedBox()
//                                : ListView.builder(
//                                    itemCount: competitorLength,
//                                    shrinkWrap: true,
//                                    physics: NeverScrollableScrollPhysics(),
//                                    itemBuilder: (ctx, index) {
//                                      return Padding(
//                                        padding: const EdgeInsets.all(8.0),
//                                        child: Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Container(
//                                              width: MediaQuery.of(context)
//                                                      .size
//                                                      .width *
//                                                  0.5,
//                                              child: TextField(
//                                                decoration: InputDecoration(
//                                                  hintText: EasyLocalization.of(
//                                                                  context)
//                                                              .locale
//                                                              .toString() ==
//                                                          'ar_DZ'
//                                                      ? 'اسم المنافس'
//                                                      : 'Competitor name',
//                                                  contentPadding:
//                                                      EdgeInsets.all(
//                                                    16.0,
//                                                  ),
//                                                  border: OutlineInputBorder(
//                                                    borderRadius:
//                                                        BorderRadius.circular(
//                                                      5.0,
//                                                    ),
//                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                            SizedBox(
//                                              width: 20.0,
//                                            ),
//                                            Container(
//                                              width: MediaQuery.of(context)
//                                                      .size
//                                                      .width *
//                                                  0.3,
//                                              child: TextField(
//                                                decoration: InputDecoration(
//                                                  hintText: '0',
//                                                  contentPadding:
//                                                      EdgeInsets.all(
//                                                    16.0,
//                                                  ),
//                                                  border: OutlineInputBorder(
//                                                    borderRadius:
//                                                        BorderRadius.circular(
//                                                      5.0,
//                                                    ),
//                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      );
//                                    },
//                                  ),
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
