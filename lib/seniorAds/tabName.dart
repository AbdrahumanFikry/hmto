import 'package:flutter/material.dart';

class TabName extends StatelessWidget {
  String text;
  TabName(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(
          flex: 1,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Add ${this.text}',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            maxLines: null,
            controller: TextEditingController(text: ''),
          ),
        ),
        Spacer(
          flex: 3,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: ButtonTheme(
            colorScheme: ColorScheme.dark(),
            height: 50,
            minWidth: 200,
            child: FlatButton(
                color: Colors.green,
                onPressed: () {},
                child: Text('Submit update')),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ButtonTheme(
            colorScheme: ColorScheme.dark(),
            height: 50,
            minWidth: 200,
            child: FlatButton(
                color: Colors.red, onPressed: () {}, child: Text('Deny')),
          ),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
