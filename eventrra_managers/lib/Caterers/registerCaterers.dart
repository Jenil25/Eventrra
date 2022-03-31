// ignore_for_file: prefer_typing_uninitialized_variables, no_logic_in_create_state

import 'package:eventrra_managers/Caterers/caterersHome.dart';
import 'package:flutter/material.dart';
import 'package:eventrra_managers/main.dart';
import 'package:eventrra_managers/data.dart';
import 'package:flutter/services.dart';

class RegisterCaterers extends StatefulWidget {
  final name, email, contactNo;
  const RegisterCaterers(
      {Key? key,
      required this.name,
      required this.email,
      required this.contactNo})
      : super(key: key);

  @override
  _RegisterCaterersState createState() =>
      _RegisterCaterersState(name, email, contactNo);
}

class _RegisterCaterersState extends State<RegisterCaterers> {
  final name, email, contactNo;

  _RegisterCaterersState(this.name, this.email, this.contactNo);

  int _activeStepIndex = 0;

  TextEditingController addressLine1Controller = TextEditingController(),
      addressLine2Controller = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController catererNameController = TextEditingController();

  bool ispincodeVerified = false;
  bool isLoading = false;
  bool ispincodeCorrect = false;

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
          title: const Text('Caterer Details'),
          content: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: catererNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Caterer Name',
                ),
              ),
            ],
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 2,
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
                Text('Caterer Name: ${catererNameController.text}'),
              ],
            ),
          ),
        ),
      ];

  String validValues(var line1, var line2, var landmark, var caterername) {
    if (line1 == "" || line2 == "" || landmark == "" || caterername == "") {
      return "Please Fill in all the details";
    }

    return "valid";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    catererNameController.text);
                if (input == "valid") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CaterersRequestSubmitted(
                        line1: addressLine1Controller.text,
                        line2: addressLine2Controller.text,
                        landmark: landmarkController.text,
                        pincode: pincodeController.text,
                        city: cityController.text,
                        state: stateController.text,
                        name: catererNameController.text,
                        email: email,
                        contact: contactNo,
                        ownername: name,
                      ),
                    ),
                  );
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

class CaterersRequestSubmitted extends StatefulWidget {
  final line1, line2, landmark, pincode, city, state;
  final name, email;
  final contact, ownername;
  const CaterersRequestSubmitted(
      {Key? key,
      this.line1,
      this.line2,
      this.landmark,
      this.pincode,
      this.city,
      this.state,
      this.name,
      this.email,
      this.contact,
      this.ownername})
      : super(key: key);

  @override
  _CaterersRequestSubmittedState createState() =>
      _CaterersRequestSubmittedState(line1, line2, landmark, pincode, city,
          state, name, email, contact, ownername);
}

class _CaterersRequestSubmittedState extends State<CaterersRequestSubmitted> {
  String line1, line2, landmark, pincode, city, state;
  String name, email;
  String contact, ownername;
  _CaterersRequestSubmittedState(
      this.line1,
      this.line2,
      this.landmark,
      this.pincode,
      this.city,
      this.state,
      this.name,
      this.email,
      this.contact,
      this.ownername);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sendCaterersRequest(line1, line2, landmark, pincode, city, state,
          name, email, contact, ownername),
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
          isCatererVerified = false;
          return const CaterersHome();
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
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
