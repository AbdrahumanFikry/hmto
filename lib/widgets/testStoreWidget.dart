import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/sellsProvider.dart';
import 'package:senior/widgets/alertDialog.dart';

class CartScreenItem extends StatelessWidget {
  final int index;
  final bool isReady;

  CartScreenItem({
    this.index,
    this.isReady = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SellsData>(
      builder: (context, data, _) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    data.loadedItems
                        .firstWhere((item) =>
                            item.productId == data.bill[index].productId)
                        .productName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Spacer(),
              isReady
                  ? SizedBox(
                      width: 1,
                    )
                  : InkWell(
                      onTap: () {
                        data.removeProductFromBill(
                            id: data.bill[index].productId);
                      },
                      child: Icon(
                        Icons.cancel,
                        size: 20.0,
                      ),
                    )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.monetization_on,
                color: Colors.green,
                size: 20.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                data.bill[index].unitPrice.toString() +
                    ' ' +
                    tr('senior_profile.egp'),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          isReady
              ? Row(
                  children: <Widget>[
                    Icon(
                      Icons.queue,
                      color: Colors.green,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '${tr('other.qty')} :' +
                          data.bill[index].quantity.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                    Spacer(),
                  ],
                )
              : Row(
                  children: <Widget>[
                    Icon(
                      Icons.queue,
                      color: Colors.green,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '${tr('other.qty')} :' +
                          data.bill[index].quantity.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        if (data.bill[index].quantity != 1) {
                          data.removeAmountFromBill(
                              id: data.bill[index].productId);
                        }
                      },
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                      onPressed: () async {
                        try {
                          await data.addAmountFromBill(
                              id: data.bill[index].productId);
                        } catch (error) {
                          GlobalAlertDialog.showErrorDialog(
                              error.toString(), context);
                        }
                      },
                    ),
                  ],
                ),
          Divider(),
        ],
      ),
    );
  }
}
