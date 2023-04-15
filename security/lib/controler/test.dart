/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../firebaseService.dart';

class LocationService {
  FirebaseService _service = FirebaseService();

  Future<void> sendLocationToDatabase(context) async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();

    DocumentReference ref = _service.db.collection('location').doc();
    ref.set({
      'latitude': _locationData.latitude,
      'longitude': _locationData.longitude,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  goToMaps(double latitude, double longitude) async {
    String mapLocationUrl =
        "https://www.google.com/maps/search/?api=&query=$latitude,$longitude";
    final String ecnodedURL = Uri.encodeFull(mapLocationUrl);
    if (await canLaunchUrl(ecnodedURL as Uri)) {
      await launch(ecnodedURL);
    } else {
      print('could not launch $ecnodedURL');
      throw 'Could not launch $ecnodedURL';
    }
    }
  */
