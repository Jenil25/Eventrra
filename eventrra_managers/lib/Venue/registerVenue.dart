import 'package:dropdown_below/dropdown_below.dart';
import 'package:eventrra_managers/data.dart';
import 'package:flutter/material.dart';
import 'package:eventrra_managers/Venue/venueHome.dart';
import 'package:eventrra_managers/main.dart';

class RegisterVenue extends StatefulWidget {
  final name, email, contactNo;
  const RegisterVenue(
      {Key? key,
      required this.name,
      required this.email,
      required this.contactNo})
      : super(key: key);

  @override
  _RegisterVenueState createState() =>
      _RegisterVenueState(name, email, contactNo);
}

class _RegisterVenueState extends State<RegisterVenue> {
  final name, email, contactNo;
  _RegisterVenueState(this.name, this.email, this.contactNo);

  int _activeStepIndex = 0;
  bool _chooseacity = true;

  late Map<dynamic, bool?> eventTypesCheckbox = {};

  TextEditingController addressLine1 = TextEditingController(),
      addressLine2 = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController venueName = TextEditingController();
  TextEditingController venueCapacity = TextEditingController();

  List<DropdownMenuItem> _dropdownCityItems = [];
  var _selectedCity = null;

  @override
  void initState() {
    _dropdownCityItems = buildDropdownTestItems(cities);
    super.initState();
  }

  List<DropdownMenuItem> buildDropdownTestItems(var _testList) {
    List<DropdownMenuItem> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i["Name"]),
        ),
      );
    }
    return items;
  }

  onChangeDropdownCity(selectedCity) {
    setState(() {
      _chooseacity = false;
      _selectedCity = selectedCity;
    });
  }

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Address'),
          content: Column(
            children: [
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
              Stack(
                children: [
                  Container(
                    height: 52,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 10,
                      ),
                      child: Text(
                        _chooseacity ? "Choose a city" : "",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  DropdownBelow(
                    itemWidth: 200,
                    itemTextstyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    boxTextstyle:
                        const TextStyle(fontSize: 16, color: Colors.black),
                    boxPadding: const EdgeInsets.fromLTRB(13, 12, 0, 12),
                    boxHeight: 45,
                    boxWidth: 200,
                    hint: null,
                    value: _selectedCity,
                    items: _dropdownCityItems,
                    onChanged: onChangeDropdownCity,
                  ),
                ],
              ),
            ],
          ),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Venue Details'),
          content: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: venueName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Venue Name',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: venueCapacity,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Venue Capacity',
                ),
              ),
            ],
          ),
        ),
        Step(
          state: _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const Text('Events Supported'),
          content: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              const Text("Select Events that can be hosted at your venue"),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: eventTypesCheckbox.keys
                    .map(
                      (e) => CheckboxListTile(
                        title: Text(e["Event-Type"]),
                        value: eventTypesCheckbox[e],
                        onChanged: (bool? value) {
                          setState(() {
                            eventTypesCheckbox[e] = value;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 3,
          title: const Text('Confirm'),
          content: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Address Line1: ${addressLine1.text}'),
                Text('Address Line2: ${addressLine2.text}'),
                Text('Landmark: ${landmark.text}'),
                _selectedCity == null
                    ? const Text('City: ')
                    : Text('City: ${_selectedCity["Name"]}'),
                Text('Venue Name: ${venueName.text}'),
                Text('Venue Capacity: ${venueCapacity.text}'),
              ],
            ),
          ),
        ),
      ];

  String validValues(var line1, var line2, var landmark, var city,
      var venuename, var capacity) {
    if (line1 == "" ||
        line2 == "" ||
        landmark == "" ||
        city == null ||
        venuename == "" ||
        capacity == "") return "Please Fill in all the details";

    return "valid";
  }

  void getEventTypeCheckBox() {
    for (var i in eventTypes) {
      eventTypesCheckbox.putIfAbsent(i, () => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    getEventTypeCheckBox();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _activeStepIndex,
          steps: stepList(),
          onStepContinue: () async {
            if (_activeStepIndex < (stepList().length - 1)) {
              setState(() {
                _activeStepIndex += 1;
              });
            } else {
              String input = validValues(
                  addressLine1.text,
                  addressLine2.text,
                  landmark.text,
                  _selectedCity,
                  venueName.text,
                  venueCapacity.text);
              if (input == "valid") {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RequestSubmitted(
                              line1: addressLine1.text,
                              line2: addressLine2.text,
                              landmark: landmark.text,
                              cid: _selectedCity["CId"],
                              name: venueName,
                              capacity: venueCapacity.text,
                              email: email,
                              contact: contactNo,
                              ownername: name,
                              venueEventTypes: eventTypesCheckbox,
                            )));
              } else {
                AlertDialog alert = AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      Text(
                        " Error",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  content: Text(input),
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }
            }
          },
          onStepCancel: () {
            if (_activeStepIndex == 0) return;
            setState(() {
              _activeStepIndex -= 1;
            });
          },
          onStepTapped: (int index) {
            setState(() {
              _activeStepIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class RequestSubmitted extends StatefulWidget {
  final line1, line2, landmark, cid;
  final name, capacity, email;
  final contact, ownername;
  final venueEventTypes;
  const RequestSubmitted(
      {Key? key,
      this.line1,
      this.line2,
      this.landmark,
      this.cid,
      this.name,
      this.capacity,
      this.email,
      this.contact,
      this.ownername,
      this.venueEventTypes})
      : super(key: key);

  // print("");
  @override
  _RequestSubmittedState createState() => _RequestSubmittedState(
      this.line1,
      this.line2,
      this.landmark,
      this.cid,
      this.name,
      this.capacity,
      this.email,
      this.contact,
      this.ownername,
      this.venueEventTypes);
}

class _RequestSubmittedState extends State<RequestSubmitted> {
  String line1, line2, landmark, cid;
  String name, capacity, email;
  String contact, ownername;
  var venueEventTypes;
  _RequestSubmittedState(
      this.line1,
      this.line2,
      this.landmark,
      this.cid,
      this.name,
      this.capacity,
      this.email,
      this.contact,
      this.ownername,
      this.venueEventTypes);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sendVenueRequest(line1, line2, landmark, cid, name, capacity,
          email, contact, ownername, venueEventTypes),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Snapshot errors:");
          print(snapshot.error);
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Error(title: 'Error From Request Submitted'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          isVenueVerified = false;
          return const VenueHome();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Submitting Request"),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
