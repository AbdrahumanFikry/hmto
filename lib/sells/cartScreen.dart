import 'package:flutter/material.dart';
import 'package:senior/widgets/testStoreWidget.dart';

class CartScreen extends StatelessWidget {
  final List items;

  CartScreen({
    this.items,
  });

  void print() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Check out',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
        elevation: 3.0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (ctx, index) {
              return TestStoreWidget(
                isCart: true,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '2600 EGP',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'prise',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '5000 EGP',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                  ),
                ),
              ],
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
                onPressed: print,
                child: Text(
                  'Print',
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
      ),
    );
  }
}
