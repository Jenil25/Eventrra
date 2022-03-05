import 'dart:ui';
import 'package:eventrra/Authentication/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'authServices.dart';
import 'package:eventrra/homePage.dart';
import 'resetPassword.dart';
import 'package:eventrra/data.dart';
import 'package:eventrra/Venue/venueHomePage.dart';

import 'verificationScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool showPassword = true, isProgressTrue = false;
  final Color textColor = Colors.white.withOpacity(0.4);

  late String email, password, error, emailValidate, passwordValidate;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User user;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
            color: const Color(0xFF1B0250),
            size: 30,
          ),
          labelText: "Password",
          suffixIcon: showPassword
              ? IconButton(
                  icon: const Icon(
                    Icons.visibility_off,
                    color: const Color(0xFF1B0250),
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                )
              : IconButton(
                  icon: Container(
                    child: const Icon(
                      Icons.visibility,
                      color: const Color(0xFF1B0250),
                    ),
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
        FlatButton(
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
    // bool checkShopUser(var email) {
    //   for (var i in shops) {
    //     if (email == i["s_email"]) {
    //       return true;
    //     }
    //   }
    //   return false;
    // }

    // bool checkDeliveryUser(var email) {
    //   print("inside checkDeliveryUser");
    //   print("After func call");
    //   for (var i = 0; i < deliveryemail.length; i++) {
    //     print("Inside for");
    //     if (email == deliveryemail[i]["dp_email"]) {
    //       print("Got user in delivery");
    //       return true;
    //     }
    //   }
    //   return false;
    // }

    bool venueUser(String email) {
      print("Inside Venue User");
      for (int i = 0; i < venues.length; ++i) {
        if (venues[i]["Email"].toString().toLowerCase() ==
            email.toLowerCase()) {
          print("Inside Venue User Returned True");
          return true;
        }
      }
      return false;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 25),
          width: 6 * (MediaQuery.of(context).size.width / 15),
          child: ElevatedButton(
            // elevation: 10.0,
            // color: const Color(0xFF1B0250),
            // shape:
            //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () async {
              try {
                // print("${email},${password}");
                passwordValidate = PasswordValidator.validate(password);
                if (passwordValidate == "" || passwordValidate == null) {
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
                                builder: (context) => VenueHome()));
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      }
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const VerifyScreen()));
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
                  error = passwordValidate;
                  if (error == null || error == "") error = "An error occured";
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
                print(e.message.toString());
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
              Container(
                width: 0.65 * MediaQuery.of(context).size.width,
                child: const Image(
                  image: AssetImage("assets/images/auth_header.jpeg"),
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

//  Widget _buildLogin(){
//    return Padding(
//      padding: const EdgeInsets.symmetric(vertical: 200,
//        horizontal: 50,
//      ),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          ClipRRect(
//            borderRadius: BorderRadius.all(
//              Radius.circular(40),
//            ),
//            child: FadeAnimation(2, Container(
//              height: MediaQuery.of(context).size.height*0.55,
//              width: MediaQuery.of(context).size.width*0.8,
//              color: Colors.white,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Text("Login",style: TextStyle(
//                        color: Colors.blue,
//                        fontWeight: FontWeight.bold,
//                        fontSize: MediaQuery.of(context).size.height/25,
//                      ),
//                      ),
//                    ],
//                  ),
//                  _buildEmail(),
//                  _buildPassword(),
//                  _buildForgotPswd(),
//                  SizedBox(height: 10,),
//                  _buildLoginBtn(),
//                  SizedBox(height: 10,),
//                  _buildSignUp(),
//                ],
//              ),
//            ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double contWidth = size.width * 0.90;
    double contHeight = size.height * 0.60;
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildLoginNew(),
                        ],
                      ),
                    ),
                  ),
                  // FrostedGlassBox(
                  //   width: contWidth,
                  //   height: contHeight,
                  //   child: Center(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           _buildLoginNew(),
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

