import 'package:flutter/material.dart';
import 'package:eventrra/data.dart';
import 'package:flutter/widgets.dart';
import 'new.dart';
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

  // now = DateTime.now();
  // currentDate = DateTime(now.year, now.month, now.day + 1);
  // todaysDate = DateTime.now();

  var cityAddresses = [];
  var cityVenues = [];
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
    // print("NEW PRINT:" + cityVenues.length.toString());
    // for (int j = 0; j < cityVenues.length; ++j) {
    //   print(cityVenues[j]);
    // }
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

  @override
  Widget build(BuildContext context) {
    print("Selected city : " + selectedCity['Name']);
    print("Selected Event Type :  " + selectedEventType['EventType']);
    print("now :  $now ");
    print("currentDate :  $currentDate ");
    print("todaysDate :  $todaysDate ");

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 3,
                ),
                const Text("Select City: "),
                const Spacer(
                  flex: 1,
                ),
                DropdownButton(
                  hint: const Text('Please choose a city'),
                  value: selectedCity,
                  onChanged: (newValue) {
                    setState(() {
                      newValue as Map;
                      selectedCity = newValue;
                      // cityChanged = true;
                      getCityAddresses(int.parse(newValue["CId"]));
                    });
                  },
                  items: cities.map((city) {
                    return DropdownMenuItem(
                      child: Text(city["Name"]),
                      value: city,
                    );
                  }).toList(),
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
            // Column(
            //   children: [
            //     SizedBox(
            //       height: MediaQuery.of(context).size.height / 1.2,
            //       child: ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: cityVenues.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return Card(
            //             margin: EdgeInsets.all(10.0),
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(10.0),
            //             ),
            //             color: Colors.blue.shade100,
            //             child: Container(
            //               margin: EdgeInsets.all(5.0),
            //               padding: EdgeInsets.only(left: 20.0),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: <Widget>[
            //                   ElevatedButton(
            //                     onPressed: () {
            //                       // setState(() {
            //                       //   Navigator.push(
            //                       //       context,
            //                       //       MaterialPageRoute(
            //                       //           builder: (context) => OrderDetails(
            //                       //                 order: orders[index],
            //                       //               )));
            //                       // });
            //                     },
            //                     child: Container(
            //                       alignment: Alignment.centerLeft,
            //                       child: Column(
            //                         children: <Widget>[
            //                           Text("${cityVenues[index]["Name"]}"),
            //                           Container(
            //                             child: Text(
            //                               "${cityVenues[index]["AId"]}",
            //                               style: TextStyle(
            //                                 color: Colors.blue.shade900,
            //                               ),
            //                             ),
            //                           )
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            const Spacer(
              flex: 1,
            ),
            // SizedBox(
            //   height: 20.0,
            // ),
            // Row(
            //   children: [
            //     const Spacer(
            //       flex: 3,
            //     ),
            //     const Text("Select From Date: "),
            //     const Spacer(
            //       flex: 1,
            //     ),
            //     ElevatedButton(
            //       onPressed: () => _selectDate(context),
            //       child: Text(
            //         'Select date',
            //         style: TextStyle(fontSize: fontSize - 3),
            //       ),
            //     ),
            //     const Spacer(
            //       flex: 1,
            //     ),
            //     Text(
            //       currentDate.day.toString() +
            //           "-" +
            //           currentDate.month.toString() +
            //           "-" +
            //           currentDate.year.toString(),
            //       style: TextStyle(fontSize: fontSize),
            //     ),
            //     const Spacer(
            //       flex: 3,
            //     ),
            //   ],
            // ),
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
                          // child: Text(
                          //   'Select date',
                          //   style: TextStyle(fontSize: fontSize - 3),
                          // ),
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
            Spacer(),
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
                          // child: Text(
                          //   'Select date',
                          //   style: TextStyle(fontSize: fontSize - 3),
                          // ),
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
            Row(
              children: [
                const Spacer(
                  flex: 3,
                ),
                const Text("Select Event-Type: "),
                const Spacer(
                  flex: 1,
                ),
                DropdownButton(
                  hint: const Text('Please choose event type'),
                  value: selectedEventType,
                  onChanged: (newValue) {
                    setState(() {
                      newValue as Map;
                      selectedEventType = newValue;
                    });
                  },
                  items: eventTypes.map((type) {
                    return DropdownMenuItem(
                      child: Text(type["EventType"]),
                      value: type,
                    );
                  }).toList(),
                ),
                const Spacer(
                  flex: 3,
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

//Venues:
// Column(
// children: [
// SizedBox(
// height: MediaQuery.of(context).size.height / 1.2,
// child: ListView.builder(
// shrinkWrap: true,
// itemCount: cityVenues.length,
// itemBuilder: (BuildContext context, int index) {
// return Card(
// margin: EdgeInsets.all(10.0),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10.0),
// ),
// color: Colors.blue.shade100,
// child: Container(
// margin: EdgeInsets.all(5.0),
// padding: EdgeInsets.only(left: 20.0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// ElevatedButton(
// onPressed: () {
// // setState(() {
// //   Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //           builder: (context) => OrderDetails(
// //                 order: orders[index],
// //               )));
// // });
// },
// child: Container(
// alignment: Alignment.centerLeft,
// child: Column(
// children: <Widget>[
// Text("${cityVenues[index]["Name"]}"),
// Container(
// child: Text(
// "${cityVenues[index]["AId"]}",
// style: TextStyle(
// color: Colors.blue.shade900,
// ),
// ),
// )
// ],
// ),
// ),
// ),
// ],
// ),
// ),
// );
// },
// ),
// ),
// ],
// ),

//----------------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:eventrra/data.dart';
// import 'new.dart';
// import 'selectVenue.dart';
//
// class NewEvent extends StatefulWidget {
//   const NewEvent({Key? key}) : super(key: key);
//
//   @override
//   _NewEventState createState() => _NewEventState();
// }
//
// class _NewEventState extends State<NewEvent> {
//   var selectedCity = cities[0];
//   var selectedEventType = eventTypes[0];
//   late DateTime now = DateTime.now(),
//       currentDate = DateTime.now(),
//       todaysDate = DateTime.now();
//   // now = DateTime.now();
//   // currentDate = DateTime(now.year, now.month, now.day + 1);
//   // todaysDate = DateTime.now();
//
//   var cityAddresses = [];
//   var cityVenues = [];
//   void getCityAddresses(int CId) {
//     cityAddresses = [];
//     cityVenues = [];
//     for (int i = 0; i < addresses.length; ++i) {
//       if (int.parse(addresses[i]["CId"]) == CId) {
//         cityAddresses.add(addresses[i]);
//         for (int j = 0; j < venues.length; ++j) {
//           if (venues[j]["AId"] == addresses[i]["AId"]) {
//             cityVenues.add(venues[j]);
//           }
//         }
//       }
//     }
//     // print("NEW PRINT:" + cityVenues.length.toString());
//     // for (int j = 0; j < cityVenues.length; ++j) {
//     //   print(cityVenues[j]);
//     // }
//     setState(() {});
//   }
//
//   var fontSize = 20.0;
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: currentDate,
//         firstDate: DateTime(todaysDate.year),
//         lastDate: DateTime(2100));
//     if (pickedDate != null && pickedDate != currentDate) {
//       if (pickedDate.year <= todaysDate.year &&
//           pickedDate.month <= todaysDate.month &&
//           pickedDate.day <= todaysDate.day) {
//         AlertDialog alert = AlertDialog(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: const <Widget>[
//               Icon(
//                 Icons.error,
//                 color: Colors.red,
//               ),
//               Text(
//                 " Error",
//                 style:
//                     TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           content: const Text("Please enter a valid date for new event!"),
//         );
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return alert;
//           },
//         );
//       } else {
//         setState(() {
//           currentDate = pickedDate;
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("New Event"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Spacer(
//             flex: 3,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Spacer(
//                 flex: 3,
//               ),
//               const Text("Select City: "),
//               const Spacer(
//                 flex: 1,
//               ),
//               DropdownButton(
//                 hint: const Text('Please choose a city'),
//                 value: selectedCity,
//                 onChanged: (newValue) {
//                   setState(() {
//                     newValue as Map;
//                     selectedCity = newValue;
//                     // cityChanged = true;
//                     getCityAddresses(int.parse(newValue["CId"]));
//                   });
//                 },
//                 items: cities.map((city) {
//                   return DropdownMenuItem(
//                     child: Text(city["Name"]),
//                     value: city,
//                   );
//                 }).toList(),
//               ),
//               const Spacer(
//                 flex: 3,
//               ),
//             ],
//           ),
//           ElevatedButton(
//             onPressed: () => {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => NEvent()))
//             },
//             child: const Text("New Page"),
//           ),
//           // Column(
//           //   children: [
//           //     SizedBox(
//           //       height: MediaQuery.of(context).size.height / 1.2,
//           //       child: ListView.builder(
//           //         shrinkWrap: true,
//           //         itemCount: cityVenues.length,
//           //         itemBuilder: (BuildContext context, int index) {
//           //           return Card(
//           //             margin: EdgeInsets.all(10.0),
//           //             shape: RoundedRectangleBorder(
//           //               borderRadius: BorderRadius.circular(10.0),
//           //             ),
//           //             color: Colors.blue.shade100,
//           //             child: Container(
//           //               margin: EdgeInsets.all(5.0),
//           //               padding: EdgeInsets.only(left: 20.0),
//           //               child: Row(
//           //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //                 children: <Widget>[
//           //                   ElevatedButton(
//           //                     onPressed: () {
//           //                       // setState(() {
//           //                       //   Navigator.push(
//           //                       //       context,
//           //                       //       MaterialPageRoute(
//           //                       //           builder: (context) => OrderDetails(
//           //                       //                 order: orders[index],
//           //                       //               )));
//           //                       // });
//           //                     },
//           //                     child: Container(
//           //                       alignment: Alignment.centerLeft,
//           //                       child: Column(
//           //                         children: <Widget>[
//           //                           Text("${cityVenues[index]["Name"]}"),
//           //                           Container(
//           //                             child: Text(
//           //                               "${cityVenues[index]["AId"]}",
//           //                               style: TextStyle(
//           //                                 color: Colors.blue.shade900,
//           //                               ),
//           //                             ),
//           //                           )
//           //                         ],
//           //                       ),
//           //                     ),
//           //                   ),
//           //                 ],
//           //               ),
//           //             ),
//           //           );
//           //         },
//           //       ),
//           //     ),
//           //   ],
//           // ),
//           const Spacer(
//             flex: 1,
//           ),
//           // SizedBox(
//           //   height: 20.0,
//           // ),
//           Row(
//             children: [
//               const Spacer(
//                 flex: 3,
//               ),
//               const Text("Select Date: "),
//               const Spacer(
//                 flex: 1,
//               ),
//               ElevatedButton(
//                 onPressed: () => _selectDate(context),
//                 child: Text(
//                   'Select date',
//                   style: TextStyle(fontSize: fontSize - 3),
//                 ),
//               ),
//               const Spacer(
//                 flex: 1,
//               ),
//               Text(
//                 currentDate.day.toString() +
//                     "-" +
//                     currentDate.month.toString() +
//                     "-" +
//                     currentDate.year.toString(),
//                 style: TextStyle(fontSize: fontSize),
//               ),
//               const Spacer(
//                 flex: 3,
//               ),
//             ],
//           ),
//           const Spacer(
//             flex: 1,
//           ),
//           Row(
//             children: [
//               const Spacer(
//                 flex: 3,
//               ),
//               const Text("Select Event-Type: "),
//               const Spacer(
//                 flex: 1,
//               ),
//               DropdownButton(
//                 hint: const Text('Please choose event type'),
//                 value: selectedEventType,
//                 onChanged: (newValue) {
//                   setState(() {
//                     newValue as Map;
//                     selectedEventType = newValue;
//                   });
//                 },
//                 items: eventTypes.map((type) {
//                   return DropdownMenuItem(
//                     child: Text(type["Event-Type"]),
//                     value: type,
//                   );
//                 }).toList(),
//               ),
//               const Spacer(
//                 flex: 3,
//               ),
//             ],
//           ),
//           const Spacer(
//             flex: 1,
//           ),
//           ElevatedButton(
//             onPressed: () => {
//               //   Navigator.of(context).push(MaterialPageRoute(
//               //       builder: (context) => const SelectVenue(
//               //           city: selectedCity,
//               //           date: currentDate,
//               //           eventType: selectedEventType)))
//             },
//             child: Text(
//               'Continue',
//               style: TextStyle(fontSize: fontSize - 3),
//             ),
//           ),
//           const Spacer(
//             flex: 3,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// //Venues:
// // Column(
// // children: [
// // SizedBox(
// // height: MediaQuery.of(context).size.height / 1.2,
// // child: ListView.builder(
// // shrinkWrap: true,
// // itemCount: cityVenues.length,
// // itemBuilder: (BuildContext context, int index) {
// // return Card(
// // margin: EdgeInsets.all(10.0),
// // shape: RoundedRectangleBorder(
// // borderRadius: BorderRadius.circular(10.0),
// // ),
// // color: Colors.blue.shade100,
// // child: Container(
// // margin: EdgeInsets.all(5.0),
// // padding: EdgeInsets.only(left: 20.0),
// // child: Row(
// // mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // children: <Widget>[
// // ElevatedButton(
// // onPressed: () {
// // // setState(() {
// // //   Navigator.push(
// // //       context,
// // //       MaterialPageRoute(
// // //           builder: (context) => OrderDetails(
// // //                 order: orders[index],
// // //               )));
// // // });
// // },
// // child: Container(
// // alignment: Alignment.centerLeft,
// // child: Column(
// // children: <Widget>[
// // Text("${cityVenues[index]["Name"]}"),
// // Container(
// // child: Text(
// // "${cityVenues[index]["AId"]}",
// // style: TextStyle(
// // color: Colors.blue.shade900,
// // ),
// // ),
// // )
// // ],
// // ),
// // ),
// // ),
// // ],
// // ),
// // ),
// // );
// // },
// // ),
// // ),
// // ],
// // ),
