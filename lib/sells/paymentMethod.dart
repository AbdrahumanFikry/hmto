import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../widgets/alertDialog.dart';

class PaymentMethod extends StatefulWidget {
  final double amount;

  PaymentMethod({
    this.amount = 0.0,
  });

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int _radioValue = 0;

  bool isLoading = false;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
    //TODO -------------
  }

  final List<String> methods = [
    tr('sells_store.cash'),
    tr('sells_store.anotherMethod'),
  ];

  File image;

  Future getImageCamera() async {
    try {
      File holder = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 512,
        maxHeight: 700,
      );
      image = holder;
      setState(() {});
    } catch (error) {
      throw error;
    }
  }

  Future getImageGallery() async {
    try {
      File holder = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 512,
        maxHeight: 700,
      );
      image = holder;
      setState(() {});
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'طريقه الدفع',
            style: TextStyle(color: Colors.green),
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            Container(
              height: 60.0,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Text(
                    '${tr('extra.value')} : ',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.amount.toStringAsFixed(2).toString(),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.monetization_on,
                          size: 18.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: methods.length,
              itemBuilder: (context, index) {
                return PaymentItem(
                  value: index,
                  onChange: (int value) => _handleRadioValueChange(value),
                  radioVal: _radioValue,
                  title: methods[index],
                );
              },
            ),
            _radioValue == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 90.0,
                        width: 90.0,
                        margin: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 5.0,
                        ),
                        color: Colors.grey[200],
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () async {
                              await getImageCamera();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      Container(
                        height: 90.0,
                        width: 90.0,
                        margin: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 5.0,
                        ),
                        color: Colors.grey[200],
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.photo),
                            onPressed: () async {
                              await getImageGallery();
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            _radioValue != 0 && image != null
                ? Container(
                    height: 200.0,
                    width: 90.0,
                    margin: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 50.0,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.cancel,
                            size: 18,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              image = null;
                            });
                          },
                        )
                      ],
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: RaisedButton(
                onPressed: () async {
                  String type = _radioValue == 0 ? 'cash' : 'not cash';
                  if (type == 'not cash' && image == null) {
                    GlobalAlertDialog.showErrorDialog(
                        'يجب ارفاق صوره ايصال', context);
                  } else {
                    Navigator.of(context).pop([type, image]);
                  }
                },
                color: Colors.green,
                child: Text('اتمام العمليه'),
                padding: EdgeInsets.symmetric(vertical: 10.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PaymentItem extends StatelessWidget {
  final int radioVal;
  final int value;
  final String title;
  final Function onChange;

  PaymentItem({
    this.radioVal,
    this.value,
    this.title,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio(
          value: value,
          groupValue: radioVal,
          onChanged: onChange,
        ),
        Text(
          title,
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
