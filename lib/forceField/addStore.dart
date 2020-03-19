import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:senior/widgets/question.dart';
import 'package:senior/widgets/trueAndFalse.dart';
import 'dart:io';
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';

class AdsAddStore extends StatefulWidget {
  @override
  _AdsAddStoreState createState() => _AdsAddStoreState();
}

class _AdsAddStoreState extends State<AdsAddStore> {
  int competitorLength = 0;
  File image;
  List<File> images = new List<File>();

  Future getImage() async {
    File holder = await ImagePicker.pickImage(source: ImageSource.camera);
    image = holder;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          body: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: ListView(
              padding: EdgeInsets.all(7),
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
                Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ),
                  child: TextField(
                    onChanged: (val) {
//                      item.name = val;
                    },
                    decoration: InputDecoration(
                      labelText: tr('new_store.info_details.name'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (val) {
//                      item.desc = val;
                    },
                    decoration: InputDecoration(
                      labelText: tr('new_store.info_details.c_name'),
                    ),
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (val) {
//                      item.name = val;
                    },
                    decoration: InputDecoration(
                      labelText: tr('new_store.info_details.c_phone'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (val) {
//                      item.name = val;
                    },
                    decoration: InputDecoration(
                      labelText: tr('new_store.info_details.s_name'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (val) {
//                      item.name = val;
                    },
                    decoration: InputDecoration(
                      labelText: tr('new_store.info_details.s_phone'),
                    ),
                  ),
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
                                  ? MediaQuery.of(context).size.width - 35
                                  : MediaQuery.of(context).size.width - 130,
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
                                        image: FileImage(images[index]),
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
                                              images.remove(images[index]);
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
//                      setState(() {
//                        item.rating = value;
//                      });
                    },
                    itemCount: 7,
                    itemSize: 30,
                    itemBuilder: (_, int index) => Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          tr('new_store.sale_out_hmto'),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        tr('new_store.competitor'),
                        style: TextStyle(
                          fontSize: 21.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 25.0,
                        ),
                        onPressed: () {
                          setState(() {
                            competitorLength++;
                          });
                        },
                      )
                    ],
                  ),
                ),
                competitorLength == 0
                    ? SizedBox()
                    : ListView.builder(
                        itemCount: competitorLength,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: EasyLocalization.of(context)
                                                  .locale
                                                  .toString() ==
                                              'ar_DZ'
                                          ? 'اسم المنافس'
                                          : 'Competitor name',
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
                                SizedBox(
                                  width: 20.0,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: '0',
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
                          );
                        },
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (ctx, index) {
                    void onSaved(value) {
//                      item.trueFalse.add(
//                        Questions(
//                          title: '',
//                          answer: value,
//                        ),
//                      );
                    }

                    return TrueAndFalse(
                      index: index,
                      question: 'question',
//                      onSaved: onSaved,
                    );
                  },
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (ctx, index) {
                    void onSaved(value) {
//                      item.questions.add(
//                        Questions(
//                          title: 'question 1',
//                          answer: value,
//                        ),
//                      );
                    }

                    return Question(
                      index: index,
                      question: 'question',
                      onSaved: onSaved,
                    );
                  },
                ),
              ],
            ),
          ),
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.green,
              title: Text(
                tr('new_store.title'),
              ),
              expandedHeight: 60,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
