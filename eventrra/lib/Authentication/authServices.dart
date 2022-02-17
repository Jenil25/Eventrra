import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class AuthServices {
//
//   Future<FirebaseApp> _initializeFirebase() async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     return firebaseApp;
//   }
//
//   Future<void> signUp(String email, String password) async {
//     return _authenticate(email, password, 'signUp');
//   }
//
//   Future<void> login(String email, String password) async {
//     return _authenticate(email, password, 'signInWithPassword');
//   }
//
//   Future<void> changePassword(String newPassword) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     print(newPassword);
//     _token = sharedPreferences.getString("token");
//     final url =
//         'https://identitytoolkit.googleapis.com/v1/accounts:update?key='YOUR WEB API KEY';
//     try {
//       await http.post(
//         url,
//         body: json.encode(
//           {
//             'idToken': _token,
//             'password': newPassword,
//             'returnSecureToken': true,
//           },
//         ),
//       );
//     } catch (error) {
//       throw error;
//     }
//   }
// }

class A {}

// class AuthenticationService {
//   final FirebaseAuth _firebaseAuth;
//
//   AuthenticationService(this._firebaseAuth);
//
//   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
//
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }
//
//   Future<void> sendPasswordResetEmail(String email) async {
//     return _firebaseAuth.sendPasswordResetEmail(email: email);
//   }
//
//   Future<String?> signIn({String? email, String? password}) async {
//     try {
//       var email1 = (email == null) ? "" : email;
//       var password1 = (password == null) ? "" : password;
//       await _firebaseAuth.signInWithEmailAndPassword(
//           email: email1, password: password1);
//       return "Login Successful";
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }
//
//   Future<String?> signUp({String? email, String? password}) async {
//     try {
//       var email1 = (email == null) ? "" : email;
//       var password1 = (password == null) ? "" : password;
//       await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email1, password: password1);
//       return "Registration Successful";
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }
// }

bool validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty!";
    }
    if (!validateEmail(value)) {
      return 'Valid Email Needed!';
    }
    // return null;
    return "";
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty!";
    }
    if (value.length < 6) {
      return "Password length can't be less than 6";
    }
    if (value.length > 13) {
      return "Password length can't be greater than 13";
    }
    return "";
  }
}

class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty!";
    }
    if (value.length < 2) {
      return "Please enter a valid name";
    }
    return "";
  }
}
