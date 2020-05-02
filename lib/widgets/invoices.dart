import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior/models/oldInvoice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/sellsProvider.dart';
import 'package:senior/sells/returnInvoice.dart';

class Invoices extends StatelessWidget {
  final List<InvoiceData> data;

  Invoices({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (ctx, index) {
        return OutlineButton.icon(
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          onPressed: () {
            Provider.of<SellsData>(context, listen: false).billProducts =
                data[index].products;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ReturnInvoice(
                  storeId: data[index].storeId,
                  billIndex: index,
                ),
              ),
            );
          },
          icon: Icon(
            FontAwesomeIcons.fileInvoiceDollar,
            size: 20.0,
            color: Colors.blue,
          ),
          label: Text(
            data[index].transactionId.toString(),
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18.0,
            ),
          ),
        );
      },
    );
  }
}
