import 'package:flutter/material.dart';
import 'package:senior/sells/sellsNavigator.dart';

class CloseReason extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String reason = '';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'سبب الاغلاق',
            style: TextStyle(color: Colors.green),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'من فضلك قم بتوضيح سبب اغلاق الزياره',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            TextFormField(
              maxLines: 5,
              onChanged: (value) => reason = value,
              initialValue: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                hintText: 'ضع السبب هنا',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            RaisedButton(
              color: Colors.green,
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Text(
                'اغلاق',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => SellsNavigator(
                        isDriver: false,
                      ),
                    ),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
