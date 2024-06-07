import 'package:flutter/material.dart';
import 'package:medku/models/settings_model.dart';

final configurations = [
  SettingsModel(
      startIcon: Icon(Icons.menu),
      title: "information",
      endIcon: Icon(Icons.logout)),
  SettingsModel(
      startIcon: Icon(Icons.menu),
      title: "notification",
      endIcon: Icon(Icons.logout)),
  SettingsModel(
      startIcon: Icon(Icons.menu),
      title: "wallet",
      endIcon: Icon(Icons.logout)),
  SettingsModel(
      startIcon: Icon(Icons.menu), title: "card", endIcon: Icon(Icons.logout)),
  SettingsModel(
      startIcon: Icon(Icons.menu),
      title: "invite friend",
      endIcon: Icon(Icons.logout)),
  SettingsModel(
      startIcon: Icon(Icons.menu),
      title: "emergency number",
      endIcon: Icon(Icons.logout)),
  SettingsModel(
      startIcon: Icon(Icons.menu),
      title: "my travels",
      endIcon: Icon(Icons.logout)),
  SettingsModel(
      startIcon: Icon(Icons.menu), title: "order", endIcon: Icon(Icons.logout)),
  SettingsModel(
      startIcon: Icon(Icons.menu),
      title: "service situation",
      endIcon: Icon(Icons.logout)),
  SettingsModel(
      startIcon: Icon(Icons.menu), title: "help", endIcon: Icon(Icons.logout)),
];

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: configurations.length,
          itemBuilder: (context, index) {
            final config = configurations[index];
            return settingsBuild(config);
          }),
    );
  }

  Widget settingsBuild(SettingsModel config) => ListTile(
      leading: config.startIcon,
      title: Text(config.title),
      trailing: config.endIcon);
}
