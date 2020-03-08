import 'package:flutter/material.dart';

class TestStoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Molto (30 PCS)',style: TextStyle(
          fontSize: 22.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.monetization_on,color: Colors.green,size: 30.0,),
                Text('5 EGP (total:20 EGP)',style: TextStyle(color: Colors.grey,fontSize: 20.0),),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.add_shopping_cart,size: 30.0,),
                Icon(Icons.remove_shopping_cart,size: 30.0,),
              ],
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(Icons.store,color: Colors.green,size: 30.0,),
            Text('5 PTS (total:20 PTS)',style: TextStyle(color: Colors.grey,fontSize: 20.0),),
          ],
        ),
        Divider(),

      ],
    );
  }
}
