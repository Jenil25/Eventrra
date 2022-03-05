import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eventrra_managers/Authentication/authServices.dart';
import 'verificationScreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool showPassword = true,
      showConfirmPassword = true,
      isProgressTrue = false,
      _chooseatype = true;
  String name = "",
      email = "",
      password = "",
      confirmPassword = "",
      error = "",
      passwordValidate = "a",
      nameValidate = "a";

  final List<DropdownMenuItem> _dropdownTestItems = [
    const DropdownMenuItem(
      value: "Venue",
      child: Text("Venue"),
    ),
    const DropdownMenuItem(
      value: "Caterers",
      child: Text("Caterers"),
    ),
  ];

  var _selectedTest = null;

  final TextEditingController textController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  onChangeDropdownTests(selectedTest) {
    setState(() {
      _chooseatype = false;
      _selectedTest = selectedTest;
    });
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: Colors.black,
        controller: textController,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            name = value.trim();
          });
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Color(0xFF1B0250),
            size: 30,
          ),
          labelText: "Name",
        ),
      ),
    );
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
          labelText: "E-mail",
        ),
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

  Widget _buildConfirmPassword() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: confirmPasswordController,
        keyboardType: TextInputType.text,
        obscureText: showConfirmPassword,
        onChanged: (value) {
          setState(() {
            confirmPassword = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.lock,
            color: Color(0xFF1B0250),
            size: 30,
          ),
          labelText: "Confirm Password",
          suffixIcon: showConfirmPassword
              ? IconButton(
                  icon: const Icon(
                    Icons.visibility_off,
                    color: Color(0xFF1B0250),
                  ),
                  onPressed: () {
                    setState(() {
                      showConfirmPassword = !showConfirmPassword;
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
                      showConfirmPassword = !showConfirmPassword;
                    });
                  },
                ),
        ),
      ),
    );
  }

  Widget _buildContactNumber() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: contactNoController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.phone,
            color: Color(0xFF1B0250),
            size: 30,
          ),
          labelText: "Contact Number",
        ),
      ),
    );
  }

  String validate() {
    if (name == "" ||
        email == "" ||
        password == "" ||
        confirmPassword == "" ||
        _selectedTest == null) {
      return "Please enter all the values!";
    }

    String passwordValidate = Validator.validatePassword(password);
    String nameValidate = Validator.validateName(name);
    String emailValidate = Validator.validateEmail(email);

    if (passwordValidate != "") return passwordValidate;

    if (nameValidate != "") return nameValidate;

    if (emailValidate != "") return emailValidate;

    if (password != confirmPassword) {
      return "Passwords do not match!";
    }

    return "valid";
  }

  Widget _buildSignUpBtn() {
    return SizedBox(
      height: 1.5 * (MediaQuery.of(context).size.height / 25),
      width: 6 * (MediaQuery.of(context).size.width / 15),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: const Color(0xFF1B0250),
          backgroundColor: const Color(0xFF1B0250),
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        onPressed: () async {
          try {
            String validInput = validate();
            if (validInput == "valid") {
              final newUser = await auth.createUserWithEmailAndPassword(
                  email: email, password: password);
              if (newUser != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerifyScreen(
                            type: _selectedTest.toString().toLowerCase(),
                            name: name,
                            email: email,
                            contactNo: contactNoController.text)));
                setState(() {
                  isProgressTrue = false;
                });
              }
            } else {
              setState(() {
                isProgressTrue = true;
              });
              error = validInput;
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
              isProgressTrue = false;
            });
          }
        },
        child: Text(
          "Register",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.1,
            fontSize: MediaQuery.of(context).size.height / 43,
          ),
        ),
      ),
    );
  }

  Widget _buildDropDown() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, bottom: 15),
            child: Text(
              _chooseatype ? "Choose" : "",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Colors.grey,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        DropdownBelow(
          itemWidth: 200,
          itemTextstyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          boxTextstyle: const TextStyle(fontSize: 16, color: Colors.black),
          boxPadding: const EdgeInsets.fromLTRB(13, 18, 0, 12),
          boxHeight: 45,
          boxWidth: 200,
          hint: null,
          value: _selectedTest,
          items: _dropdownTestItems,
          onChanged: onChangeDropdownTests,
        ),
      ],
    );
  }

  Widget _buildSignUp() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 650,
          width: MediaQuery.of(context).size.width,
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
                      image:
                          AssetImage("assets/images/auth_header-removebg.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  _buildName(),
                  _buildEmail(),
                  _buildContactNumber(),
                  _buildPassword(),
                  _buildConfirmPassword(),
                  _buildDropDown(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _buildSignUpBtn(),
            ],
          ),
        ),
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
          child: _buildSignUp(),
        ),
      ),
    );
  }
}
