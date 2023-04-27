import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Completer<GoogleMapController> _controller = Completer();

  // Define variables to store the user's location
  Position? _position;
  double? _latitude;
  double? _longitude;

  // Check and request permission to access location
  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.locationWhenInUse.status;
      if (status.isDenied) {
        var result = await Permission.locationWhenInUse.request();
        if (result.isDenied) {
          return false;
        }
      }
    } else if (Platform.isIOS) {
      var status = await Permission.location.status;
      if (status.isDenied) {
        var result = await Permission.location.request();
        if (result.isDenied) {
          return false;
        }
      }
    }
    return true;
  }

  // Get the user's current location
  Future<void> _getCurrentLocation() async {
    bool permissionGranted = await _checkPermission();
    if (!permissionGranted) {
      return;
    }
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _position = position;
      _latitude = position.latitude;
      _longitude = position.longitude;
    });
  }

  @override
  void initState() {
    super.initState();
    // Get the user's current location when the page is loaded
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(_latitude ?? 0.0, _longitude ?? 0.0),
      zoom: 14,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: _latitude != null && _longitude != null
          ? GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.of([
                Marker(
                  markerId: MarkerId('user_location'),
                  position: LatLng(_latitude!, _longitude!),
                  infoWindow: InfoWindow(
                    title: 'User Location',
                    snippet: 'Latitude: $_latitude, Longitude: $_longitude',
                  ),
                ),
              ]),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
