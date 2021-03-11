import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart' as other;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart' as basic;
import 'package:provider/provider.dart';
import 'package:senior/models/reternedProduct.dart';
import 'package:senior/providers/sellsProvider.dart';

import '../models/startDaySalles.dart';
import '../printers/invoiceBody.dart';

class PrinterScreen extends StatefulWidget {
  final bool isOldDebit;
  final bool isCart;
  final bool isReturned;
  final String storeName;
  final String sellsName;
  final String sellsId;
  final String paid;
  final String sale;
  final String tax;
  final String total;
  final String oldTotal;
  final String totalAfterTax;
  final String transactionId;
  final List<CarProduct> bill;
  final List<ReturnedProduct> returnedBill;

  PrinterScreen({
    this.storeName = '',
    this.sellsId = '',
    this.transactionId = 'id',
    this.sellsName = '',
    this.isOldDebit = false,
    this.isReturned = false,
    this.paid = 'noDebit',
    this.bill,
    this.oldTotal = '0.0',
    this.isCart = false,
    this.sale = '0.0',
    this.total = '0.0',
    this.tax = '0.0',
    this.totalAfterTax = '0.0',
    this.returnedBill,
  });

  @override
  _PrinterScreenState createState() => new _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  other.PrinterBluetoothManager printerManager =
      other.PrinterBluetoothManager();

  List<BluetoothDevice> _devices = [];
  BluetoothDevice _device;
  bool _connected = false;
  String pathImage;
  InvoiceBody testPrint;

  @override
  void initState() {
    super.initState();
    initPlatformState();
//    initSavetoPath();
    testPrint = InvoiceBody();
  }

//  initSavetoPath() async {
//    //read and write
//    //image max 300px X 300px
//    final filename = 'appLogo.jpg';
//    var bytes = await rootBundle.load("assets/appLogo.jpg");
//    String dir = (await getApplicationDocumentsDirectory()).path;
//    writeToFile(bytes, '$dir/$filename');
//    setState(() {
//      pathImage = '$dir/$filename';
//    });
//  }

  Future<void> initPlatformState() async {
    bool isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String storeCode =
        Provider.of<SellsData>(context, listen: false)?.storeCode ??
            'code unAvailable';
    print("::::::::::::::" + widget.sale.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('sells_store.print'),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'الطابعه :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: DropdownButton(
                      items: _getDeviceItems(),
                      onChanged: (value) => setState(() => _device = value),
                      value: _device,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.brown,
                    onPressed: () {
                      initPlatformState();
                    },
                    child: Text(
                      'تحديث',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    color: _connected ? Colors.red : Colors.green,
                    onPressed: _connected ? _disconnect : _connect,
                    child: Text(
                      _connected ? 'فصل' : 'توصيل',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
                child: RaisedButton(
                  color: Colors.brown,
                  onPressed: () async {
                    if (widget.isOldDebit) {
                      testPrint.sample2(
                        storeCode: storeCode,
                        sellsName: widget.sellsName,
                        storeName: widget.storeName,
                        paid: widget.paid,
                        rest: (double.tryParse(widget.total) -
                                double.tryParse(widget.paid) -
                                double.tryParse(widget.oldTotal))
                            .toStringAsFixed(2)
                            .toString(),
                        oldTotal: widget.oldTotal,
                        total: widget.total,
                        transactionId: widget.transactionId,
                      );
                    } else if (widget.isCart) {
                      testPrint.cartSample(
                        cart: widget.bill,
                        sellsName: widget.sellsName,
                      );
                    } else if (widget.isReturned) {
                      print("::::::::::::::" +
                          widget.returnedBill.length.toString());

                      testPrint.returnSample(
                        storeCode: storeCode,
                        sellsName: widget.sellsName,
                        bill: widget.returnedBill,
                        storeName: widget.storeName,
                        context: context,
                      );
                    } else {
                      testPrint.sample(
                        storeCode: storeCode,
                        sellsName: widget.sellsName,
                        debit: widget.paid,
                        storeName: widget.storeName,
                        bill: widget.bill,
                        tax: widget.tax,
                        totalAfterTax: widget.totalAfterTax,
                        sale: widget.sale,
                        total: widget.total,
                        transactionId: widget.transactionId,
                      );
                    }
                  },
                  child: Text(tr('sells_store.print'),
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('لا يوجد'),
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  void _connect() {
    if (_device == null) {
      show('ليس هناك اجهزه متصله');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected) {
          bluetooth.connect(_device).catchError((error) {
            setState(() => _connected = false);
          });
          basic.BluetoothDevice otherDevice = basic.BluetoothDevice()
            ..name = _device.name
            ..type = _device.type
            ..address = _device.address
            ..connected = _device.connected;
          printerManager.selectPrinter(other.PrinterBluetooth(otherDevice));
          setState(() => _connected = true);
        }
      });
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = true);
  }

//write to app path
  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  }
}
