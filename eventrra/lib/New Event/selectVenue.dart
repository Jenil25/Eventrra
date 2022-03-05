import 'package:eventrra/New%20Event/selectCaterer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eventrra/data.dart';
import 'package:eventrra/main.dart';

//city,date,event-type
class SelectVenue extends StatefulWidget {
  final city, fdate, tdate, eventType;
  const SelectVenue(
      {Key? key,
      required this.city,
      required this.fdate,
      required this.tdate,
      required this.eventType})
      : super(key: key);

  @override
  _SelectVenueState createState() => _SelectVenueState(
        city: city,
        fdate: fdate,
        tdate: tdate,
        eventType: eventType,
      );
}

class _SelectVenueState extends State<SelectVenue> {
  final city, fdate, tdate, eventType;
  _SelectVenueState({this.city, this.fdate, this.tdate, this.eventType});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Color colour = const Color(0xffB7CEEC);
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Venue"),
      ),
      body: FutureBuilder(
        // Initialize FlutterFire
        future: getVenueForEvent(city['CId'], eventType['EtId']),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Error(title: 'Error From Main');
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: length,
                itemBuilder: (BuildContext context, int i) => venueCard1(
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

Widget venueCard1(BuildContext context, var venue, var city, var fdate,
    var tdate, var eventType) {
  return ExpansionTile(
    title: Text(
      venue["Name"],
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

Widget venueCard(var venue) {
  return ExpansionTile(
    title: Text(
      "Title",
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    ),
    children: <Widget>[
      ExpansionTile(
        title: Text(
          'Sub title',
        ),
        children: <Widget>[
          ListTile(
            title: Text('data'),
          )
        ],
      ),
      ListTile(
        title: Text('data'),
      )
    ],
  );
}

// import 'package:flutter/material.dart';
// import 'package:eventrra/data.dart';
//
// //city,date,event-type
// class SelectVenue extends StatefulWidget {
//   final city, date, eventType;
//   const SelectVenue({Key? key, this.city, this.date, this.eventType})
//       : super(key: key);
//
//   @override
//   _SelectVenueState createState() => _SelectVenueState(
//         city: city,
//         date: date,
//         eventType: eventType,
//       );
// }
//
// class _SelectVenueState extends State<SelectVenue> {
//   final city, date, eventType;
//   _SelectVenueState({this.city, this.date, this.eventType});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Select Venue"),
//       ),
//       body: Column(
//         children: [
//           Text(city.toString()),
//           Text(date.toString()),
//           Text(eventType.toString()),
//         ],
//       ),
//     );
//   }
// }
