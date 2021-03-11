import 'dart:async';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:senior/sells/testStore.dart';
import 'package:senior/widgets/alertDialog.dart';

import '../providers/sellsProvider.dart';

class QrReaderSells extends StatefulWidget {
  @override
  _QrReaderSellsState createState() => _QrReaderSellsState();
}

class _QrReaderSellsState extends State<QrReaderSells> {
  bool hasError = false;
  String error = tr('extra.error');
  Uint8List bytes = Uint8List(0);
  TextEditingController _outputController;
  var currentLocation = Position();
  bool searching = false;

  // Future<void> _getLocation() async {
  //   try {
  //     setState(() {
  //       searching = true;
  //     });
  //     currentLocation = await Geolocator()
  //         .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  //     print('::::::::::::lat :' +
  //         currentLocation.latitude.toString() +
  //         '-long :' +
  //         currentLocation.longitude.toString());
  //     setState(() {
  //       searching = false;
  //     });
  //   } catch (e) {
  //     hasError = true;
  //     print('error :' + e.toString());
  //   }
  // }
  Future<Position> getLocation() async {
    try {
      setState(() {
        searching = true;
      });
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      final geo = GeolocatorPlatform.instance;
      Position position = await geo.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print(
        'UserLocation => \nlat : ' +
            position.latitude.toString() +
            '\nlong : ' +
            position.longitude.toString(),
      );
      setState(() {
        searching = false;
      });
      return position;
    } catch (e) {
      setState(() {
        searching = false;
      });
      print('Geolocator Error : ' + e.toString());
      hasError = true;
      return Position();
    }
  }

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
        currentLocation = await getLocation();
        await Provider.of<SellsData>(context, listen: false).scanStore(
          qrData: barcode,
          lat: currentLocation?.latitude ?? 0.000,
          lng: currentLocation?.longitude ?? 0.000,
        );
        Provider.of<SellsData>(context, listen: false).clearAll();
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
    } catch (e) {
      setState(() {
        error = e.toString();
        hasError = true;
      });
    }
  }

  @override
  initState() {
    super.initState();
    _scan();
    // _lat = widget.latLng.latitude;
    // _long = widget.latLng.longitude;
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
                    error,
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
