import 'package:flutter/material.dart';
import 'package:eventrra_managers/main.dart';
import 'package:eventrra_managers/data.dart';

class RequestedEvents extends StatefulWidget {
  const RequestedEvents({Key? key}) : super(key: key);

  @override
  _RequestedEventsState createState() => _RequestedEventsState();
}

class _RequestedEventsState extends State<RequestedEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Requests"),
      ),
      body: Center(
        child: FutureBuilder(
          future: getCatererRequests(currentCaterer['CaId']),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Error(title: 'Error From Caterer Requested Events');
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: catererRequests.length,
                itemBuilder: (BuildContext context, int i) =>
                    requestCard(context, catererRequests[i], setState),
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
  // ignore: avoid_init_to_null
  var eventtype = null;
  for (int k = 0; k < eventTypes.length; ++k) {
    if (eventTypes[k]["EtId"] == request["EtId"]) {
      eventtype = eventTypes[k];
      break;
    }
  }

  AlertDialog requestAcceptedAlert = AlertDialog(
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
          setState(() {});
        },
        child: const Text("OK")),
  );

  AlertDialog requestDeclinedAlert = AlertDialog(
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

  return ExpansionTile(
    title: Text(
      eventtype["EventType"],
      style: const TextStyle(fontSize: 20),
    ),
    children: [
      SizedBox(
        // height: 300,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(15)),
                      child:
                          Image.asset("assets/images/caterer/MyCaterer.png")),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "From Date : " + request["FDate"],
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "To Date : " + request["TDate"],
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Name : " + request["Name"],
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Contact : " + request["Contact"],
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          TextButton(
              onPressed: () {
                AcceptCatererRequest(
                        request['EId'],
                        currentCaterer['Name'],
                        eventtype['EventType'],
                        request['FDate'],
                        request['TDate'],
                        request['UId'])
                    .then((value) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return requestAcceptedAlert;
                      });
                });
              },
              child: const Text("Accept")),
          const SizedBox(
            width: 10,
          ),
          TextButton(
              onPressed: () {
                DeclineCatererRequest(
                        request['EId'],
                        request['UId'],
                        currentCaterer['Name'],
                        eventtype['EventType'],
                        request['FDate'],
                        request['TDate'])
                    .then((value) => {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return requestDeclinedAlert;
                            },
                          ),
                        });
              },
              child: const Text("Decline")),
        ],
      ),
    ],
  );
}

Widget requestCard1(BuildContext context, var request, StateSetter setState) {
  // ignore: avoid_init_to_null
  var eventtype = null;
  for (int k = 0; k < eventTypes.length; ++k) {
    if (eventTypes[k]["EtId"] == request["EtId"]) {
      eventtype = eventTypes[k];
      break;
    }
  }

  AlertDialog requestAcceptedAlert = AlertDialog(
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
          setState(() {});
        },
        child: const Text("OK")),
  );

  AlertDialog requestDeclinedAlert = AlertDialog(
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

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          // onTap: () {},
          child: Container(
            // height: 90,
            decoration: BoxDecoration(
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
                    DeclineCatererRequest(
                            request['EId'],
                            request['UId'],
                            currentCaterer['Name'],
                            eventtype['EventType'],
                            request['FDate'],
                            request['TDate'])
                        .then((value) => {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return requestDeclinedAlert;
                                },
                              ),
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
                    AcceptCatererRequest(
                            request['EId'],
                            currentCaterer['Name'],
                            eventtype['EventType'],
                            request['FDate'],
                            request['TDate'],
                            request['UId'])
                        .then((value) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return requestAcceptedAlert;
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
