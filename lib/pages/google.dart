import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:medku/models/service_model.dart';
import 'package:medku/pages/menu.dart';
// import 'package:medku/widgets/service.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

final services = [
  ServiceModel(
      image: "assets/cars/Simple.png",
      title: "Simple",
      description: "Илүү хүртээмжтэй",
      price: 1500),
  ServiceModel(
      image: "assets/cars/Standart.png",
      title: "Standart",
      description: "1-р эгнээгээр зорчдог",
      price: 1500),
  ServiceModel(
      image: "assets/cars/Black.png",
      title: "Black",
      description: "Ая тухтай",
      price: 1500),
  ServiceModel(
      image: "assets/cars/Simple.png",
      title: "Minivan",
      description: "Илүү хүртээмжтэй",
      price: 1500),
];

class _GoogleMapPageState extends State<GoogleMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(options: MapOptions(), children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            )
          ]),
          Column(
            children: [
              SafeArea(
                  child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenuPage())),
                        icon: Icon(Icons.menu)),
                  ),
                  const Column(
                    children: [],
                  )
                ],
              ))
            ],
          ),
          DraggableScrollableSheet(
            maxChildSize: 0.7,
            initialChildSize: 0.2,
            minChildSize: 0.2,
            shouldCloseOnMinExtent: false,
            snap: true,
            builder: (context, controller) => Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(16),
                        topEnd: Radius.circular(16))),
                child: ListView.builder(
                    itemCount: services.length,
                    controller: controller,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return buildService(service);
                    })),
          )
        ],
      ),
    );
  }

  Widget buildService(ServiceModel service) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.red),
        child: ListTile(
          leading: Image.asset(service.image),
          title: Text(service.title),
          subtitle: Text(service.description),
          trailing: Text("${service.price}"),
        ),
      );
}
