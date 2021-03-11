import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior/printers/ScreenPrinter.dart';
import 'package:senior/providers/authenticationProvider.dart';
import 'package:senior/providers/sellsProvider.dart';
import 'package:senior/widgets/myCartItem.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<SellsData>(context, listen: false).fetchCarProduct();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tr('start_day.cart_products'),
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
        elevation: 3.0,
        actions: <Widget>[
          RaisedButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PrinterScreen(
                    isCart: true,
                    bill: Provider.of<SellsData>(context, listen: false)
                        .loadedItems,
                    sellsName:
                        Provider.of<Auth>(context, listen: false).userName,
                    sellsId: Provider.of<Auth>(context, listen: false)
                        .userId
                        .toString(),
                  ),
                ),
              );
            },
            color: Colors.green,
            child: Text(tr('sells_store.print')),
            padding: EdgeInsets.symmetric(vertical: 10.0),
          ),
        ],
      ),
      body: Consumer<SellsData>(
        builder: (context, data, _) => data.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : data.loadedItems.length == 0
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
                        itemCount: data.loadedItems.length,
                        itemBuilder: (ctx, index) {
                          return MyCartItem(
                            index: index,
                          );
                        },
                      ),
                    ],
                  ),
      ),
    );
  }
}
