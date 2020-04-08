import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:senior/driver/driverStore.dart';
import 'package:senior/sells/testStore.dart';
import 'package:senior/widgets/qrReader.dart';
import '../forceField/store.dart';
import 'package:easy_localization/easy_localization.dart';

class StoresScreen extends StatelessWidget {
  final bool isSells;
  final bool isDriver;

  StoresScreen({this.isSells = false, this.isDriver = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (ctx, index) {
        return index == 4
            ? isDriver
                ? null
                : Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          tr('field_force_profile.extra'),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 30.0,
                          ),
                        ),
                        onTap: () {
                          isSells
                              ? Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        QrReader(whereTo: TestStore()),
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
                                        ),
                                      ),
                                    );
                        },
                      ),
                      Divider(
                        height: 2,
                        indent: 0,
                        endIndent: 50,
                      )
                    ],
                  )
            : Column(
                children: <Widget>[
                  ListTile(
                    subtitle: Text('Has created count market'),
                    title: Text('info'),
                    trailing: Text(
                      tr('field_force_profile.status'),
                      style: TextStyle(color: Colors.blue),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            'https://specials-images.forbesimg.com/imageserve/5d2893a234a5c400084b2955/1920x0.jpg?cropX1=29&cropX2=569&cropY1=20&cropY2=560',
                        width: 50.0,
                        height: 50.0,
                      ),
                    ),
                    onTap: () {
                      isSells
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    QrReader(whereTo: TestStore()),
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
                                    builder: (context) =>
                                        QrReader(whereTo: Store()),
                                  ),
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