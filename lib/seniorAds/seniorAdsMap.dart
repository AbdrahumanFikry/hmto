import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:senior/addStore.dart';

class SeniorAdsMap extends StatefulWidget {
  @override
  _SeniorAdsMapState createState() => _SeniorAdsMapState();
}

class _SeniorAdsMapState extends State<SeniorAdsMap> {
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  var currentLocation = Position();
  Completer<GoogleMapController> _controller = Completer();

  Future<String> _getAddress(Position pos) async {
    List<Placemark> placeMarks = await Geolocator()
        .placemarkFromCoordinates(pos.latitude, pos.longitude);
    if (placeMarks != null && placeMarks.isNotEmpty) {
      final Placemark pos = placeMarks[0];
      print(':::::::::::::' + pos.thoroughfare + ', ' + pos.locality);
      return pos.thoroughfare + ', ' + pos.locality;
    }
    return "";
  }

  void _getLocation() async {
    currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _markers.clear();
      final marker = Marker(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AdsAddStore(),
            ),
          );
        },
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 30,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _getLocation();
            _getAddress(currentLocation);
          },
          tooltip: 'Get Location',
          child: Icon(
            Icons.location_searching,
            color: Colors.white,
          ),
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
