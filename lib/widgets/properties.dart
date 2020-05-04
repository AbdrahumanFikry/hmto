import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/sellsProvider.dart';
import 'package:senior/sells/returenedCart.dart';
import 'package:senior/widgets/alertDialog.dart';
import 'package:senior/widgets/productBarCodeReader.dart';
import '../sells/cartScreen.dart';
import 'package:easy_localization/easy_localization.dart';

class Properties extends StatefulWidget {
  final int storeId;
  final bool isCash;
  final bool isDebit;
  final bool isReturned;

  Properties({
    this.storeId,
    this.isCash = false,
    this.isDebit = false,
    this.isReturned = false,
  });

  @override
  _PropertiesState createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String number = '';

  void goToCartScreen() {
    if (!widget.isReturned) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CartScreen(
            storeId: widget.storeId,
            isCash: widget.isCash,
            isDebit: widget.isDebit,
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ReturnedCartCart(
            storeId: widget.storeId,
          ),
        ),
      );
    }
  }

  void onSave() async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      try {
        if (!widget.isReturned) {
          await Provider.of<SellsData>(context, listen: false)
              .addItemToBill(serialNumber: number);
          Navigator.of(context).pop();

          GlobalAlertDialog.showQuantityDialog(
              context: context, serialNumber: number);
        } else {
          await Provider.of<SellsData>(context, listen: false)
              .addItemToReturnedInvoice(serialNumber: number);
          Navigator.of(context).pop();
        }
      } catch (error) {
        Navigator.of(context).pop();
        GlobalAlertDialog.showErrorDialog(error.toString(), context);
      }
    }
  }

  void showModalSheet() {
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
                              setState(() {
                                number = value;
                              });
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
                      onPressed: onSave,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductBarCodeReader(
                  isReturned: widget.isReturned,
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
          onTap: showModalSheet,
          leading: Icon(
            Icons.confirmation_number,
            size: 24.0,
            color: Colors.blue,
          ),
          title: Text(
            tr('other.serial'),
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
            child: Consumer<SellsData>(
              builder: (context, data, _) => FlatButton(
                onPressed: goToCartScreen,
                child: Text(
                  tr('sells_store.check_out') +
                      '   ( ' +
                      tr('store.products') +
                      ' ' +
                      '${widget.isReturned ? data.returnedBill.length.toString() : data.bill.length.toString()}' +
                      ' )',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
