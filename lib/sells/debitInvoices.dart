import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/sellsProvider.dart';
import 'package:senior/sells/sellsNavigator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:senior/widgets/alertDialog.dart';
import 'package:senior/widgets/errorWidget.dart';
import 'package:senior/widgets/oldDebitInvoiceCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OldInvoicesScreen extends StatefulWidget {
  final int storeId;

  OldInvoicesScreen({
    this.storeId,
  });

  @override
  _OldInvoicesScreenState createState() => _OldInvoicesScreenState();
}

class _OldInvoicesScreenState extends State<OldInvoicesScreen> {
  @override
  void initState() {
    Provider.of<SellsData>(context, listen: false).debitInvoices = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tr('debitInvoice.title'),
          style: TextStyle(color: Colors.green),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: FutureBuilder(
        future:
            Provider.of<SellsData>(context, listen: false).debitInvoices == null
                ? Provider.of<SellsData>(context, listen: false)
                    .fetchDebitInvoices(storeId: widget.storeId)
                : null,
        builder: (context, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapShot.hasError) {
              return ErrorHandler(
                toDO: () {
                  setState(() {
                    Provider.of<SellsData>(context, listen: false)
                        .debitInvoices = null;
                  });
                },
              );
            } else {
              return Consumer<SellsData>(
                builder: (context, data, child) {
                  return data.debitInvoices.data.length == 0
                      ? Center(
                          child: Icon(
                            FontAwesomeIcons.wallet,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                        )
                      : ListView.builder(
                          itemCount: data.debitInvoices.data.length,
                          itemBuilder: (ctx, index) {
                            return OldDebitInvoiceCard(
                              storeId: widget.storeId,
                              amountMustBePaid: data
                                  .debitInvoices.data[index].amountMustBePaid,
                              amountPaid:
                                  data.debitInvoices.data[index].amountPaid,
                              finalTotal:
                                  data.debitInvoices.data[index].finalTotal,
                              taxAmount:
                                  data.debitInvoices.data[index].taxAmount,
                              totalBeforeTax:
                                  data.debitInvoices.data[index].totalBeforeTax,
                              transactionId:
                                  data.debitInvoices.data[index].transactionId,
                            );
                          },
                        );
                },
              );
            }
          }
        },
      ),
    );
  }
}
