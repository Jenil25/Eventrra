import 'package:eventrra/data.dart';
import 'package:flutter/material.dart';
import 'package:eventrra/main.dart';

class SelectCaterer extends StatefulWidget {
  final venue;
  final city, fdate, tdate, eventType;
  const SelectCaterer(
      {Key? key,
      required this.venue,
      required this.city,
      required this.fdate,
      required this.tdate,
      required this.eventType})
      : super(key: key);

  @override
  _SelectCatererState createState() => _SelectCatererState(
        venue: venue,
        city: city,
        fdate: fdate,
        tdate: tdate,
        eventType: eventType,
      );
}

class _SelectCatererState extends State<SelectCaterer> {
  final venue;
  final city, fdate, tdate, eventType;

  _SelectCatererState(
      {this.venue, this.city, this.fdate, this.tdate, this.eventType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Caterer"),
      ),
      body: Column(
        children: [
          FutureBuilder(
            // Initialize FlutterFire
            future: getCatererForEvent(city['CId']),
            builder: (context, snapshot) {
              // Check for errors
              if (snapshot.hasError) {
                return Error(title: 'Error From Select Caterer');
              }

              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: selectCaterer.length,
                      itemBuilder: (BuildContext context, int i) => catererCard(
                          context,
                          selectCaterer[i],
                          city,
                          fdate,
                          tdate,
                          eventType)),
                );
              }

              // Otherwise, show something whilst waiting for initialization to complete
              return const Center(child: CircularProgressIndicator());
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Continue Without Caterer"),
            ),
          )
        ],
      ),
    );
  }
}

Widget catererCard(BuildContext context, var venue, var city, var fdate,
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
            // Navigator.push(
            //     context,
            //     //final city, fdate, tdate, eventType;
            //     MaterialPageRoute(
            //         builder: (context) => SelectCaterer(
            //           city: city,
            //           fdate: fdate,
            //           tdate: tdate,
            //           eventType: eventType,
            //           venue: venue,
            //         )));
          },
          child: const Text("Continue"))
    ],
  );
}
