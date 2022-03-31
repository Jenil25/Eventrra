import 'dart:collection';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:eventrra/data.dart';
import 'selectVenue.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({Key? key}) : super(key: key);

  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  var selectedCity = cities[0];
  var selectedEventType = eventTypes[0];
  late DateTime now = DateTime.now(),
      currentDate = DateTime.now(),
      toDate = DateTime.now(),
      todaysDate = DateTime.now();

  var cityAddresses = [];
  var cityVenues = [];
  // ignore: non_constant_identifier_names
  void getCityAddresses(int CId) {
    cityAddresses = [];
    cityVenues = [];
    for (int i = 0; i < addresses.length; ++i) {
      if (int.parse(addresses[i]["CId"]) == CId) {
        cityAddresses.add(addresses[i]);
        for (int j = 0; j < venues.length; ++j) {
          if (venues[j]["AId"] == addresses[i]["AId"]) {
            cityVenues.add(venues[j]);
          }
        }
      }
    }
    setState(() {});
  }

  var fontSize = 20.0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(todaysDate.year),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != currentDate) {
      if (pickedDate.year <= todaysDate.year &&
          pickedDate.month <= todaysDate.month &&
          pickedDate.day <= todaysDate.day) {
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
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text("Please enter a valid date for new event!"),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      } else {
        setState(() {
          currentDate = pickedDate;
        });
      }
    }
  }

  Future<void> _toDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: toDate,
        firstDate: DateTime(todaysDate.year),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != toDate) {
      if (pickedDate.year <= todaysDate.year &&
          pickedDate.month <= todaysDate.month &&
          pickedDate.day <= todaysDate.day) {
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
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text("Please enter a valid date for new event!"),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      } else {
        setState(() {
          toDate = pickedDate;
        });
      }
    }
  }

  var selectedValue = eventTypes[0], selectedValueCity = cities[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: const Text("SELECT CITY"),
                  width: MediaQuery.of(context).size.width * 0.85,
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Select City',
                            style: TextStyle(
                              fontSize: fontSize,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: cities
                        .map((item) =>
                            DropdownMenuItem<LinkedHashMap<String, dynamic>>(
                              value: item,
                              child: Text(
                                item["Name"].toString(),
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValueCity,
                    onChanged: (value) {
                      setState(() {
                        selectedValueCity = value;
                        selectedCity = value;
                        getCityAddresses(int.parse(selectedCity["CId"]));
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 70,
                    buttonWidth: MediaQuery.of(context).size.width * 0.85,
                    buttonPadding: const EdgeInsets.only(left: 30, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.white,
                    ),
                    buttonElevation: 0,
                    itemHeight: 50,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: MediaQuery.of(context).size.width * 0.85,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    dropdownElevation: 0,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            Column(
              children: [
                SizedBox(
                  child: const Text("FROM DATE"),
                  width: MediaQuery.of(context).size.width * 0.85,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        currentDate.day.toString() +
                            "-" +
                            currentDate.month.toString() +
                            "-" +
                            currentDate.year.toString(),
                        style: TextStyle(fontSize: fontSize),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () => _selectDate(context),
                          child: const Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                SizedBox(
                  child: const Text("TO DATE"),
                  width: MediaQuery.of(context).size.width * 0.85,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        toDate.day.toString() +
                            "-" +
                            toDate.month.toString() +
                            "-" +
                            toDate.year.toString(),
                        style: TextStyle(fontSize: fontSize),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () => _toDate(context),
                          child: const Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: const Text("SELECT EVENTTYPE"),
                  width: MediaQuery.of(context).size.width * 0.85,
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Select EventType',
                            style: TextStyle(
                              fontSize: fontSize,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: eventTypes
                        .map((item) =>
                            DropdownMenuItem<LinkedHashMap<String, dynamic>>(
                              value: item,
                              child: Text(
                                item["EventType"].toString(),
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                        selectedEventType = value;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 70,
                    buttonWidth: MediaQuery.of(context).size.width * 0.85,
                    buttonPadding: const EdgeInsets.only(left: 30, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.white,
                    ),
                    buttonElevation: 0,
                    itemHeight: 50,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: MediaQuery.of(context).size.width * 0.85,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    dropdownElevation: 0,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            ElevatedButton(
              onPressed: () {
                inputCity = selectedCity;
                inputFDate = currentDate;
                inputTDate = toDate;
                inputEventType = selectedEventType;
                if ((toDate.year == todaysDate.year &&
                        toDate.month == todaysDate.month &&
                        toDate.day == todaysDate.day) ||
                    (currentDate.year == todaysDate.year &&
                        currentDate.month == todaysDate.month &&
                        currentDate.day == todaysDate.day)) {
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
                    content:
                        const Text("Please enter a valid date for new event!"),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectVenue(
                              city: selectedCity,
                              fdate: currentDate,
                              tdate: toDate,
                              eventType: selectedEventType)));
                }
              },
              child: Text(
                'Continue',
                style: TextStyle(fontSize: fontSize - 3),
              ),
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
