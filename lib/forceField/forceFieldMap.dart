import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:senior/forceField/addStore.dart';
import 'package:app_settings/app_settings.dart';
import '../providers/location.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/fieldForceProvider.dart';

class ForceFieldMap extends StatefulWidget {
  @override
  _ForceFieldMapState createState() => _ForceFieldMapState();
}

class _ForceFieldMapState extends State<ForceFieldMap> {
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  String address;
  var currentLocation = Position();
  BitmapDescriptor customIcon;

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/marker.png')
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
    _getAddress(currentLocation);
    setState(() {
      _markers.clear();
      final marker = Marker(
        icon: customIcon,
        onTap: () {
          print(currentLocation.latitude.toString());
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AdsAddStore(
                lat: currentLocation.latitude,
                long: currentLocation.longitude,
                address: address,
              ),
            ),
          );
        },
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: tr('map.marker_info')),
      );
      setState(() {
        _markers["Current Location"] = marker;
      });
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 20,
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
    Provider.of<FieldForceData>(context, listen: false)
        .stores
        .data
        .forEach((store) {
      final marker = Marker(
        markerId: MarkerId(store.id.toString()),
        position:
            LatLng(double.tryParse(store.lat), double.tryParse(store.long)),
        infoWindow: InfoWindow(title: store.storeName),
      );
      _markers[store.id.toString()] = marker;
    });
    print(":::::::::::::::::::::" + _markers.length.toString());
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
                  Positioned(
                    bottom: 80.0,
                    right: 20.0,
                    child: currentLocation.latitude == null ||
                            currentLocation.latitude == null
                        ? CircularProgressIndicator()
                        : FloatingActionButton(
                            onPressed: () async {
                              setState(() {
                                currentLocation = Position();
                              });
                              await _getLocation();
                              await _getAddress(currentLocation);
                            },
                            tooltip: 'Get Location',
                            child: Icon(
                              Icons.location_searching,
                              color: Colors.white,
                            ),
                          ),
                  )
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
