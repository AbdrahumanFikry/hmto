import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:senior/providers/fieldForceProvider.dart';
import 'package:senior/widgets/alertDialog.dart';
import 'package:easy_localization/easy_localization.dart';

class QrReader extends StatefulWidget {
  final Widget whereTo;

  QrReader({
    @required this.whereTo,
  });

  @override
  _QrReaderState createState() => _QrReaderState();
}

class _QrReaderState extends State<QrReader> {
  bool hasError = false;
  Uint8List bytes = Uint8List(0);
  TextEditingController _outputController;

  Future _scan() async {
    setState(() {
      hasError = false;
    });
    String barcode = await scanner.scan();
    try {
      if (barcode == null) {
        print('nothing return.');
        GlobalAlertDialog.showErrorDialog('Try again', context);
        setState(() {
          hasError = true;
        });
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
              builder: (context) => widget.whereTo,
            ),
          );
          setState(() {
            hasError = false;
          });
        } else {
          GlobalAlertDialog.showErrorDialog('Try again', context);
          setState(() {
            hasError = true;
          });
        }
      }
    } catch (error) {
      setState(() {
        hasError = true;
      });
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
      backgroundColor: Colors.white,
      body: Center(
        child: hasError
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    tr('extra.error'),
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    onPressed: _scan,
                    color: Colors.green,
                    child: Text(
                      tr('extra.tryAgain'),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
