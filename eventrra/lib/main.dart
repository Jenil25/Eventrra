import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homePage.dart';
import 'package:magic_sdk/magic_sdk.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
  Magic.instance = Magic("pk_live_ECF37DA327A4193A");
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Stack(children: [
        MyHomePage(title: 'Welcome'),
        Magic.instance.relayer,
      ]),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  _authenticate(BuildContext context) async {
    final token =
        await Magic.instance.auth.loginWithMagicLink(email: _controller.text);
    print("token:");
    print(token);
    print("Done!");
    Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (context) => HomePage()));
  }

  bool isValidEmail(String email) {
    String str =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(str);
    return regExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your email to login',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (isValidEmail(_controller.text)) {
                  _authenticate(context);
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text("Eventrra"),
                          backgroundColor: Colors.white,
                        ),
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  );
                } else {
                  AlertDialog alert = AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.email_sharp,
                          color: Colors.red,
                          size: 24.5,
                        ),
                        Text(
                          " Invalid Email",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.red,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    content: Text(
                      "Please enter a valid email address",
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }
              },
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: Text("SignUp Instead"),
            //   style: ElevatedButton.styleFrom(
            //       primary: Colors.blue,
            //       padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
            //       textStyle:
            //           TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            // )
          ],
        ),
      ),
      // Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Invoke "debug painting" (press "p" in the console, choose the
      //     // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //     // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //     // to see the wireframe for each widget.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       ElevatedButton(
      //           onPressed: () {
      //             Navigator.push(
      //                 context,
      //                 new MaterialPageRoute(
      //                     builder: (context) => WelcomePage()));
      //           },
      //           child: Text("Welcome Screen")),
      //       Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
