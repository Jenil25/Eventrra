import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data.dart';
import 'package:eventrra_managers/Authentication/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getCities();
    getAddresses();
    getVenues();
    getOrchestra();
    getDecoraters();
    getCaterers();
    getEventTypes();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Error(title: 'Error From Main');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return const SplashScreen();
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text("Waiting"),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class Error extends StatefulWidget {
  const Error({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _ErrorState createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: Text(widget.title),
    );
  }
}
