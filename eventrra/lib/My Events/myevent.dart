import 'package:eventrra/My%20Events/singleEvent.dart';
import 'package:eventrra/New%20Event/newevent.dart';
import 'package:flutter/material.dart';
import 'package:eventrra/data.dart';
import 'package:eventrra/main.dart';
import 'package:intl/intl.dart';

class MyEvent extends StatefulWidget {
  const MyEvent({Key? key}) : super(key: key);

  @override
  State<MyEvent> createState() => _MyEventState();
}

class _MyEventState extends State<MyEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: getUserEvents(uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Error(title: 'Error From MyEvent');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: myEvents.length,
                  itemBuilder: (BuildContext context, int i) =>
                      eventCard(context, myEvents[i]));
            }
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

  DateTime current = DateTime.now();
  DateTime tDate = DateFormat("dd-MM-yyyy").parse(event['TDate']);
  DateTime fDate = DateFormat("dd-MM-yyyy").parse(event['FDate']);
  bool eventCompleted = false;
  if (current.isAfter(tDate)) {
    if (event["VerifiedV"] == "0") {
      eventCompleted = false;
    }
    eventCompleted = true;
  }

  // DateTime todaysDate = DateTime.now();
  // print(event['']);
  // DateTime toDate = DateFormat("dd-MM-yyyy").format(event['ToDate']);
  // DateFormat format = DateFormat("")
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        // Container(
        //   child: TextButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         //final city, fdate, tdate, eventType;
        //         MaterialPageRoute(
        //           builder: (context) => SingleEvent(event: event),
        //         ),
        //       );
        //     },
        //     child: Text(eventtype['EventType']),
        //   ),
        // ),
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              //final city, fdate, tdate, eventType;
              MaterialPageRoute(
                builder: (context) => SingleEvent(event: event),
              ),
            );
          },
          child: Container(
            height: 90,
            decoration: BoxDecoration(
                borderRadius: event['VerifiedV'] != "-1"
                    ? BorderRadius.circular(10)
                    : const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventtype['EventType'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey.shade700,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${event['FDate']} to ${event['TDate']}"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        event['VerifiedV'] == "-1"
            ? Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    color: Colors.redAccent.shade100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                    ),
                    const Text(
                      "Your request is rejected\nKindly reschedule your event",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          eid = event['EId'];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NewEvent()));
                        },
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              " Reschedule ",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ))
                  ],
                ),
              )
            : eventCompleted == true
                ? Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                        color: Colors.green.shade300),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Event Successfully Completed",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                        color: Colors.orange.shade300),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.history,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "You're all set for the event",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
      ],
    ),
  );
}
