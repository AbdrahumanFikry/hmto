import 'dart:io';
import 'package:flutter/material.dart';

class NewItem with ChangeNotifier {
  String name;
  String desc;
  double rating;
  List<File> images;
  List<Questions> trueFalse;
  List<Questions> questions;

  NewItem({
    this.name,
    this.images,
    this.rating,
    this.desc,
    this.questions,
    this.trueFalse,
  });

  void addImage(File image) {
    images.add(image);
  }

  void addQuestion(String title, String answer) {
    questions.add(Questions(title: title, answer: answer));
  }

  void addTrueFalse(String title, String answer) {
    trueFalse.add(Questions(title: title, answer: answer));
  }
}

class Questions {
  String title;
  String answer;

  Questions({
    this.title,
    this.answer,
  });
}
