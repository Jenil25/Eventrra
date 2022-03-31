import 'dart:async';
import 'package:eventrra/Authentication/login.dart';
import 'package:eventrra/data.dart';
import 'package:eventrra/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        currentUserEmail = "";
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        currentUserEmail = user.email.toString();
        for (int i = 0; i < users.length; ++i) {
          if (users[i]['Email'].toString().toLowerCase() ==
              user.email.toString().toLowerCase()) {
            uid = users[i]['UId'];
            currentUserName = users[i]["Name"];
            currentUserUId = users[i]['UId'];
            break;
          }
        }
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      }
    });

    return const Center(child: CircularProgressIndicator());
  }
}
