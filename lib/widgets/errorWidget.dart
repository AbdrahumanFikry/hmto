import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorHandler extends StatelessWidget {
  final Function toDO;

  ErrorHandler({
    this.toDO,
  });

  @override
  Widget build(BuildContext context) {
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
            onPressed: toDO,
          ),
        ],
      ),
    );
  }
}
