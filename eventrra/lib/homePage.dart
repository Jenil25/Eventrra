import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(child: Text("Eventrra")),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text("Home Page"),
            ),
          ],
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Container(
        //       padding: const EdgeInsets.only(left: 50.0, right: 50.0),
        //       child: TextFormField(
        //         // style: Style(),
        //         decoration: const InputDecoration(
        //           border: UnderlineInputBorder(),
        //           labelText: 'Enter your email',
        //         ),
        //       ),
        //     ),
        //     SizedBox(
        //       height: 10,
        //     ),
        //     ElevatedButton(
        //       onPressed: () {},
        //       child: Text("Login"),
        //       style: ElevatedButton.styleFrom(
        //           primary: Colors.blue,
        //           padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
        //           textStyle:
        //               TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        //     ),
        //     SizedBox(
        //       height: 10,
        //     ),
        //     ElevatedButton(
        //       onPressed: () {},
        //       child: Text("SignUp Instead"),
        //       style: ElevatedButton.styleFrom(
        //           primary: Colors.blue,
        //           padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
        //           textStyle:
        //               TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
