import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class CanPage extends StatefulWidget {
  const CanPage({super.key});

  @override
  State<CanPage> createState() => _CanPageState();
}

class _CanPageState extends State<CanPage> {
  void getlocation() async {
    LocationPermission per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied ||
        per == LocationPermission.deniedForever) {
      print("permission denied");
      // LocationPermission per1 = await Geolocator.requestPermission();
    } else {
      Position currentLoc = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        print(currentLoc);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
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
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  // urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  // userAgentPackageName: "dev.fleaflet.flutter_map.example",
                  // subdomains: const ['a', 'b', 'c'],
                ),
              ]),
          ElevatedButton(
            onPressed: () {
              getlocation();
            },
            child: const Text("get loction"),
          ),
          // GestureDetector()
        ],
      ),
    );
  }
}
