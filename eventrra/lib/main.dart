import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data.dart';
import 'package:eventrra/Authentication/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Root of the application.
  @override
  Widget build(BuildContext context) {
    getUsers();
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
            return const MyHomePage(title: 'Welcome');
          }
          return const Error(title: 'Waiting');
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
    return Text(widget.title);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
