import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:senior/forceField/store.dart';
import 'package:senior/providers/fieldForceProvider.dart';
import 'package:senior/sells/testStore.dart';
import 'package:senior/widgets/alertDialog.dart';

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
      await Provider.of<FieldForceData>(context, listen: false).qrReader(
        qrData: barcode,
      );
      if (Provider.of<FieldForceData>(context, listen: false).qrResult ==
          'visited') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Store(),
          ),
        );
      } else {
        Navigator.of(context).pop();
        GlobalAlertDialog.showErrorDialog('Try again', context);
      }
    }
  }

  @override
  initState() {
    super.initState();
    _scan();
    this._outputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
