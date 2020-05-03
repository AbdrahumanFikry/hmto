import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:senior/forceField/addStore.dart';
import 'package:app_settings/app_settings.dart';
import 'package:senior/widgets/qrReader.dart';
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
  bool moved = false;
  var currentLocation = Position();
  BitmapDescriptor customIcon;

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(
        context,
        size: Size.square(12.0),
      );
      BitmapDescriptor.fromAssetImage(configuration, 'assets/add.png')
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
      _markers.clear();
      final marker = Marker(
        draggable: true,
        onDragEnd: ((value) {
          setState(() {
            moved = true;
          });
          currentLocation = Position(
            latitude: value.latitude,
            longitude: value.longitude,
          );
          _getAddress(currentLocation);
        }),
        icon: customIcon,
        onTap: () {
          print('AfterRemove :' +
              'lat :' +
              currentLocation.latitude.toString() +
              '-long :' +
              currentLocation.longitude.toString() +
              '-address :' +
              address);

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
      if (store.lat != null && store.long != null && store.id != null) {
        final marker = Marker(
          markerId: MarkerId(store.id.toString()),
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
                builder: (context) => QrReaderFieldForce(),
              ),
            );
          },
        );
        _markers[store.id.toString()] = marker;
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
                  ),
                  Positioned(
                    top: 10.0,
                    left: 10,
                    child: moved
                        ? SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                FontAwesomeIcons.solidLightbulb,
                                color: Colors.yellow,
                                size: 20.0,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                tr('extra.mapHint'),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                softWrap: true,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
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
