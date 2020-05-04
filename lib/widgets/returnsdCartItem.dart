import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/sellsProvider.dart';
import 'package:senior/widgets/alertDialog.dart';

class ReturnedCartScreenItem extends StatelessWidget {
  final int index;

  ReturnedCartScreenItem({
    this.index,
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
                    data.billProducts
                        .firstWhere((item) =>
                            item.id == data.returnedBill[index].productId)
                        .product,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  data.removeProductFromReturnedInvoice(
                      id: data.returnedBill[index].productId);
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
//          Row(
//            children: <Widget>[
//              Icon(
//                Icons.monetization_on,
//                color: Colors.green,
//                size: 20.0,
//              ),
//              SizedBox(
//                width: 10.0,
//              ),
//              Text(
//                data.returnedBill[index].unitPrice.toString() +
//                    ' ' +
//                    tr('senior_profile.egp'),
//                style: TextStyle(
//                  color: Colors.grey,
//                  fontSize: 16.0,
//                ),
//              ),
//            ],
//          ),
          Row(
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
                    data.returnedBill[index].quantity.toString(),
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
                  if (data.returnedBill[index].quantity != 1) {
                    data.removeAmountFromReturnedInvoice(
                        id: data.returnedBill[index].productId);
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
                    await data.addAmountToReturnedInvoice(
                        id: data.returnedBill[index].productId);
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
