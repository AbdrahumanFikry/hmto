import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:app_settings/app_settings.dart';
import 'package:senior/widgets/qrReaderSells.dart';
import '../providers/location.dart';
import '../providers/sellsProvider.dart';

class SellsMap extends StatefulWidget {
  @override
  _SellsMapState createState() => _SellsMapState();
}

class _SellsMapState extends State<SellsMap> {
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    if (Provider.of<GPS>(context, listen: false).locationOn == false) {
      AppSettings.openLocationSettings();
      Provider.of<GPS>(context, listen: false).locationOn = true;
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SellsData>(context, listen: false).stores.data.forEach((store) {
      if (store.lat != null && store.long != null && store.id != null) {
        final marker = Marker(
          markerId: MarkerId(store.storeName),
          position: LatLng(
              double.tryParse(store.lat) == null
                  ? 120.000
                  : double.tryParse(store.lat),
              double.tryParse(store.long) == null
                  ? 120.000
                  : double.tryParse(store.long)),
          infoWindow: InfoWindow(title: store.storeName),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => QrReaderSells(),
              ),
            );
          },
        );
        _markers[store.storeName] = marker;
      }
    });
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(31.037933, 31.381523),
              zoom: 5.0,
            ),
            markers: _markers.values.toSet(),
          ),
        ],
      ),
    );
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