// import 'dart:ui';
// import 'package:startup_try_2/Auth/frostedglass.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/services.dart';
// import 'package:startup_try_2/homepage.dart';
// import 'package:startup_try_2/Auth/resetPassword.dart';
// import 'package:startup_try_2/Auth/signup.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'auth_services.dart';
// import 'package:startup_try_2/models/Product.dart';
// import 'package:startup_try_2/Shop_Owner/shopdetails.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:startup_try_2/delivery_home_page.dart';
// import 'package:startup_try_2/Auth/referralCode.dart';
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//
//   bool showPassword = true, isProgressTrue = false;
//   //bool isEmailEmpty = true, isPasswordEmpty = true;
//   final Color textColor = Colors.white.withOpacity(0.4);
//
//   String email, password, error, emailValidate, passwordValidate;
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   Widget _buildEmail() {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: TextFormField(
//         cursorColor: Colors.black,
//         controller: emailController,
//         keyboardType: TextInputType.emailAddress,
//         onChanged: (value) {
//           setState(() {
//             email = value.trim();
//           });
//         },
//         decoration: InputDecoration(
//             prefixIcon: Icon(
//               Icons.email,
//               color: Color(0xFF1B0250),
//               size: 30,
//             ),
//             labelText: "E-mail"),
//       ),
//     );
//   }
//
//   Widget _buildPassword() {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: TextFormField(
//         cursorColor: Colors.black,
//         controller: passwordController,
//         keyboardType: TextInputType.text,
//         obscureText: showPassword,
//         onChanged: (value) {
//           setState(() {
//             password = value.trim();
//           });
//         },
//         decoration: InputDecoration(
//           prefixIcon: Icon(
//             Icons.lock_outline,
//             color: Color(0xFF1B0250),
//             size: 30,
//           ),
//           labelText: "Password",
//           suffixIcon: showPassword
//               ? IconButton(
//                   icon: Icon(
//                     Icons.visibility_off,
//                     color: Color(0xFF1B0250),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       showPassword = !showPassword;
//                     });
//                   },
//                 )
//               : IconButton(
//                   icon: Container(
//                     child: Icon(
//                       Icons.visibility,
//                       color: Color(0xFF1B0250),
//                     ),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       showPassword = !showPassword;
//                     });
//                   },
//                 ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildForgotPswd() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         FlatButton(
//           onPressed: () {
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (context) => ResetPassPage()));
//           },
//           child: Text(
//             "Forgot Password?",
//             style: TextStyle(
//                 color: Color(0xFF1B0250),
//                 fontSize: 17,
//                 decoration: TextDecoration.underline),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLoginBtn() {
//     bool checkShopUser(var email) {
//       for (var i in shops) {
//         if (email == i["s_email"]) {
//           return true;
//         }
//       }
//       return false;
//     }
//
//     bool checkDeliveryUser(var email) {
//       print("inside checkDeliveryUser");
//       print("After func call");
//       for (var i = 0; i < deliveryemail.length; i++) {
//         print("Inside for");
//         if (email == deliveryemail[i]["dp_email"]) {
//           print("Got user in delivery");
//           return true;
//         }
//       }
//       return false;
//     }
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           height: 1.4 * (MediaQuery.of(context).size.height / 25),
//           width: 6 * (MediaQuery.of(context).size.width / 15),
//           child: RaisedButton(
//             onPressed: () async {
//               try {
//                 print("${email},${password}");
//                 passwordValidate = PasswordValidator.validate(password);
//                 if (passwordValidate == null) {
//                   setState(() {
//                     isProgressTrue = true;
//                   });
//                   final currentUser = await auth.signInWithEmailAndPassword(
//                       email: email, password: password);
//                   if (currentUser != null) {
//                     print("Before if");
//                     if (checkShopUser(email)) {
//                       print("Email shop");
//                       Navigator.of(context).pushReplacement(MaterialPageRoute(
//                           builder: (context) => UserProductsScreen()));
//                       setState(() {
//                         isProgressTrue = false;
//                       });
//                     } else if (checkDeliveryUser(email)) {
//                       print("Email Delivery");
//                       Navigator.of(context).pushReplacement(MaterialPageRoute(
//                           builder: (context) => DeliveryHome()));
//                       setState(() {
//                         isProgressTrue = false;
//                       });
//                     } else {
//                       Navigator.of(context).pushReplacement(
//                           MaterialPageRoute(builder: (context) => HomePage()));
//                       // HomePage()));
//                       setState(() {
//                         isProgressTrue = false;
//                       });
//                     }
//                   }
//                 } else {
//                   error = passwordValidate;
//                   AlertDialog alert = AlertDialog(
//                     title: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Icon(
//                           Icons.error,
//                           color: Colors.red,
//                         ),
//                         Text(
//                           " Error",
//                           style: TextStyle(
//                               color: Colors.red, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     content: Text(error),
// //                    actions: [
// //                      FlatButton(
// //                        child: Text("OK"),
// //                        onPressed: () {
// //                          setState(() {
// //                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
// //                          });
// //                        },
// //                      )
// //                    ],
//                   );
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return alert;
//                     },
//                   );
//                 }
// //                context.read<AuthenticationService>().signIn(
// //                  email: email,
// //                  password: password,
// //                );
// //                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
//
//               } catch (e) {
//                 print(e);
//                 error = e.message;
//                 setState(() {
//                   AlertDialog alert = AlertDialog(
//                     title: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Icon(
//                           Icons.error,
//                           color: Colors.red,
//                         ),
//                         Text(
//                           " Error",
//                           style: TextStyle(
//                               color: Colors.red, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     content: Text(error),
// //                    actions: [
// //                      FlatButton(
// //                        child: Text("OK"),
// //                        onPressed: () {
// //                          setState(() {
// //                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
// //                          });
// //                        },
// //                      )
// //                    ],
//                   );
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return alert;
//                     },
//                   );
//                   setState(() {
//                     isProgressTrue = false;
//                   });
//                 });
//               }
//             },
//             elevation: 10.0,
//             color: Color(0xFF1B0250),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//             child: Text(
//               "Login",
//               style: TextStyle(
//                 color: Colors.white,
//                 letterSpacing: 1.1,
//                 fontSize: MediaQuery.of(context).size.height / 43,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSignUp() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         FlatButton(
//           onPressed: () {
//             Navigator.push(context,
//                 new MaterialPageRoute(builder: (context) => SignUpPage()));
//           },
//           child: Text(
//             "Don't have an account? Register",
//             style: TextStyle(color: Color(0xFF1B0250), fontSize: 17),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLoginNew() {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 width: 0.65 * MediaQuery.of(context).size.width,
//                 child: Image(
//                   image: AssetImage("assets/images/auth_header.jpeg"),
//                   fit: BoxFit.fitWidth,
//                 ),
//               ),
//             ],
//           ),
//           _buildEmail(),
//           //Container(child: Text("hii"),),
//           _buildPassword(),
//           _buildForgotPswd(),
//           SizedBox(
//             height: 10,
//           ),
//           _buildLoginBtn(),
//           SizedBox(
//             height: 10,
//           ),
//           _buildSignUp(),
//         ],
//       ),
//     );
//   }
//
// //  Widget _buildLogin(){
// //    return Padding(
// //      padding: const EdgeInsets.symmetric(vertical: 200,
// //        horizontal: 50,
// //      ),
// //      child: Column(
// //        mainAxisAlignment: MainAxisAlignment.center,
// //        crossAxisAlignment: CrossAxisAlignment.center,
// //        children: <Widget>[
// //          ClipRRect(
// //            borderRadius: BorderRadius.all(
// //              Radius.circular(40),
// //            ),
// //            child: FadeAnimation(2, Container(
// //              height: MediaQuery.of(context).size.height*0.55,
// //              width: MediaQuery.of(context).size.width*0.8,
// //              color: Colors.white,
// //              child: Column(
// //                mainAxisAlignment: MainAxisAlignment.center,
// //                crossAxisAlignment: CrossAxisAlignment.center,
// //                children: <Widget>[
// //                  Row(
// //                    mainAxisAlignment: MainAxisAlignment.center,
// //                    children: <Widget>[
// //                      Text("Login",style: TextStyle(
// //                        color: Colors.blue,
// //                        fontWeight: FontWeight.bold,
// //                        fontSize: MediaQuery.of(context).size.height/25,
// //                      ),
// //                      ),
// //                    ],
// //                  ),
// //                  _buildEmail(),
// //                  _buildPassword(),
// //                  _buildForgotPswd(),
// //                  SizedBox(height: 10,),
// //                  _buildLoginBtn(),
// //                  SizedBox(height: 10,),
// //                  _buildSignUp(),
// //                ],
// //              ),
// //            ),
// //            ),
// //          ),
// //        ],
// //      ),
// //    );
// //  }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double contWidth = size.width * 0.90;
//     double contHeight = size.height * 0.60;
//     return WillPopScope(
//       onWillPop: () {
//         SystemNavigator.pop();
//       },
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Color(0xFF1B0250),
//           resizeToAvoidBottomPadding: false,
//           body: ModalProgressHUD(
//             inAsyncCall: isProgressTrue,
//             child: Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: Image.asset("assets/images/logo_wp1.png").image,
//                     fit: BoxFit.cover),
//               ),
//               child: Center(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       FrostedGlassBox(
//                         width: contWidth,
//                         height: contHeight,
//                         child: Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(10.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 _buildLoginNew(),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
