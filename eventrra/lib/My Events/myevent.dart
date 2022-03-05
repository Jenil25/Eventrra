import 'package:flutter/material.dart';
import 'package:eventrra/data.dart';

class MyEvent extends StatefulWidget {
  const MyEvent({Key? key}) : super(key: key);

  @override
  State<MyEvent> createState() => _MyEventState();
}

class _MyEventState extends State<MyEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(),
      body :
      Container(
        child : Text("My events : "),
     )

    );
  }
}
