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
      body :
      FutureBuilder(

        // Initialize FlutterFire
        future: getUserEvents(uid),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Error(title: 'Error From Main');
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: myEvents.length,
                itemBuilder: (BuildContext context, int i) => eventCard(
                    context, selectVenue[i], city, fdate, tdate, eventType)
              //     Column(
              //   children: <Widget>[
              //     Container(
              //       padding:
              //           EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Container(
              //               child: ElevatedButton(
              //             // padding: EdgeInsets.symmetric(
              //             //     vertical: 12.0, horizontal: 10.0),
              //             child: Text("Name : " +
              //                 selectVenue[i]['Name'] +
              //                 "\n" +
              //                 "Address : " +
              //                 selectVenue[i]['Line1'] +
              //                 " , " +
              //                 selectVenue[i]['Line2'] +
              //                 "\n"
              //                     "LandMark : " +
              //                 selectVenue[i]['Landmark'] +
              //                 "\n" +
              //                 "Capacity : " +
              //                 selectVenue[i]['Capacity'] +
              //                 "\n" +
              //                 "Email : " +
              //                 selectVenue[i]['Email'] +
              //                 "\n" +
              //                 "OwnerName : " +
              //                 selectVenue[i]['OwnerName'] +
              //                 "\n" +
              //                 "Contact : " +
              //                 selectVenue[i]['Contact'] +
              //                 "\n"),
              //             style: ElevatedButton.styleFrom(
              //               primary: colour, // Background color
              //               onPrimary: Colors.black,
              //               textStyle: TextStyle(fontSize: 18.0),
              //             ),
              //
              //             onPressed: () {
              //               // Navigator.push(
              //               //   context,
              //               //   new MaterialPageRoute(
              //               //       builder: (context) =>SelectVenue()),
              //               // );
              //             },
              //           )),
              //           Divider(color: Colors.black),
              //         ],
              //       ),
              //     )
              //   ],
              // ),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return CircularProgressIndicator();
        },
      ),


    );
  }
}


Widget eventCard(BuildContext context, var event) {

  return ExpansionTile(
    title: Text(
      event["Name"],
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
                        venue["Name"],
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            venue["Landmark"],
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Capacity : " + venue["Capacity"],
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  venue["Email"],
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Contact No. : " + venue["Contact"],
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      TextButton(
          onPressed: () {
            inputVenue = venue;
            Navigator.push(
                context,
                //final city, fdate, tdate, eventType;
                MaterialPageRoute(
                    builder: (context) => SelectCaterer(
                      city: city,
                      fdate: fdate,
                      tdate: tdate,
                      eventType: eventType,
                      venue: venue,
                    )));
          },
          child: const Text("Continue"))
    ],
  );
}
