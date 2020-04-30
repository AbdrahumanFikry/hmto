import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/sellsProvider.dart';
import 'package:senior/widgets/alertDialog.dart';
import 'package:senior/widgets/testStoreWidget.dart';
import 'package:easy_localization/easy_localization.dart';

class CartScreen extends StatelessWidget {
  final int storeId;
  final bool isReady;
  final bool isCash;
  final bool isDebit;
  final bool isReturn;

  CartScreen({
    this.storeId,
    this.isReady = false,
    this.isCash = false,
    this.isDebit = false,
    this.isReturn = false,
  });

  bool isLoading = false;

  Future<void> print(BuildContext context, double total) async {
    try {
      isLoading = true;
      if (isCash) {
        await Provider.of<SellsData>(context, listen: false)
            .payCash(storeId: storeId, total: total);
      } else if (isDebit) {
      } else if (isReturn) {
      } else {
        GlobalAlertDialog.showErrorDialog('Invalid input!', context);
      }
      isLoading = false;
    } catch (error) {
      GlobalAlertDialog.showErrorDialog(error.toString(), context);
      isLoading = false;
    }
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
      body: Consumer<SellsData>(
        builder: (context, data, _) => data.bill.isEmpty
            ? Center(
                child: Icon(
                  FontAwesomeIcons.dolly,
                  size: 40.0,
                ),
              )
            : ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8.0,
                ),
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.bill.length,
                    itemBuilder: (ctx, index) {
                      return CartScreenItem(
                        index: index,
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
                          data.returnTotal().toString() +
                              ' ' +
                              tr('senior_profile.egp'),
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Text(
//                  tr('other.sale'),
//                  style: TextStyle(
//                    fontSize: 20.0,
//                    color: Colors.black,
//                  ),
//                ),
//                SizedBox(
//                  width: 20.0,
//                ),
//                Container(
//                  width: MediaQuery.of(context).size.width * 0.5,
//                  child: TextField(
//                    decoration: InputDecoration(
//                      contentPadding: EdgeInsets.only(
//                        right: 100.0,
//                      ),
//                      border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(
//                          5.0,
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
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
                          data.returnTotal().toString() +
                              ' ' +
                              tr('senior_profile.egp'),
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
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: 60.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: FlatButton(
                              onPressed: () =>
                                  print(context, data.returnTotal()),
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
      ),
    );
  }
}
