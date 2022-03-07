import 'package:eventrra_managers/Authentication/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
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
      appBar: AppBar(),
      body : Center(
        child: FutureBuilder(
          future: getVenueRequests(currentVenue['VId']),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Error(title: 'Error From Main');
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: venueRequests.length,
                  itemBuilder : (BuildContext context, int i) =>
                      // Padding(
                      //   padding: const EdgeInsets.all(1.0),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.blue.shade200,
                      //       borderRadius : BorderRadius.vertical(top: Radius.circular(15.0)),
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Container(
                      //           // color: Colors.blue.shade300,
                      //
                      //           child: Text(venueRequests[i]["Name"]),
                      //
                      //         ),
                      //         SizedBox(
                      //           width: 10,
                      //         ),
                      //         TextButton(onPressed: (){}, child: Text("Accept")),
                      //         TextButton(onPressed: (){}, child: Text("Decline")),
                      //       ],
                      //     ),
                      //   ),
                      // )
                requestCard(context, venueRequests[i]),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

Widget requestCard(BuildContext context, var request)
{
  var eventtype=null;
  for(int k = 0; k < eventTypes.length; ++k) {
    if (eventTypes[k]["EtId"] == request["EtId"]) {
      eventtype = eventTypes[k];
      break;
    }
  }

  AlertDialog alert = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const <Widget>[
        Text(
          "Request Accepted",
          style: TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    content: TextButton(onPressed: (){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>
                  RequestedEvents()));
    },child : Text("OK") ),
  );
  AlertDialog alert1 = AlertDialog  (
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const <Widget>[
        Text(
          "Request Declined",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    content: TextButton(onPressed: (){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>
              RequestedEvents()));
    },child : Text("OK") ),
  );
  return ExpansionTile(
    title: Text(
      eventtype["EventType"] ,
      style: TextStyle(fontSize: 20),
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
                      child: Image.asset("assets/images/venue/MyVenue.png")),
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
                        "From Date : "+request["FDate"],
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "To Date : "+request["TDate"],
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

          TextButton(onPressed: (){
            AcceptRequest(request['EId'],currentVenue['Name'],eventtype['EventType'],request['FDate'],request['TDate'],request['UId']).then((value) =>
            {
                showDialog(
                context: context,
                builder: (BuildContext context) {
                return alert;
                },
                ),
            }
            );
          }, child: Text("Accept")),
          SizedBox(
            width: 10,
          ),
          TextButton(onPressed: (){
            DeclineRequest(request['EId'],currentVenue['Name'],eventtype['EventType'],request['FDate'],request['TDate'],request['UId']).then((value) =>
            {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert1;
                },
              ),
            }
            );
          }, child: Text("Decline")),
        ],
      ),


    ],
  );
}