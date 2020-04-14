import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QrReader extends StatelessWidget {
  bool done = false;
  Uint8List bytes = Uint8List(0);
  static TextEditingController _outputController = new TextEditingController();

  static Future _scan(
    BuildContext context,
  ) async {
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      _outputController.text = barcode;
      print('BarCode Output : ' + barcode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
