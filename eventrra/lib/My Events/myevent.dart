import 'package:eventrra/My%20Events/singleEvent.dart';
import 'package:eventrra/New%20Event/newevent.dart';
import 'package:flutter/material.dart';
import 'package:eventrra/data.dart';
import 'package:eventrra/main.dart';

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
      body: Center(
        child: FutureBuilder(
          // Initialize FlutterFire
          future: getUserEvents(uid),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              print("Snapshot error:");
              print(snapshot.error);
              return Error(title: 'Error From Main');
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: myEvents.length,
                  itemBuilder: (BuildContext context, int i) =>
                      eventCard(context, myEvents[i]));
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

Widget eventCard(BuildContext context, var event) {
  var eventtype = null;
  for (int k = 0; k < eventTypes.length; ++k) {
    if (eventTypes[k]["EtId"] == event["EtId"]) {
      eventtype = eventTypes[k];
      break;
    }
  }

  return Column(
    children: [
      Container(
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              //final city, fdate, tdate, eventType;
              MaterialPageRoute(
                builder: (context) => SingleEvent(event: event),
              ),
            );
          },
          child: Text(eventtype['EventType']),
        ),
      ),
      event['VerifiedV'] == "-1" ? TextButton(onPressed: (){
        eid = event['EId'];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewEvent()));
      }, child: Text("Reschedule")): Text(" "),
    ],
  );
}
