import 'package:flutter/material.dart';
import 'package:eventrra_managers/data.dart';
import 'package:eventrra_managers/main.dart';

class EditVenue extends StatefulWidget {
  const EditVenue({Key? key}) : super(key: key);

  @override
  _EditVenueState createState() => _EditVenueState();
}

class _EditVenueState extends State<EditVenue> {
  TextEditingController addressLine1 = TextEditingController()
        ..text = currentVenueAddress['Line1'],
      addressLine2 = TextEditingController()
        ..text = currentVenueAddress['Line2'];
  TextEditingController landmark = TextEditingController()
    ..text = currentVenueAddress['Landmark'];
  TextEditingController venueName = TextEditingController()
    ..text = currentVenue['Name'];
  TextEditingController ownername = TextEditingController()
    ..text = currentVenue['OwnerName'];
  TextEditingController email = TextEditingController()
    ..text = currentVenue['Email'];
  TextEditingController contact = TextEditingController()
    ..text = currentVenue['Contact'];
  TextEditingController capacity = TextEditingController()
    ..text = currentVenue['Capacity'];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Color color = const Color(0xFF1B0250);
    return Scaffold(
      appBar: AppBar(
        title: Text(" "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: venueName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'venueName',
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              TextField(
                controller: ownername,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ownername',
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              TextField(
                controller: capacity,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Capacity',
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: addressLine1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address Line 1',
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              TextField(
                controller: addressLine2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address Line 2',
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              TextField(
                controller: landmark,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Landmark',
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              // TextField(
              //   controller: email,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'Email',
              //   ),
              // ),
              // const SizedBox(
              //   height: 8,
              // ),

              TextField(
                controller: contact,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VenueEdit(
                                line1: addressLine1.text,
                                line2: addressLine2.text,
                                landmark: landmark.text,
                                venuename: venueName.text,
                                email: email.text,
                                contact: contact.text,
                                ownername: ownername.text,
                                capacity: capacity.text,
                              )));
                },
                child: const Text(
                  "Edit",
                  style: TextStyle(color: Color(0xFF1B0250), fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VenueEdit extends StatefulWidget {
  final line1, line2, landmark;
  final venuename, email;
  final contact, ownername, capacity;
  const VenueEdit(
      {Key? key,
      this.line1,
      this.line2,
      this.landmark,
      this.venuename,
      this.email,
      this.contact,
      this.capacity,
      this.ownername})
      : super(key: key);

  @override
  _VenueEditState createState() => _VenueEditState(
      this.line1,
      this.line2,
      this.landmark,
      this.venuename,
      this.email,
      this.contact,
      this.capacity,
      this.ownername);
}

class _VenueEditState extends State<VenueEdit> {
  String line1, line2, landmark;
  String venuename, email;
  String contact, ownername, capacity;
  _VenueEditState(this.line1, this.line2, this.landmark, this.venuename,
      this.email, this.contact, this.capacity, this.ownername);
  @override
  Widget build(BuildContext context) {
    currentVenueAddress["Line1"] = line1;
    currentVenueAddress["Line2"] = line2;
    currentVenueAddress["Landmark"] = landmark;
    currentVenue["Name"] = venuename;
    currentVenue["Contact"] = contact;
    currentVenue["Capacity"] = capacity;
    currentVenue["OwnerName"] = ownername;
    return FutureBuilder(
      future: editVenueRequest(line1, line2, landmark, venuename, email,
          contact, capacity, ownername),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Error(
                title:
                    'Error From Request Submitted for Caterers:\n${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return EditVenue();
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Editing Request"),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
