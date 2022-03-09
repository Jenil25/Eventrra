import 'dart:async';
import 'package:eventrra_managers/Authentication/login.dart';
import 'package:eventrra_managers/Caterers/caterersHome.dart';
import 'package:eventrra_managers/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eventrra_managers/Venue/venueHome.dart';

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
      backgroundColor: Colors.white,
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
                image:
                    Image.asset("assets/images/auth_header-removebg.png").image,
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

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        userEmail = "";
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        if (user.emailVerified) {
          userEmail = user.email.toString();
          if (venueUser(userEmail)) {

            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const VenueHome()));
          } else if (catererUser(userEmail)) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => CaterersHome()));
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()));
          }
        } else {
          //(For Jenil) => Try to delete User
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        }
      }
    });

    return const Center(child: CircularProgressIndicator());
  }
}
