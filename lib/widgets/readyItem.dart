import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/sellsProvider.dart';
import 'package:senior/widgets/alertDialog.dart';

class ReadyItem extends StatelessWidget {
  final int billIndex;
  final int productIndex;

  ReadyItem({
    this.billIndex,
    this.productIndex,
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
                    data.oldInvoices.data[billIndex].products[productIndex]
                        .product,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Spacer(),
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
                data.oldInvoices.data[billIndex].products[productIndex]
                        .unitPrice +
                    ' ' +
                    tr('senior_profile.egp'),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
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
                    data.oldInvoices.data[billIndex].products[productIndex]
                        .quantity
                        .toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
              Spacer(),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
