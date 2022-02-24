import 'package:eventrra_managers/Authentication/signup.dart';
import 'package:eventrra_managers/Caterers/caterersHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'authServices.dart';
import 'resetPassword.dart';
import 'package:eventrra_managers/data.dart';
import 'package:eventrra_managers/Venue/venueHome.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = true, isProgressTrue = false;
  final Color textColor = Colors.white.withOpacity(0.4);

  late String email = "", password = "", error = "";
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String validate(email, password) {
    if (email == "" || password == "") return "Please fill up all the fields!";

    String emailValidatate = Validator.validateEmail(email);

    String passwordValidate = Validator.validatePassword(password);

    if (emailValidatate != "") return emailValidatate;

    if (passwordValidate != "") return passwordValidate;

    return "valid";
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: Colors.black,
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
              size: 30,
            ),
            labelText: "E-mail"),
      ),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: Colors.black,
        controller: passwordController,
        keyboardType: TextInputType.text,
        obscureText: showPassword,
        onChanged: (value) {
          setState(() {
            password = value.trim();
          });
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: Color(0xFF1B0250),
            size: 30,
          ),
          labelText: "Password",
          suffixIcon: showPassword
              ? IconButton(
                  icon: const Icon(
                    Icons.visibility_off,
                    color: Color(0xFF1B0250),
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(
                    Icons.visibility,
                    color: Color(0xFF1B0250),
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
        ),
      ),
    );
  }

  Widget _buildForgotPswd() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ResetPassPage()));
          },
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
                color: Color(0xFF1B0250),
                fontSize: 17,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 1.4 * (MediaQuery.of(context).size.height / 25),
          width: 6 * (MediaQuery.of(context).size.width / 15),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: const Color(0xFF1B0250),
              backgroundColor: const Color(0xFF1B0250),
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () async {
              try {
                String validInput = validate(email, password);
                if (validInput == "valid") {
                  setState(() {
                    isProgressTrue = true;
                  });
                  final currentUser = await auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (currentUser != null) {
                    if (currentUser.user!.emailVerified) {
                      if (venueUser(email.toString())) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VenueHome()));
                      } else if (catererUser(email.toString())) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CaterersHome()));
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                      }
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                      setState(() {
                        isProgressTrue = false;
                      });
                    }
                  } else {
                    error = "No user found with this email!";
                    AlertDialog alert = AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
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
                      content: Text(error),
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
                } else {
                  error = validInput;
                  if (error == "") error = "An error occurred";
                  AlertDialog alert = AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const <Widget>[
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
                    content: Text(error),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }
              } on FirebaseAuthException catch (e) {
                error = e.message.toString();
                setState(() {
                  AlertDialog alert = AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const <Widget>[
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
                    content: Text(error),
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
              "Login",
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

  Widget _buildSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
          child: const Text(
            "Don't have an account? Register",
            style: TextStyle(color: Color(0xFF1B0250), fontSize: 17),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginNew() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 0.65 * MediaQuery.of(context).size.width,
                child: const Image(
                  image: AssetImage("assets/images/auth_header-removebg.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
          _buildEmail(),
          //Container(child: Text("hii"),),
          _buildPassword(),
          _buildForgotPswd(),
          const SizedBox(
            height: 10,
          ),
          _buildLoginBtn(),
          const SizedBox(
            height: 10,
          ),
          _buildSignUp(),
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
          child: _buildLoginNew(),
        ),
      ),
    );
  }
}
