import 'package:eventrra/New%20Event/new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Venue/venueHomePage.dart';
import 'homePage.dart';
import 'package:eventrra/Authentication/login.dart';
import 'data.dart';
import 'package:eventrra/Authentication/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:eventrra/Authentication/authServices.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          // Initialize FlutterFire
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Error(title: 'Error From Main');
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return MyHomePage(title: 'Welcome');
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Error(title: 'Waiting');
          },
        ));
  }
}

class Error extends StatefulWidget {
  Error({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _ErrorState createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // bool venueUser(String email) {
  //   print("Inside Venue User Emails: With Length: " + venues.length.toString());
  //   for (int i = 0; i < venues.length; ++i) {
  //     print(venues[i]["Email"]);
  //     if (venues[i]["Email"].toString().toLowerCase() == email.toLowerCase()) {
  //       print("Inside Venue User Returned True");
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
    //   Scaffold(
    //   // appBar: AppBar(
    //   //   title: Center(child: Text(widget.title)),
    //   // ),
    //   body: NEvent(),
    //   // body: Center(
    //   //   child: Container(
    //   //     child: ElevatedButton(
    //   //       onPressed: () {
    //   //         Navigator.push(context,
    //   //             MaterialPageRoute(builder: (context) => LoginPage()));
    //   //       },
    //   //       child: Text("Auth"),
    //   //     ),
    //   //   ),
    //   // ),
    // );
  }
}
