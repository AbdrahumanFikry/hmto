import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QrReader extends StatefulWidget {
  final Widget whereTo;

  QrReader({
    this.whereTo,
  });

  @override
  _QrReaderState createState() => _QrReaderState();
}

class _QrReaderState extends State<QrReader> {
  bool done = false;
  Uint8List bytes = Uint8List(0);
  TextEditingController _outputController;

  Future _scan() async {
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      this._outputController.text = barcode;
      print('BarCode Output : ' + barcode);
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => widget.whereTo,
      ),
    );
  }

  @override
  initState() {
    super.initState();
    _scan();
    this._outputController = new TextEditingController();
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
