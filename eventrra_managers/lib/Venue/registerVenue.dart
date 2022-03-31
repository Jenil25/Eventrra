// ignore_for_file: prefer_typing_uninitialized_variables, no_logic_in_create_state

import 'package:eventrra_managers/data.dart';
import 'package:flutter/material.dart';
import 'package:eventrra_managers/Venue/venueHome.dart';
import 'package:eventrra_managers/main.dart';
import 'package:flutter/services.dart';

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

  late Map<dynamic, bool?> eventTypesCheckbox = {};

  TextEditingController addressLine1Controller = TextEditingController(),
      addressLine2Controller = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController venueNameController = TextEditingController();
  TextEditingController venueCapacityController = TextEditingController();

  bool ispincodeVerified = false;
  bool isLoading = false;
  bool ispincodeCorrect = false;
  @override
  void initState() {
    super.initState();
  }

  AlertDialog pincodeAlert = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const <Widget>[
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text(
          " Error",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    content: const Text("Please Enter a Valid Pincode and Verify"),
  );

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Address'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: addressLine1Controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address Line 1',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: addressLine2Controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address Line 2',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: landmarkController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Landmark',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                      ],
                      keyboardType: TextInputType.number,
                      controller: pincodeController,
                      onChanged: (String value) {
                        setState(() {
                          ispincodeVerified = false;
                          ispincodeCorrect = false;
                          cityController.text = "";
                          stateController.text = "";
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Pincode',
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        if (isLoading) return;
                        verifyPincode(pincodeController.text).then((value) => {
                              if (value == true)
                                {
                                  setState(() {
                                    isLoading = false;
                                    ispincodeVerified = true;
                                    ispincodeCorrect = true;
                                    cityController.text = cityName;
                                    stateController.text = stateName;
                                  })
                                }
                              else
                                {
                                  setState(() {
                                    isLoading = false;
                                    ispincodeVerified = true;
                                    ispincodeCorrect = false;
                                    cityController.text = "";
                                    stateController.text = "";
                                  })
                                }
                            });
                        setState(() {
                          isLoading = true;
                        });
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : ispincodeVerified
                              ? ispincodeCorrect
                                  ? const Icon(
                                      Icons.verified,
                                      color: Colors.white,
                                    )
                                  : const Icon(Icons.error, color: Colors.white)
                              : const Text(
                                  "VERIFY",
                                  style: TextStyle(color: Colors.white),
                                ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                enabled: false,
                controller: cityController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'City',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                enabled: false,
                controller: stateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'State',
                ),
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
                controller: venueNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Venue Name',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: venueCapacityController,
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
                        title: Text(e["EventType"]),
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
                Text('Address Line1: ${addressLine1Controller.text}'),
                Text('Address Line2: ${addressLine2Controller.text}'),
                Text('Landmark: ${landmarkController.text}'),
                Text('Pincode: ${pincodeController.text}'),
                Text('Venue Name: ${venueNameController.text}'),
                Text('Venue Capacity: ${venueCapacityController.text}'),
              ],
            ),
          ),
        ),
      ];

  String validValues(
      var line1, var line2, var landmark, var venuename, var capacity) {
    if (line1 == "" ||
        line2 == "" ||
        landmark == "" ||
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
              if (!ispincodeCorrect) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return pincodeAlert;
                  },
                );
              } else {
                String input = validValues(
                    addressLine1Controller.text,
                    addressLine2Controller.text,
                    landmarkController.text,
                    venueNameController.text,
                    venueCapacityController.text);
                if (input == "valid") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RequestSubmitted(
                                line1: addressLine1Controller.text,
                                line2: addressLine2Controller.text,
                                landmark: landmarkController.text,
                                pincode: pincodeController.text,
                                cityName: cityController.text,
                                stateName: stateController.text,
                                name: venueNameController.text,
                                capacity: venueCapacityController.text,
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
  final line1, line2, landmark, pincode, cityName, stateName;
  final name, capacity, email;
  final contact, ownername;
  final venueEventTypes;
  const RequestSubmitted(
      {Key? key,
      this.line1,
      this.line2,
      this.landmark,
      this.pincode,
      this.cityName,
      this.stateName,
      this.name,
      this.capacity,
      this.email,
      this.contact,
      this.ownername,
      this.venueEventTypes})
      : super(key: key);

  @override
  _RequestSubmittedState createState() => _RequestSubmittedState(
      line1,
      line2,
      landmark,
      pincode,
      cityName,
      stateName,
      name,
      capacity,
      email,
      contact,
      ownername,
      venueEventTypes);
}

class _RequestSubmittedState extends State<RequestSubmitted> {
  String line1, line2, landmark, pincode, cityName, stateName;
  String name, capacity, email;
  String contact, ownername;
  var venueEventTypes;
  _RequestSubmittedState(
      this.line1,
      this.line2,
      this.landmark,
      this.pincode,
      this.cityName,
      this.stateName,
      this.name,
      this.capacity,
      this.email,
      this.contact,
      this.ownername,
      this.venueEventTypes);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sendVenueRequest(
          line1,
          line2,
          landmark,
          pincode,
          cityName,
          stateName,
          name,
          capacity,
          email,
          contact,
          ownername,
          venueEventTypes),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const Error(title: 'Error From Request Submitted'),
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
