import 'package:eventrra/My%20Events/singleEvent.dart';
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
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

Widget eventCard(BuildContext context, var event) {
var eventtype= null;
  for (int k = 0; k < eventTypes.length; ++k) {
    if (eventTypes[k]["EtId"] == event["EtId"]) {
      eventtype = eventTypes[k];
      break;
    }
  }
  // return ExpansionTile(
  //   title: Text(
  //     eventtype['EventType'],
  //     style: TextStyle(fontSize: 20),
  //   ),
  //   children: [
  //     SizedBox(
  //       // height: 300,
  //       child: Card(
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Center(
  //                 child: Container(
  //                     height: 100,
  //                     width: 100,
  //                     decoration: BoxDecoration(
  //                         color: Colors.blue.shade200,
  //                         borderRadius: BorderRadius.circular(15)),
  //                     child: Image.asset("assets/images/venue/MyVenue.png")),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       venue["Name"],
  //                       maxLines: 1,
  //                       style: const TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 24,
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //                     const SizedBox(
  //                       height: 10,
  //                     ),
  //                     Row(
  //                       children: [
  //                         Icon(
  //                           Icons.location_on,
  //                           color: Colors.grey.shade600,
  //                           size: 20,
  //                         ),
  //                         const SizedBox(
  //                           width: 10,
  //                         ),
  //                         Text(
  //                           vaddress["Landmark"],
  //                           style: TextStyle(
  //                               color: Colors.grey.shade600, fontSize: 20),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               Text(
  //                 "Capacity : " + venue["Capacity"],
  //                 maxLines: 1,
  //                 style: const TextStyle(color: Colors.grey, fontSize: 20),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               Text(
  //                 venue["Email"],
  //                 maxLines: 1,
  //                 style: const TextStyle(color: Colors.grey, fontSize: 20),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               Text(
  //                 "Contact No. : " + venue["Contact"],
  //                 maxLines: 1,
  //                 style: const TextStyle(color: Colors.grey, fontSize: 20),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //     const SizedBox(
  //       height: 10,
  //     ),
  //     TextButton(
  //         onPressed: () {
  //           // inputVenue = venue;
  //           // Navigator.push(
  //           //     context,
  //           //     //final city, fdate, tdate, eventType;
  //           //     MaterialPageRoute(
  //           //         builder: (context) => SelectCaterer(
  //           //               city: city,
  //           //               fdate: fdate,
  //           //               tdate: tdate,
  //           //               eventType: eventType,
  //           //               venue: venue,
  //           //             )));
  //         },
  //         child: const Text("Continue"))
  //   ],
  // );
  return Container(
      child : TextButton( onPressed: (){
        Navigator.push(
          context,
          //final city, fdate, tdate, eventType;
          MaterialPageRoute(
            builder: (context) => SingleEvent(event:event),
          ),
        );
      },
      child : Text(eventtype['EventType']),
      ),
  );
}
