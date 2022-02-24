import 'package:dropdown_below/dropdown_below.dart';
import 'package:eventrra_managers/Caterers/caterersHome.dart';
import 'package:flutter/material.dart';
import 'package:eventrra_managers/main.dart';
import 'package:eventrra_managers/data.dart';

class RegisterCaterers extends StatefulWidget {
  final name, email, contactNo;
  const RegisterCaterers({Key? key, this.name, this.email, this.contactNo})
      : super(key: key);

  @override
  _RegisterCaterersState createState() =>
      _RegisterCaterersState(name, email, contactNo);
}

class _RegisterCaterersState extends State<RegisterCaterers> {
  final name, email, contactNo;

  _RegisterCaterersState(this.name, this.email, this.contactNo);

  int _activeStepIndex = 0;
  bool _chooseacity = true;

  TextEditingController addressLine1 = TextEditingController(),
      addressLine2 = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController catererName = TextEditingController();

  List<DropdownMenuItem> _dropdownCityItems = [];
  var _selectedCity = null;

  List<DropdownMenuItem> buildDropdownCityItems(var _list) {
    List<DropdownMenuItem> items = [];
    for (var i in _list) {
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
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, bottom: 15),
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
                    boxPadding: const EdgeInsets.fromLTRB(13, 18, 0, 12),
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
          title: const Text('Caterer Details'),
          content: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: catererName,
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
                Text('Address Line1: ${addressLine1.text}'),
                Text('Address Line2: ${addressLine2.text}'),
                Text('Landmark: ${landmark.text}'),
                _selectedCity == null
                    ? const Text('City: ')
                    : Text('City: ${_selectedCity["Name"]}'),
                Text('Caterer Name: ${catererName.text}'),
              ],
            ),
          ),
        ),
      ];

  String validValues(
      var line1, var line2, var landmark, var city, var caterername) {
    if (line1 == "" ||
        line2 == "" ||
        landmark == "" ||
        city == null ||
        caterername == "") return "Please Fill in all the details";

    return "valid";
  }

  @override
  void initState() {
    _dropdownCityItems = buildDropdownCityItems(cities);
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
              String input = validValues(addressLine1.text, addressLine2.text,
                  landmark.text, _selectedCity, catererName.text);
              if (input == "valid") {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CaterersRequestSubmitted(
                              line1: addressLine1.text,
                              line2: addressLine2.text,
                              landmark: landmark.text,
                              cid: _selectedCity["CId"],
                              name: catererName.text,
                              email: email,
                              contact: contactNo,
                              ownername: name,
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

class CaterersRequestSubmitted extends StatefulWidget {
  final line1, line2, landmark, cid;
  final name, email;
  final contact, ownername;
  const CaterersRequestSubmitted(
      {Key? key,
      this.line1,
      this.line2,
      this.landmark,
      this.cid,
      this.name,
      this.email,
      this.contact,
      this.ownername})
      : super(key: key);

  // print("");
  @override
  _CaterersRequestSubmittedState createState() =>
      _CaterersRequestSubmittedState(this.line1, this.line2, this.landmark,
          this.cid, this.name, this.email, this.contact, this.ownername);
}

class _CaterersRequestSubmittedState extends State<CaterersRequestSubmitted> {
  String line1, line2, landmark, cid;
  String name, email;
  String contact, ownername;
  _CaterersRequestSubmittedState(this.line1, this.line2, this.landmark,
      this.cid, this.name, this.email, this.contact, this.ownername);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sendCaterersRequest(
          line1, line2, landmark, cid, name, email, contact, ownername),
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
          return CaterersHome();
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
