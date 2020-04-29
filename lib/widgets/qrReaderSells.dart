import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:senior/sells/testStore.dart';
import 'package:senior/widgets/alertDialog.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/sellsProvider.dart';

class QrReaderSells extends StatefulWidget {
  @override
  _QrReaderSellsState createState() => _QrReaderSellsState();
}

class _QrReaderSellsState extends State<QrReaderSells> {
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
        print('BarCodeSells Output : ' + barcode);
        await Provider.of<SellsData>(context, listen: false).scanStore(
          qrData: barcode,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Consumer<SellsData>(
              builder: (context, data, child) => SellsStore(
                id: data.qrResult.storeInfo.id,
                imageIn: data.qrResult.storeInfo.imageIn,
                imageOut: data.qrResult.storeInfo.imageOut,
                imageStoreFront: data.qrResult.storeInfo.imageStoreFront,
                imageStoreAds: data.qrResult.storeInfo.imageStoreAds,
                customerName: data.qrResult.storeInfo.customerName,
                landmark: data.qrResult.storeInfo.landmark,
                mobile: data.qrResult.storeInfo.mobile,
                rate: data.qrResult.storeInfo.rate,
                storeName: data.qrResult.storeInfo.storeName,
              ),
            ),
          ),
        );
        setState(() {
          hasError = false;
        });
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
