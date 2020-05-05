import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:app_settings/app_settings.dart';
import 'package:senior/widgets/qrReaderSells.dart';
import '../providers/location.dart';
import '../providers/sellsProvider.dart';

class SellsMap extends StatefulWidget {
  final bool isDriver;

  SellsMap({
    this.isDriver,
  });

  @override
  _SellsMapState createState() => _SellsMapState();
}

class _SellsMapState extends State<SellsMap> {
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  String address;
  bool moved = false;
  var currentLocation = Position();
  BitmapDescriptor customIcon;

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(
        context,
        size: Size.square(12.0),
      );
      BitmapDescriptor.fromAssetImage(configuration, 'assets/transport.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  Future<String> _getAddress(Position pos) async {
    List<Placemark> placeMarks = await Geolocator()
        .placemarkFromCoordinates(pos.latitude, pos.longitude);
    if (placeMarks != null && placeMarks.isNotEmpty) {
      final Placemark pos = placeMarks[0];
//      print(':::::::::::::' + pos.thoroughfare + ', ' + pos.locality);
      address = pos.thoroughfare + ', ' + pos.locality;
      return address;
    }
    return "";
  }

  Future<void> _getLocation() async {
    currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print("BeforeRemove:" +
        'lat :' +
        currentLocation.latitude.toString() +
        '-long :' +
        currentLocation.longitude.toString());
    _getAddress(currentLocation);
    setState(() {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 9,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    initPlatformState();
    _getLocation();
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
    createMarker(context);
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
    return SafeArea(
      child: Scaffold(
        body: currentLocation == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
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
      ),
    );
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
