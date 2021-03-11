import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior/models/startDaySalles.dart';
import 'package:senior/providers/sellsProvider.dart';

import '../widgets/globalDialog.dart';

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
                      top: 15.0,
                      bottom: 15.0,
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
          // int carIndex = data.loadedItems
          //     .indexWhere((item) => item.serialNumber == serialNumber);
          int maxValue = Provider.of<SellsData>(context, listen: false).maxVal;
          print(':::::::::::' + maxValue.toString());
          return GlobalDialog(
            header: tr('other.qty'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlineButton(
                      onPressed: () {
                        double inc = data.range.round() + 1.0;
                        if (inc <= maxValue) {
                          data.changeRange(value: inc);
                        }
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                      borderSide: BorderSide(color: Colors.green),
                      child: Icon(
                        Icons.add,
                        color: Colors.green,
                        size: 20.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        data.range.round().toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'Roboto',
                        ),
                        softWrap: true,
                      ),
                    ),
                    OutlineButton(
                      onPressed: () {
                        double dec = data.range.round() - 1.0;
                        if (dec >= 0) {
                          data.changeRange(value: dec);
                        }
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                      borderSide: BorderSide(color: Colors.green),
                      child: Icon(
                        Icons.remove,
                        color: Colors.red,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
                // Slider(
                //   min: 0.0,
                //   max: maxValue,
                //   divisions: maxValue.round(),
                //   value: data.range,
                //   onChanged: (double range) {
                //     data.changeRange(value: range);
                //   },
                // ),
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
                          top: 15.0,
                          bottom: 15.0,
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

  static Future<String> showUnits(CarProduct item, BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (ctx) => GlobalDialog(
        header: tr('extra.units'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(item.serialNumber);
                },
                child: Container(
                  color: Colors.green,
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.productName,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        '1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              item.units != null
                  ? ListView.builder(
                      itemCount: item.units.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(item.units[index].sku);
                          },
                          child: Container(
                            color: Colors.green,
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.units[index].actualName,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Text(
                                  item.units[index].unitCount.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : SizedBox.shrink(),
              // InkWell(
              //   onTap: () {
              //     Navigator.of(context).pop();
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Padding(
              //         padding: const EdgeInsets.only(
              //           top: 15.0,
              //           bottom: 15.0,
              //         ),
              //         child: Text(
              //           tr('store.submit'),
              //           style: TextStyle(
              //             color: Colors.blue[800],
              //             fontSize: 18.0,
              //             fontFamily: 'Roboto',
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
