import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:senior/driver/driverStore.dart';
import 'package:senior/sells/sellsMap.dart';
import 'package:senior/widgets/qrReader.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/stores.dart';
import '../widgets/qrReaderSells.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoresScreen extends StatefulWidget {
  final bool isSells;
  final bool isDriver;
  final List<StoresData> data;

  StoresScreen({
    this.isSells = false,
    this.isDriver = false,
    this.data,
  });

  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  LatLng latLng;
  double _lat, _long;
  @override
  Widget build(BuildContext context) {
    return widget.data.length == 0 || widget.data == null
        ? Center(
            child: Text(
              tr('extra.noTarget'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          )
        : ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (ctx, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                      subtitle: Text(
                        widget.data[index].landmark == null
                            ? ''
                            : widget.data[index].landmark,
                        overflow: TextOverflow.ellipsis,
                      ),
                      title: Text(widget.data[index].storeName),
                      trailing: Text(
                        widget.data[index].isVisited == 'true'
                            ? tr('field_force_profile.status')
                            : '',
                        style: TextStyle(color: Colors.blue),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: widget.data[index].imageIn == null
                            ? Image.asset('assets/user.png')
                            : CachedNetworkImage(
                                imageUrl: widget.data[index].imageIn,
                                width: 50.0,
                                height: 50.0,
                                fit: BoxFit.cover,
                              ),
                      ),
                      onTap: widget.data[index].isVisited == 'true'
                          ? () {}
                          : () async {
                              if (widget.isSells) {
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SellsMap(
                                        openPlace: true,
                                      ),
                                    )).then((value) {
                                  setState(() {
                                    latLng = value[0];
                                    _lat = latLng.latitude;
                                    _long = latLng.longitude;
                                    print(':::::::::::::::::::::::::::' +
                                        _lat.toString() +
                                        '    ' +
                                        _long.toString());
                                  });
                                }).whenComplete(() {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => QrReaderSells(
                                        latLng: latLng,
                                      ),
                                    ),
                                  );
                                });
                              } else {
                                if (widget.isDriver) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DriverStore(),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          QrReaderFieldForce(),
                                    ),
                                  );
                                }
                              }
                            }),
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
