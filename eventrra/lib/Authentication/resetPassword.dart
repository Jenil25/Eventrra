import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'frostedglass.dart';

class ResetPassPage extends StatefulWidget {
  @override
  _ResetPassPageState createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  bool isProgressTrue = false;
  late String email, error;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
//        onSaved: (value) => email = value,
//        validator: EmailValidator.validate,
        onChanged: (value) {
          setState(() {
            email = value.trim();
          });
        },
        decoration: const InputDecoration(
            prefixIcon: const Icon(
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
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 25),
          width: 8 * (MediaQuery.of(context).size.width / 15),
          child: RaisedButton(
            onPressed: () async {
              setState(() {
                isProgressTrue = true;
              });
              try {
                await auth.sendPasswordResetEmail(email: email);
                setState(() {
                  error = "Password reset mail has been sent to ${email}.";
                  AlertDialog alert = AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          " Sent",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    content: Text(error),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                  isProgressTrue = false;
                });
//              context.read<AuthenticationService>().sendPasswordResetEmail(emailController.text);
                Navigator.of(context).pop();
              } catch (e) {
                print(e);
                error = e.toString();
                setState(() {
                  AlertDialog alert = AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        const Text(
                          " Error",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    content: Text(error),
//                    actions: [
//                      FlatButton(
//                        child: Text("OK"),
//                        onPressed: () {
//                          setState(() {
//                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
//                          });
//                        },
//                      )
//                    ],
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
            elevation: 5.0,
            color: const Color(0xFF1B0250),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
    Size size = MediaQuery.of(context).size;
    double contWidth = size.width * 0.90;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1B0250),
        // resizeToAvoidBottomPadding: false,
        body: ModalProgressHUD(
          inAsyncCall: isProgressTrue,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset("assets/images/logo_wp1.png").image,
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildResetPass(),
                        ],
                      ),
                    ),
                  ),
                  // FrostedGlassBox(
                  //   width: contWidth,
                  //   height: contWidth,
                  //   child: Center(
                  //     child: Padding(
                  //       padding: EdgeInsets.all(10.0),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           _buildResetPass(),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
