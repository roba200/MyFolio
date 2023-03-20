import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Services/auth.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Account"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text("Notifications"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.light_mode),
            title: Text("Dark Mode"),
            trailing: Switch(
              value: false,
              onChanged: (bool value) {},
            ),
            onTap: () {},
          ),
          ElevatedButton(
              onPressed: () => Auth().signOut(), child: Text("Sign Out")),
        ],
      ),
    );
  }
}
