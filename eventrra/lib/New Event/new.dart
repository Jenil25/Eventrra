import 'package:flutter/material.dart';

class NEvent extends StatefulWidget {
  @override
  _NEventState createState() => _NEventState();
}

class _NEventState extends State<NEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Event"),
      ),
      body: Column(
        children: [
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}
