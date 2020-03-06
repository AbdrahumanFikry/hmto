import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  final int index;
  final String question;
  final FormFieldSetter<String> onSaved;

  Question({this.index, this.question, this.onSaved});

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  String answer;

  void onSave(value) {
    answer = value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${widget.index} - ' + widget.question,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextField(
          onChanged: onSave,
          decoration: InputDecoration(
            hintText: 'Type answer here',
          ),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
