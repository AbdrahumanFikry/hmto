import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:senior/printers/ScreenPrinter.dart';
import 'package:senior/providers/authenticationProvider.dart';
import 'package:senior/widgets/alertDialog.dart';
import '../providers/sellsProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../sells/paymentMethod.dart';

class OldDebitInvoiceCard extends StatefulWidget {
  final int storeId;
  final String storeName;
  final int transactionId;
  final String finalTotal;
  final String totalBeforeTax;
  final String taxAmount;
  final String amountPaid;
  final double amountMustBePaid;

  OldDebitInvoiceCard({
    this.storeId,
    this.amountPaid,
    this.transactionId,
    this.finalTotal,
    this.amountMustBePaid,
    this.taxAmount,
    this.totalBeforeTax,
    this.storeName,
  });

  @override
  _OldDebitInvoiceCardState createState() => _OldDebitInvoiceCardState();
}

class _OldDebitInvoiceCardState extends State<OldDebitInvoiceCard> {
  bool isLoading = false;
  String paid = 'Another Payment';

  Future<void> payOldDebit() async {
    List paymentData = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaymentMethod(
          amount: double.tryParse(paid),
        ),
      ),
    );
    String sellsName = Provider.of<Auth>(context, listen: false).userName;
    if (double.tryParse(paid) <= widget.amountMustBePaid) {
      try {
        isLoading = true;
        await Provider.of<SellsData>(context, listen: false).payOldDebitInvoice(
          storeId: widget.storeId,
          transactionId: widget.transactionId,
          amountPaid: paid,
          image: paymentData[1],
          type: paid[0],
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PrinterScreen(
              transactionId: widget.transactionId.toString(),
              storeName: widget.storeName,
              sellsName: sellsName,
              paid: paid,
              oldTotal: widget.amountPaid,
              total: widget.finalTotal,
              isOldDebit: true,
            ),
          ),
        );

        isLoading = false;
      } catch (error) {
        GlobalAlertDialog.showErrorDialog(error.toString(), context);
        setState(() {
          isLoading = false;
        });
      }
    } else {
      GlobalAlertDialog.showErrorDialog(
          'errors.noMore'.tr(args: [tr('debitInvoice.mustPaid')]), context);
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
            Text(tr('debitInvoice.total') +
                ' : ' +
                widget.finalTotal +
                ' ${tr('senior_profile.egp')}'),
            Text(tr('debitInvoice.paid') +
                ' : ' +
                widget.amountPaid +
                ' ${tr('senior_profile.egp')}'),
            Text(tr('debitInvoice.mustPaid') +
                ' : ' +
                widget.amountMustBePaid.toString() +
                ' ${tr('senior_profile.egp')}'),
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
