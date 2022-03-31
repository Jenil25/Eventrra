// ignore_for_file: prefer_typing_uninitialized_variables, no_logic_in_create_state

import 'package:eventrra/New%20Event/selectCaterer.dart';
import 'package:eventrra/New%20Event/viewVImages.dart';
import 'package:flutter/material.dart';
import 'package:eventrra/data.dart';
import 'package:eventrra/main.dart';

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
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text("Select Venue"),
      ),
      body: FutureBuilder(
        future: getVenueForEvent(city['CId'], eventType['EtId']),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Error(title: 'Error From Main');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: length,
                itemBuilder: (BuildContext context, int i) => venueCard(
                    selectVenue[i], city, fdate, tdate, eventType, context));
          }
          return const Center(child: CircularProgressIndicator());
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
      style: const TextStyle(fontSize: 20),
    ),
    children: [
      SizedBox(
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
                      child: venue['image'] == ""
                          ? Image.asset("assets/images/venue/MyVenue.png")
                          : Image.network(
                              "https://eventrra.000webhostapp.com/gallery/venue/${venue['image']}")),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewVImages(venue: venue)));
                      },
                      child: const Text("View more Images")),
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

Widget venueCard(var venue, var city, var fdate, var tdate, var eventType,
    BuildContext ctx) {
  return TextButton(
    onPressed: () {},
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: 120,
                    width: 120,
                    color: Colors.grey,
                    child: venue["image"] != ""
                        ? Image.network(
                            "https://eventrra.000webhostapp.com/gallery/venue/${venue["image"]}",
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/venue/MyVenue.png",
                          ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      venue["Name"].toString().toUpperCase(),
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          venue["Landmark"],
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.people,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          venue["Capacity"],
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.mail,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          venue["Email"],
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          venue["Contact"],
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        ctx,
                        MaterialPageRoute(
                            builder: (context) => ViewVImages(venue: venue)));
                  },
                  child: Container(
                    height: 40,
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                    ),
                    child: const Center(
                      child: Text(
                        "VIEW MORE IMAGES",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    inputVenue = venue;
                    Navigator.push(
                        ctx,
                        MaterialPageRoute(
                            builder: (context) => SelectCaterer(
                                  city: city,
                                  fdate: fdate,
                                  tdate: tdate,
                                  eventType: eventType,
                                  venue: venue,
                                )));
                  },
                  child: Container(
                    height: 40,
                    width: 130,
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        "BOOK VENUE",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
