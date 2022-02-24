import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResetPassPage extends StatefulWidget {
  const ResetPassPage({Key? key}) : super(key: key);

  @override
  _ResetPassPageState createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  bool isProgressTrue = false;
  String email = "", message = "";
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            email = value.trim();
          });
        },
        decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: Color(0xFF1B0250),
            ),
            labelText: "E-mail"),
      ),
    );
  }

  Widget _buildResetBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 1.4 * (MediaQuery.of(context).size.height / 25),
          width: 8 * (MediaQuery.of(context).size.width / 15),
          child: TextButton(
            style: TextButton.styleFrom(
              elevation: 5.0,
              primary: const Color(0xFF1B0250),
              backgroundColor: const Color(0xFF1B0250),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
            onPressed: () async {
              setState(() {
                isProgressTrue = true;
              });
              try {
                await auth.sendPasswordResetEmail(email: email);
                setState(() {
                  message = "Password reset mail has been sent to ${email}.";
                  AlertDialog alert = AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          " Sent",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    content: Text(message),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                  isProgressTrue = false;
                });
                Navigator.of(context).pop();
              } catch (e) {
                message = e.toString();
                setState(() {
                  AlertDialog alert = AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        Text(
                          " Error",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    content: Text(message),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                  setState(() {
                    isProgressTrue = false;
                  });
                });
              }
            },
            child: Text(
              "Send Request",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.1,
                fontSize: MediaQuery.of(context).size.height / 43,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResetPass() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Reset Password",
                style: TextStyle(
                  color: const Color(0xFF1B0250),
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height / 25,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _buildEmail(),
          const SizedBox(
            height: 20,
          ),
          _buildResetBtn(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: isProgressTrue,
          child: _buildResetPass(),
        ),
      ),
    );
  }
}
