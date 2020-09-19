import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:senior/models/answers.dart';
import 'package:senior/providers/fieldForceProvider.dart';

class QuestionHandler extends StatelessWidget {
  final int index;
  final int qId;
  final String question;

  QuestionHandler({
    this.index,
    this.qId,
    this.question,
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
          onSaved: (String value) {
            Provider.of<FieldForceData>(context, listen: false).addAnswer(
              Answer(
                questionId: qId,
                answer: value,
              ),
            );
          },
          decoration: InputDecoration(
            hintText: tr('extra.answer'),
          ),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
