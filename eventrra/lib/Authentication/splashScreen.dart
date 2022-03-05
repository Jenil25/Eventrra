import 'dart:async';
import 'package:eventrra/Authentication/login.dart';
import 'package:eventrra/data.dart';
import 'package:eventrra/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:eventrra/Venue/venueHomePage.dart';
import 'package:provider/src/provider.dart';
import 'package:eventrra/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const CheckUser())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B0250),
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Spacer(
              flex: 1,
            ),
            SizedBox(
              height: 0.4 * MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: Image.asset("assets/images/auth_header.jpeg").image,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            const CircularProgressIndicator(),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            const Text(
              "Make any Occasion Unforgettable",
              softWrap: true,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            const Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}

class CheckUser extends StatelessWidget {
  const CheckUser({Key? key}) : super(key: key);

  bool checkVenueUser(var email) {
    for (var i in venues) {
      if (email.toString().toLowerCase().trim() ==
          i["Email"].toString().toLowerCase().trim()) {
        // shop_user = i;
        return true;
      }
    }
    return false;
  }

  // Future<String> getUserScreen() async {
  //   // Future<bool> f = true as Future<bool>;
  //   print("Here");
  //   Future<String> s = "a" as Future<String>;
  //   // String screen = "";
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       userEmail = "";
  //       // return LoginPage();
  //     } else {
  //       // userLoggedIn = true;
  //       // print("UserLoggedIn = true");
  //       userEmail = user.email.toString();
  //       print("here");
  //       if (checkVenueUser(userEmail)) {
  //         print("CheckVenueUser = true");
  //         // venueUser = true;
  //         // screen = "Venue";
  //         s = "Venue" as Future<String>;
  //         // return s;
  //         print("returned!");
  //       }
  //       // print(user.email);
  //       // // while (venues.isEmpty) {
  //       // //   print("S");
  //       // // }
  //       // if (venueUser(user.email.toString())) {
  //       //   // print('Venue User is currently signed in!');
  //       //   Navigator.push(
  //       //       context, MaterialPageRoute(builder: (context) => VenueHome()));
  //       // } else {
  //       //   // print('User is already currently signed in!');
  //       //   Navigator.push(
  //       //       context, MaterialPageRoute(builder: (context) => HomePage()));
  //       // }
  //     }
  //   });
  //   return s;
  //   // return screen;
  // }

  void dd() {}

  // void getUserScreen() async {
  //   // Future<bool> f = true as Future<bool>;
  //   print("Here");
  //   // Future<String> s = "a" as Future<String>;
  //   // String screen = "";
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       userEmail = "";
  //       // return LoginPage();
  //     } else {
  //       // userLoggedIn = true;
  //       // print("UserLoggedIn = true");
  //       userEmail = user.email.toString();
  //       print("here");
  //       if (checkVenueUser(userEmail)) {
  //         Navigator.of(context)
  //             .push(MaterialPageRoute(builder: (context) => VenueHome()));
  //         print("CheckVenueUser = true");
  //         // venueUser = true;
  //         // screen = "Venue";
  //         // s = "Venue" as Future<String>;
  //         // return s;
  //         print("returned!");
  //       }
  //       // print(user.email);
  //       // // while (venues.isEmpty) {
  //       // //   print("S");
  //       // // }
  //       // if (venueUser(user.email.toString())) {
  //       //   // print('Venue User is currently signed in!');
  //       //   Navigator.push(
  //       //       context, MaterialPageRoute(builder: (context) => VenueHome()));
  //       // } else {
  //       //   // print('User is already currently signed in!');
  //       //   Navigator.push(
  //       //       context, MaterialPageRoute(builder: (context) => HomePage()));
  //       // }
  //     }
  //   });
  //   // Future<void> f;
  //   return d;
  //   // return screen;
  // }

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = false, venueUser = false;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        userEmail = "";
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        // userLoggedIn = true;
        // print("UserLoggedIn = true");
        userEmail = user.email.toString();
        print("here");
        if (checkVenueUser(userEmail)) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => VenueHome()));
          print("CheckVenueUser = true");
          // venueUser = true;
          // screen = "Venue";
          // s = "Venue" as Future<String>;
          // return s;
          print("returned!");
        } else {

          for (int i = 0; i < users.length; ++i) {
              if(users[i]['Email'].toString().toLowerCase() == user.email.toString().toLowerCase())
              {
                uid=users[i]['UId'];
                break;
              }
            }
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
        }
        // print(user.email);
        // // while (venues.isEmpty) {
        // //   print("S");
        // // }
        // if (venueUser(user.email.toString())) {
        //   // print('Venue User is currently signed in!');
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => VenueHome()));
        // } else {
        //   // print('User is already currently signed in!');
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => HomePage()));
        // }
      }
    });

    return const Center(child: CircularProgressIndicator());
    // return FutureBuilder(
    //   // Initialize FlutterFire
    //   future: getUserScreen(),
    //   builder: (context, snapshot) {
    //     // Check for errors
    //     if (snapshot.hasError) {
    //       print("SnapShot Errors:");
    //       print(snapshot);
    //       return MaterialApp(
    //         // title: 'Flutter Demo',
    //         theme: ThemeData(
    //           primarySwatch: Colors.blue,
    //         ),
    //         home: Error(title: 'Error From snapshot.haserror in splashSceen'),
    //       );
    //     }
    //
    //     // Once complete, show your application
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         home: MaterialApp(
    //           // title: 'Flutter Demo',
    //           theme: ThemeData(
    //             primarySwatch: Colors.blue,
    //           ),
    //           home: MyHomePage(title: 'Welcome'),
    //         ),
    //       );
    //     }
    //
    //     // Otherwise, show something whilst waiting for initialization to complete
    //     return MaterialApp(
    //       // title: 'Flutter Demo',
    //       theme: ThemeData(
    //         primarySwatch: Colors.blue,
    //       ),
    //       home: Error(title: 'Waiting'),
    //     );
    //   },
    // );
    // if (userLoggedIn) {
    //   print("If HomePage");
    //   return HomePage();
    // } else if (venueUser) {
    //   print("Else If VenueHome");
    //   return VenueHome();
    // } else {
    //   print("Else LoginPage");
    //   return LoginPage();
    // }
    // return userEmail == "" ? VenueHome() : HomePage();
  }
}
