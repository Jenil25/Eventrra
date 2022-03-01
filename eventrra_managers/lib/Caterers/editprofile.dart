import 'package:flutter/material.dart';
import 'package:eventrra_managers/data.dart';
import 'package:eventrra_managers/main.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController addressLine1 = TextEditingController()..text=currentCatererAddress['Line1'],
      addressLine2 = TextEditingController()..text=currentCatererAddress['Line2'];
  TextEditingController landmark = TextEditingController()..text=currentCatererAddress['Landmark'];
  TextEditingController cateringName = TextEditingController()..text=currentCaterer['Name'];
  TextEditingController  ownername= TextEditingController()..text=currentCaterer['OwnerName'];
  TextEditingController email = TextEditingController()..text=currentCaterer['Email'];
  TextEditingController contact = TextEditingController()..text=currentCaterer['Contact'];


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Color color = const Color(0xFF1B0250);
    return Scaffold(
        appBar: AppBar(
        title: Text(" "),
    ),
    body: Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        TextField(
          controller: cateringName,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'cateringName',
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

        TextField(
          controller: email,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
          ),
        ),
        const SizedBox(
          height: 8,
        ),

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
                    builder: (context) => CaterersEdit(
                      line1: addressLine1.text,
                      line2: addressLine2.text,
                      landmark: landmark.text,
                      cateringname: cateringName.text,
                      email: email.text,
                      contact: contact.text,
                      ownername: ownername.text,
                    )));
          },
          child: const Text(
            "Edit",
            style: TextStyle(color: Color(0xFF1B0250), fontSize: 17),
          ),
        ),
      ],
    ),

    );
  }
}

class CaterersEdit extends StatefulWidget {
  final line1, line2, landmark;
  final cateringname, email;
  final contact, ownername;
  const CaterersEdit({Key? key,
    this.line1,
    this.line2,
    this.landmark,
    this.cateringname,
    this.email,
    this.contact,
    this.ownername }) : super(key: key);

  @override
  _CaterersEditState createState() => _CaterersEditState(this.line1, this.line2, this.landmark,
       this.cateringname, this.email, this.contact, this.ownername);
}

class _CaterersEditState extends State<CaterersEdit> {
  String line1, line2, landmark;
  String cateringname, email;
  String contact, ownername;
  _CaterersEditState(this.line1, this.line2, this.landmark,
      this.cateringname, this.email, this.contact, this.ownername);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: editCaterersRequest(
          line1, line2, landmark, cateringname, email, contact, ownername),
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
          return EditProfile();
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