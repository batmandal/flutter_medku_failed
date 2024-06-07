import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
// import 'package:maps/functions.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? _currentAddress;
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Page")),
      body: SafeArea(
        child: Center(
          child: Stack(children: [
            FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(47.918852, 106.917688),
                  initialZoom: 16,
                  interactionOptions: InteractionOptions(
                    flags: ~InteractiveFlag.doubleTapZoom,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    // userAgentPackageName: "dev.fleaflet.flutter_map.example",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                Text('ADDRESS: ${_currentAddress ?? ""}'),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    _currentPosition =
                        await LocationHandler.getCurrentPosition();
                    _currentAddress =
                        await LocationHandler.getAddressFromLatLng(
                            _currentPosition!);
                    setState(() {});
                  },
                  child: const Text("Get Current Location"),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

abstract class LocationHandler {
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled. Please enable the services
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are denied
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied, we cannot request permissions.

      return false;
    }
    return true;
  }

  static Future<Position?> getCurrentPosition() async {
    try {
      final hasPermission = await handleLocationPermission();
      if (!hasPermission) return null;
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return null;
    }
  }

  static Future<String?> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarks[0];
      return "${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}";
    } catch (e) {
      return null;
    }
  }
}
