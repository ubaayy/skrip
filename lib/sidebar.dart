import 'package:belajar_flutter/ResepPage.dart';
import 'package:flutter/material.dart';
import 'ResepPage.dart';
import 'main.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'Menu Sidebar',
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 24,
              ),
            )
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Resep'),
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => ResepPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
              },
            )
        ],
      ),
    );
  }
}