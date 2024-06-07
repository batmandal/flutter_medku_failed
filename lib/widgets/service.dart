import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  const Service({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.red),
      child: ListTile(
        leading: Image.asset("assets/cars/Standart.png"),
        title: Text("yuen lalra"),
        subtitle: Text("timu lalra"),
        trailing: Text("1500"),
      ),
    );
  }
}
