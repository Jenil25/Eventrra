// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:eventrra_managers/data.dart';
import 'package:eventrra_managers/main.dart';

class RequestedEvents extends StatefulWidget {
  const RequestedEvents({Key? key}) : super(key: key);

  @override
  State<RequestedEvents> createState() => _RequestedEventsState();
}

class _RequestedEventsState extends State<RequestedEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(title: const Text("Requests")),
      body: Center(
        child: FutureBuilder(
          future: getVenueRequests(currentVenue['VId']),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Error(title: 'Error From Main');
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: venueRequests.length,
                itemBuilder: (BuildContext context, int i) =>
                    requestCard(context, venueRequests[i], setState),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

Widget requestCard(BuildContext context, var request, StateSetter setState) {
  var eventtype = null;
  for (int i = 0; i < eventTypes.length; ++i) {
    if (request["EtId"] == eventTypes[i]["EtId"]) {
      eventtype = eventTypes[i];
      break;
    }
  }
  TextEditingController reasoncontroller = TextEditingController();
  AlertDialog acceptAlert = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const <Widget>[
        Text(
          "Request Accepted",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    content: TextButton(
        onPressed: () {
          Navigator.pop(context);
          // setState(() {});
        },
        child: const Text("OK")),
  );
  AlertDialog declinedAlert = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const <Widget>[
        Text(
          "Request Declined",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    content: TextButton(
        onPressed: () {
          Navigator.pop(context);
          setState(() {});
        },
        child: const Text("OK")),
  );
  AlertDialog declineAlert = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const <Widget>[
        Text(
          " Enter Reason",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    content: SizedBox(
      height: 125,
      child: Column(
        children: [
          TextFormField(
            controller: reasoncontroller,
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                DeclineRequest(
                        request['EId'],
                        currentVenue['Name'],
                        reasoncontroller.text,
                        eventtype['EventType'],
                        request['FDate'],
                        request['TDate'],
                        request['UId'],
                        request['CaId'],
                        request['OrId'],
                        request['DId'])
                    .then((value) {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return declinedAlert;
                    },
                  );
                });
              },
              child: const Text("Continue")),
        ],
      ),
    ),
  );

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
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
                      Text("${request['FDate']} to ${request['TDate']}"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey.shade700,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${request["Name"]}"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.grey.shade700,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${request["Contact"]}"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
              color: Colors.blue.shade100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return declineAlert;
                        });
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
                        "Decline",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                  onPressed: () {
                    AcceptRequest(
                            request['EId'],
                            currentVenue['Name'],
                            eventtype['EventType'],
                            request['FDate'],
                            request['TDate'],
                            request['UId'])
                        .then((value) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return acceptAlert;
                          });
                    });
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
                        "Accept",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ))
            ],
          ),
        )
      ],
    ),
  );
}
