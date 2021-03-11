import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/sellsProvider.dart';

class MyCartItem extends StatelessWidget {
  final int index;

  MyCartItem({
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SellsData>(
      builder: (context, data, _) {
        print(data.loadedItems[index].quantity);
        print(data.loadedItems[index].units[0].unitCount);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      data.loadedItems[index].productName,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  '${tr('other.qty')} : ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '( ${(data.loadedItems[index].quantity ~/ data.loadedItems[index].units[0].unitCount).toString()} )' +
                                data.loadedItems[index]?.units[0]?.actualName ??
                            '',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        '( ${(data.loadedItems[index].quantity % data.loadedItems[index].units[0].unitCount).toString()} )' +
                            tr('store.piece'),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   itemCount: data.loadedItems[index].units.length,
                      //   itemBuilder: (ctx, i) => Text(
                      //     '( ${(data.loadedItems[index].quantity ~/ data.loadedItems[index].units[i].unitCount).toString()} )' +
                      //             data.loadedItems[index]?.units[i]?.actualName ??
                      //         '',
                      //     style: TextStyle(
                      //       color: Colors.grey,
                      //       fontSize: 16.0,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
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
                  '${tr('senior_profile.egp')} :' +
                      data.loadedItems[index].priceForEach.toString(),
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
        );
      },
    );
  }
}
