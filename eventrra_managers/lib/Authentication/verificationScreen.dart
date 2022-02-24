import 'package:eventrra_managers/Caterers/registerCaterers.dart';
import 'package:eventrra_managers/Venue/registerVenue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class VerifyScreen extends StatefulWidget {
  final type, name, email, contactNo;
  const VerifyScreen(
      {Key? key,
      required this.type,
      required this.name,
      required this.email,
      required this.contactNo})
      : super(key: key);

  @override
  _VerifyScreenState createState() =>
      _VerifyScreenState(type, name, email, contactNo);
}

class _VerifyScreenState extends State<VerifyScreen> {
  final type, name, email, contactNo;
  _VerifyScreenState(this.type, this.name, this.email, this.contactNo);

  final FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
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

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      if (type == "venue") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterVenue(
                    name: name, email: email, contactNo: contactNo)));
      } else if (type == "caterers") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterCaterers(
                    name: name, email: email, contactNo: contactNo)));
      }
    }
  }
}
