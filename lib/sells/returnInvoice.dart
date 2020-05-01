import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/sellsProvider.dart';
import 'package:senior/widgets/alertDialog.dart';
import 'package:senior/widgets/properties.dart';
import 'package:senior/widgets/readyItem.dart';
import 'package:easy_localization/easy_localization.dart';

class ReturnInvoice extends StatelessWidget {
  final int storeId;
  final int billIndex;

  ReturnInvoice({
    this.billIndex,
    this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tr('sells_store.return'),
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
        elevation: 3.0,
      ),
      body: Consumer<SellsData>(
        builder: (context, data, _) => data
                .oldInvoices.data[billIndex].products.isEmpty
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
                    itemCount: data.oldInvoices.data[billIndex].products.length,
                    itemBuilder: (ctx, index) {
                      return ReadyItem(
                        billIndex: billIndex,
                        productIndex: index,
                      );
                    },
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
                          data.oldInvoices.data[billIndex].finalTotal +
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
                  Divider(),
                  Properties(
                    storeId: data.oldInvoices.data[billIndex].storeId,
                    isReturn: true,
                  ),
                ],
              ),
      ),
    );
  }
}
