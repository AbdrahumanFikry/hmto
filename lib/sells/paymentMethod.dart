import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
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
        body: Column(
          children: <Widget>[
            Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Text(
                    'لقيمه :',
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
                          '500',
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
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return PaymentItem(
                    value: index,
                    onChange: () => _handleRadioValueChange(index),
                    radioVal: _radioValue,
                    title: 'asasa',
                  );
                },
              ),
            ),
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
