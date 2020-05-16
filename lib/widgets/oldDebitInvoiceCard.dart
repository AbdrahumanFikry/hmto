import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:senior/widgets/alertDialog.dart';
import '../providers/sellsProvider.dart';
import 'package:easy_localization/easy_localization.dart';

class OldDebitInvoiceCard extends StatefulWidget {
  final int storeId;
  final int transactionId;
  final String finalTotal;
  final String totalBeforeTax;
  final String taxAmount;
  final String amountPaid;
  final int amountMustBePaid;

  OldDebitInvoiceCard({
    this.storeId,
    this.amountPaid,
    this.transactionId,
    this.finalTotal,
    this.amountMustBePaid,
    this.taxAmount,
    this.totalBeforeTax,
  });

  @override
  _OldDebitInvoiceCardState createState() => _OldDebitInvoiceCardState();
}

class _OldDebitInvoiceCardState extends State<OldDebitInvoiceCard> {
  bool isLoading = false;
  String paid;

  Future<void> payOldDebit() async {
    try {
      isLoading = true;
      await Provider.of<SellsData>(context, listen: false).payOldDebitInvoice(
          transactionId: widget.transactionId, amountPaid: paid);
      await Provider.of<SellsData>(context, listen: false)
          .fetchDebitInvoices(storeId: widget.storeId);
      isLoading = false;
    } catch (error) {
      GlobalAlertDialog.showErrorDialog(error.toString(), context);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(tr('debitInvoice.id') +
                ' : ' +
                widget.transactionId.toString()),
            Text(tr('debitInvoice.beforeTax') + ' : ' + widget.totalBeforeTax),
            Text(tr('debitInvoice.tax') + ' : ' + widget.taxAmount),
            Text(tr('debitInvoice.total') + ' : ' + widget.finalTotal),
            Text(tr('debitInvoice.paid') + ' : ' + widget.amountPaid),
            Text(tr('debitInvoice.mustPaid') +
                ' : ' +
                widget.amountMustBePaid.toString()),
            isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == null) {
                              return 'this field is required!';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            paid = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: RaisedButton(
                              onPressed: payOldDebit,
                              color: Colors.green,
                              child: Text(tr('debitInvoice.pay')),
                              padding: EdgeInsets.symmetric(
                                vertical: 10.0,
                              ),
                            ),
                            hintText: '0',
                            hintStyle: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
