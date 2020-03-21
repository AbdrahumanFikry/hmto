import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CartScreenItem extends StatefulWidget {
  final bool isReady;

  CartScreenItem({
    this.isReady = false,
  });

  @override
  _CartScreenItemState createState() => _CartScreenItemState();
}

class _CartScreenItemState extends State<CartScreenItem> {
  int qnt = 1;

  @override
  Widget build(BuildContext context) {
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
                  'Molto',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            Spacer(),
            widget.isReady
                ? SizedBox(
                    width: 1,
                  )
                : Icon(
                    Icons.cancel,
                    size: 20.0,
                  )
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
              '5 ' + tr('senior_profile.egp'),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        widget.isReady
            ? Row(
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
                    '${tr('other.qty')} :' + qnt.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  Spacer(),
                ],
              )
            : Row(
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
                    '${tr('other.qty')} :' + qnt.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      if (qnt != 1) {
                        setState(() {
                          qnt--;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        qnt++;
                      });
                    },
                  ),
                ],
              ),
        Divider(),
      ],
    );
  }
}
