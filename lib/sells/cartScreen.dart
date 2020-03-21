import 'package:flutter/material.dart';
import 'package:senior/widgets/testStoreWidget.dart';
import 'package:easy_localization/easy_localization.dart';

class CartScreen extends StatelessWidget {
  final List items;
  final bool isReady;

  CartScreen({
    this.items,
    this.isReady = false,
  });

  void print() {
    //TODO --------
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tr('sells_store.check_out'),
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
              return CartScreenItem(
                isReady: isReady,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  tr('sells_store.total'),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '2600 ' + tr('senior_profile.egp'),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
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
                  tr('other.sale'),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        right: 100.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          5.0,
                        ),
                      ),
                    ),
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
                  tr('sells_store.price'),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '5000 ' + tr('senior_profile.egp'),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
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
                  tr('sells_store.print'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
