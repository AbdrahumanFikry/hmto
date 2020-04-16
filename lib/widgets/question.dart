import 'package:flutter/material.dart';

class QuestionHandler extends StatelessWidget {
  final int index;
  final String question;
  final FormFieldSetter<String> onSaved;

  QuestionHandler({
    this.index,
    this.question,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$index - ' + question,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          onSaved: onSaved,
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
