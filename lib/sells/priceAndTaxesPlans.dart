import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sellsProvider.dart';
import 'package:easy_localization/easy_localization.dart';

class PriceAndTaxesPlans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SellsData>(
      builder: (context, data, _) => ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Text(
              tr('extra.price'),
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Divider(),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.priceTaxesPlan.groupPrice.length,
            itemBuilder: (context, index) {
              return Row(
                children: <Widget>[
                  Radio(
                    value: index,
                    groupValue: data.chosenPricePlan,
                    onChanged: (int value) {
                      data.choosePricePlan(value: value);
                    },
                  ),
                  Text(
                    data.priceTaxesPlan.groupPrice[index].name,
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Text(
              tr('extra.tax'),
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Divider(),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.priceTaxesPlan.taxes.length,
            itemBuilder: (context, index) {
              return Row(
                children: <Widget>[
                  Radio(
                    value: index,
                    groupValue: data.chosenTaxPlan,
                    onChanged: (int value) {
                      data.chooseTaxPlan(value: value);
                    },
                  ),
                  Text(
                    data.priceTaxesPlan.taxes[index].name,
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              );
            },
          ),
          Container(
            height: 60.0,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: FlatButton(
              onPressed: () {
                data.donePlans();
              },
              child: Text(
                tr('extra.apply'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
