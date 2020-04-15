import 'package:flutter/material.dart';
import 'package:senior/driver/driverStore.dart';
import 'package:senior/sells/testStore.dart';
import 'package:senior/widgets/qrReader.dart';
import '../forceField/store.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/stores.dart';

class StoresScreen extends StatelessWidget {
  final bool isSells;
  final bool isDriver;
  final List<Data> data;

  StoresScreen({
    this.isSells = false,
    this.isDriver = false,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: Text(
                data[index].landmark,
                overflow: TextOverflow.ellipsis,
              ),
              title: Text(data[index].storeName),
              trailing: Text(
                data[index].isVisited == true
                    ? tr('field_force_profile.status')
                    : '',
                style: TextStyle(color: Colors.blue),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Image.network(
                  data[index].imageIn,
                  height: 50.0,
                  width: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                isSells
                    ? Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QrReader(whereTo: TestStore()),
                        ),
                      )
                    : isDriver
                        ? Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DriverStore(),
                            ),
                          )
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => QrReader(
                                      whereTo: Store(),
                                    )),
                          );
              },
            ),
            Divider(
              height: 2,
              indent: 0,
              endIndent: 50,
            )
          ],
        );
      },
    );
  }
}
