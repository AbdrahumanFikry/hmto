import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:senior/widgets/question.dart';
import 'package:senior/widgets/trueAndFalse.dart';
import 'dart:io';
import 'dart:async';
import '../models/newItem.dart';

class AdsAddStore extends StatefulWidget {
  @override
  _AdsAddStoreState createState() => _AdsAddStoreState();
}

class _AdsAddStoreState extends State<AdsAddStore> {
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
                  'Info',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (val) {
//                      item.name = val;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
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
                      labelText: 'Description',
                    ),
                    maxLines: null,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (val) {
//                      item.name = val;
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone',
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
                      labelText: 'Price',
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
                      labelText: 'contact',
                    ),
                  ),
                ),
                Text(
                  'Images',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
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
                              width: MediaQuery.of(context).size.width - 130,
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
                  'Rating',
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
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder: (_, int index) => Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'True / False questions',
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
                  'Long answer questions',
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
              title: Text('New Store'),
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
