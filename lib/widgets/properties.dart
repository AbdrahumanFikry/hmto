import 'package:flutter/material.dart';
import '../widgets/qrReader.dart';
import '../sells/cartScreen.dart';
import 'package:easy_localization/easy_localization.dart';

class Properties extends StatelessWidget {
  void goToCartScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CartScreen(),
      ),
    );
  }

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.green,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, right: 00.0),
                        child: Icon(
                          Icons.confirmation_number,
                          color: Colors.green,
                        ),
                      ),
                      new Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          onChanged: (value) {
//                            _email = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'serial number',
                            hintStyle: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
//            Navigator.of(context).push(
//              MaterialPageRoute(
//                builder: (context) => QrReader(),
//              ),
//            );
          },
          title: Text('BarCode'),
          leading: Icon(
            Icons.code,
            size: 26.0,
            color: Colors.blue,
          ),
        ),
        ListTile(
          onTap: () {
            _showModalSheet(context);
          },
          leading: Icon(
            Icons.confirmation_number,
            size: 24.0,
            color: Colors.blue,
          ),
          title: Text(
            'Serial number',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 60.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: FlatButton(
              onPressed: () => goToCartScreen(context),
              child: Text(
                tr('sells_store.check_out') + '   ( 10 items )',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
