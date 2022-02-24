import 'package:flutter/material.dart';
import 'package:eventrra_managers/data.dart';

class MyVenue extends StatefulWidget {
  const MyVenue({Key? key}) : super(key: key);

  @override
  _MyVenueState createState() => _MyVenueState();
}

class _MyVenueState extends State<MyVenue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentVenue["Name"]),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text("Request New Event Type"),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class RequestEventType extends StatefulWidget {
  const RequestEventType({Key? key}) : super(key: key);

  @override
  _RequestEventTypeState createState() => _RequestEventTypeState();
}

class _RequestEventTypeState extends State<RequestEventType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request new Venue"),
      ),
    );
  }
}
