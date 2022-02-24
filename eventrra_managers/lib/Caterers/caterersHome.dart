import 'package:eventrra_managers/Authentication/login.dart';
import 'package:eventrra_managers/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CaterersHome extends StatefulWidget {
  @override
  _CaterersHomeState createState() => _CaterersHomeState();
}

class _CaterersHomeState extends State<CaterersHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventrra"),
        actions: [
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      // Implement From here. Use venueHome.dart
      body: Container(),
    );
  }
}
