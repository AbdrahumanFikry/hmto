import 'package:flutter/material.dart';

class TrueAndFalse extends StatefulWidget {
  final int index;
  final Function onSavedTrue;
  final String question;
  final String answer;
  final Function onSavedFalse;

  TrueAndFalse({
    this.index,
    this.onSavedTrue,
    this.answer,
    this.question,
    this.onSavedFalse,
  });

  @override
  _TrueAndFalseState createState() => _TrueAndFalseState();
}

class _TrueAndFalseState extends State<TrueAndFalse> {
  String answer = '';

  @override
  Widget build(BuildContext context) {
    print('::::::::::::' + widget.answer);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            '${widget.index} - ' + widget.question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Spacer(
              flex: 16,
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                widget.onSavedTrue();
                setState(() {
                  answer = 'True';
                });
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  //boxShadow: [BoxShadow()],
                  shape: BoxShape.circle,
                  color: answer == 'True' ? Colors.blue : Colors.green,
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Icon(
                  Icons.check,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                widget.onSavedFalse();
                setState(() {
                  answer = 'False';
                });
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  //boxShadow: [BoxShadow()],
                  shape: BoxShape.circle,
                  color: answer == 'False' ? Colors.blue : Colors.green,
                  border: Border.all(color: Colors.black12),
                ),
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        Divider(
          endIndent: 30,
          indent: 30,
          height: 40,
        ),
      ],
    );
  }
}
