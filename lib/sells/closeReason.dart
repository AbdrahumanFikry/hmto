import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/fieldForceProvider.dart';
import 'package:senior/sells/sellsNavigator.dart';
import '../forceField/forceFieldNavigator.dart';

class CloseReason extends StatelessWidget {
  final int id;
  final bool isSells;

  CloseReason({
    this.id,
    this.isSells = false,
  });

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
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'من فضلك قم بتوضيح سبب اغلاق الزياره',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.start,
                ),
                TextFormField(
                  maxLines: 7,
                  onChanged: (value) {
                    reason = value;
                    print(reason);
                  },
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
                SizedBox(
                  height: 20.0,
                ),
                Consumer<FieldForceData>(
                  builder: (context, provider, _) => provider.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : RaisedButton(
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
                          onPressed: () async {
                            try {
                              if (reason.length > 0) {
                                await provider.closeVisit(
                                  answer: reason,
                                  id: id,
                                );
                                if (isSells) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (_) => SellsNavigator(
                                          isDriver: false,
                                        ),
                                      ),
                                      (route) => false);
                                } else {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (_) => ForceFieldNavigator(),
                                      ),
                                      (route) => false);
                                }
                              }
                            } catch (e) {}
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
