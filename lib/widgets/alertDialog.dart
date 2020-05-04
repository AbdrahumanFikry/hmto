import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/sellsProvider.dart';
import '../widgets/globalDialog.dart';
import 'package:easy_localization/easy_localization.dart';

class GlobalAlertDialog {
  static void showErrorDialog(String errorMessage, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => GlobalDialog(
        header: 'Warning',
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              errorMessage,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: 'Roboto',
              ),
              softWrap: true,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Text(
                      tr('store.submit'),
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 18.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showQuantityDialog({BuildContext context, String serialNumber}) {
    Provider.of<SellsData>(context, listen: false).range = 0.0;
    showDialog(
      context: context,
      builder: (ctx) => Consumer<SellsData>(
        builder: (context, data, child) {
          int carIndex = data.loadedItems
              .indexWhere((item) => item.serialNumber == serialNumber);
          double maxValue = data.loadedItems[carIndex].quantity.roundToDouble();
          return GlobalDialog(
            header: tr('other.qty'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.range.round().toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Roboto',
                  ),
                  softWrap: true,
                ),
                Slider(
                  min: 0.0,
                  max: maxValue,
                  divisions: maxValue.round(),
                  value: data.range,
                  onChanged: (double range) {
                    data.changeRange(value: range);
                  },
                ),
                InkWell(
                  onTap: () {
                    data.addRangeAmountToBill(serialNumber: serialNumber);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: Text(
                          tr('store.submit'),
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 18.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
