import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/sellsProvider.dart';
import 'package:senior/widgets/alertDialog.dart';
import 'package:senior/widgets/productBarCodeReader.dart';
import 'package:senior/widgets/testStoreWidget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';

class CartScreen extends StatelessWidget {
  final int storeId;
  final bool isCash;
  final bool isDebit;
  final bool isReturn;

  CartScreen({
    this.storeId,
    this.isCash = false,
    this.isDebit = false,
    this.isReturn = false,
  });

  bool isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String number = '';

  Future<void> finishAndPrintBill(
      BuildContext context, double total, String paid) async {
    try {
      isLoading = true;
      if (isCash) {
        await Provider.of<SellsData>(context, listen: false)
            .payCash(storeId: storeId, total: total);
      } else if (isDebit) {
        await Provider.of<SellsData>(context, listen: false)
            .payDebit(storeId: storeId, total: total, paid: paid);
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
    String paid = '';
    String title = '';
    if (isCash) {
      title = tr('sells_store.cash');
    } else if (isDebit) {
      title = tr('sells_store.debit');
    } else {
      title = tr('sells_store.check_out');
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
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
                      );
                    },
                  ),
                  ExpansionTile(
                    title: Text(tr('sells_profile.extra')),
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductBarCodeReader(
                                isReturned: isReturn,
                              ),
                            ),
                          );
                        },
                        title: Text(
                          tr('other.barCode'),
                        ),
                        leading: Icon(
                          Icons.code,
                          size: 26.0,
                          color: Colors.blue,
                        ),
                      ),
                      ListTile(
                        onTap: () => _showModalSheet(context),
                        leading: Icon(
                          Icons.confirmation_number,
                          size: 24.0,
                          color: Colors.blue,
                        ),
                        title: Text(
                          tr('other.serial'),
                        ),
                      ),
                    ],
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
                  isDebit
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  tr('sells_store.summary_details.paid'),
                                  style: TextStyle(
                                    fontSize: 21.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextField(
                                  onChanged: (value) {
                                    paid = value;
                                    print(paid);
                                  },
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
                        )
                      : SizedBox(),
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
                              onPressed: () => finishAndPrintBill(
                                  context, data.returnTotal(), paid),
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

  void onSave(BuildContext context) async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      try {
        await Provider.of<SellsData>(context, listen: false)
            .addItemToBill(serialNumber: number);
        Navigator.of(context).pop();
        GlobalAlertDialog.showQuantityDialog(
            context: context, serialNumber: number);
      } catch (error) {
        Navigator.of(context).pop();
        GlobalAlertDialog.showErrorDialog(error.toString(), context);
      }
    }
  }

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Form(
          key: _formKey,
          child: Container(
            height: 350,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 50.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value == null) {
                                return 'this field is required!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              number = value;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: tr('other.serial'),
                              hintStyle: TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical: 10.0,
                    ),
                    child: RaisedButton(
                      onPressed: () => onSave(context),
                      color: Colors.green,
                      elevation: 5.0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Text(
                        tr('sells_profile.status'),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
