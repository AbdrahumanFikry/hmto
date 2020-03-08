import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SeniorMap extends StatefulWidget {
  @override
  _SeniorMapState createState() => _SeniorMapState();
}

class _SeniorMapState extends State<SeniorMap> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
//          markers: navigationLogic.markers[navigationLogic.markersIndex],
          initialCameraPosition:
              CameraPosition(target: LatLng(31.0998217, 29.7532233), zoom: 13),
          minMaxZoomPreference: MinMaxZoomPreference(13, 20),
          cameraTargetBounds: CameraTargetBounds(LatLngBounds(
              southwest: LatLng(31.0998217, 29.7532233),
              northeast: LatLng(31.0998217, 29.7532233))),
        ),
        Align(
          alignment: Alignment(0, -0.9),
          child: ToggleButtons(
            splashColor: Colors.white,
            constraints: BoxConstraints.tight(Size(55, 40)),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            focusColor: Colors.green,
            color: Colors.black38,
            selectedBorderColor: Colors.black.withOpacity(0.2),
            borderColor: Colors.black.withOpacity(0.2),
            selectedColor: Colors.green,
            fillColor: Colors.white,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.user,
              ),
              Icon(
                FontAwesomeIcons.store,
              ),
              Icon(
                FontAwesomeIcons.warehouse,
              ),
            ],
            onPressed: (index) {},
            isSelected: [false, false, false],
          ),
        ),
      ],
    );
  }
}
