import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:eventrra/Authentication/signup.dart';
import 'package:eventrra/homePage.dart';
import 'package:eventrra/data.dart';
import 'package:eventrra/Venue/venueHomePage.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;
  Future<List?> sendUserData(String email, String name) async {
    final response = await http.post(
        Uri.parse("https://eventrra.000webhostapp.com/uploadUserDetails.php"),
        body: {
          "email": email,
          "name": name,
        });
    return null;
  }

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Spacer(
            flex: 1,
          ),
          SizedBox(
            height: 0.4 * height,
            width: width,
            child: Image(
              image: Image.asset("assets/images/verificationScreen.png").image,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          const CircularProgressIndicator(),
          const Spacer(
            flex: 1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "A verification link has been sent to ${user.email}",
                textAlign: TextAlign.center,
                softWrap: true,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              const Text(
                "Please Verify",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ],
          ),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }

  bool venueUser(String email) {
    for (int i = 0; i < venues.length; ++i) {
      if (venues[i]["Email"].toString().toLowerCase() == email.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      if (venueUser(user.email.toString())) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => VenueHome()));
      } else {
        sendUserData('${user.email}', name);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }
}
