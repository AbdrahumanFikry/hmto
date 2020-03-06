import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SeniorAdsMap extends StatefulWidget {
  @override
  _SeniorAdsMapState createState() => _SeniorAdsMapState();
}

class _SeniorAdsMapState extends State<SeniorAdsMap> {
//  Completer<GoogleMapController> _controller = Completer();
//
//  CameraPosition _initPostion = CameraPosition(
//    target: LatLng(37.42796133580664, -122.085749655962),
//    zoom: 14.4746,
//  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(31, 33),
        zoom: 9,
      ),
      minMaxZoomPreference: MinMaxZoomPreference(13, 20),
    );
  }
}
