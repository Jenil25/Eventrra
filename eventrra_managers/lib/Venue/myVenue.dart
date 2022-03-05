import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eventrra_managers/data.dart';
import 'editVenue.dart';
import 'package:eventrra_managers/main.dart';

class MyVenue extends StatefulWidget {
  const MyVenue({Key? key}) : super(key: key);

  @override
  _MyVenueState createState() => _MyVenueState();
}

// class _MyVenueState extends State<MyVenue> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(currentVenue["Name"]),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             child: const Text("Request New Event Type"),
//             onPressed: () {},
//           )
//         ],
//       ),
//     );
//   }
// }

// class RequestEventType extends StatefulWidget {
//   const RequestEventType({Key? key}) : super(key: key);
//
//   @override
//   _RequestEventTypeState createState() => _RequestEventTypeState();
// }
//
// class _RequestEventTypeState extends State<RequestEventType> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Request new Venue"),
//       ),
//     );
//   }
// }

class _MyVenueState extends State<MyVenue> {
  TextEditingController eventTypeController = TextEditingController();

  bool isClicked = false, isLoading = false, isDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EditVenue()));
            },
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 290,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue.shade50),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.deepOrange.shade300),
                      child: Center(
                        child: Text(
                          // "J",
                          currentVenue["OwnerName"][0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      currentVenue["OwnerName"],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    makeField(Icons.email, currentVenue["Email"],
                        MainAxisAlignment.center),
                    const SizedBox(
                      height: 10,
                    ),
                    makeField(Icons.phone, currentVenue["Contact"],
                        MainAxisAlignment.center),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue.shade50),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    makeField(Icons.apartment, currentVenue["Name"],
                        MainAxisAlignment.start),
                    const SizedBox(
                      height: 5,
                    ),
                    makeField(Icons.location_on, currentVenueAddress["Line1"],
                        MainAxisAlignment.start),
                    makeField(null, currentVenueAddress["Line2"],
                        MainAxisAlignment.start),
                    makeField(
                        null,
                        currentVenueCity["Name"] +
                            " - " +
                            currentVenueCity["Pincode"],
                        MainAxisAlignment.start),
                    makeField(null, currentVenueCity["State"],
                        MainAxisAlignment.start),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                  color: Colors.transparent,
                  child: StatefulBuilder(builder:
                      (BuildContext context, StateSetter setModalState) {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0)),
                      ),
                      padding: MediaQuery.of(context).viewInsets,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Add New Event Type",
                              style: TextStyle(
                                color: Colors.blue.shade500,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextField(
                                controller: eventTypeController,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      if (isLoading) return;
                                      setModalState(() {
                                        isLoading = true;
                                      });
                                      addEventType(
                                              eventTypeController.text
                                                  .toString(),
                                              currentVenue["VId"])
                                          .then((value) => {
                                                if (value == true)
                                                  {
                                                    print("If"),
                                                    setModalState(() {
                                                      eventTypeController.text =
                                                          "";
                                                      isLoading = false;
                                                      isClicked = true;
                                                      isDone = true;
                                                    })
                                                  }
                                                else
                                                  {
                                                    print("Else"),
                                                    setModalState(() {
                                                      isLoading = false;
                                                      isClicked = true;
                                                      isDone = false;
                                                    })
                                                  }
                                              });
                                    },
                                    child: const Text(
                                      "Add",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 100,
                                  // color: Colors.blue.shade300,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                isLoading == true
                                    ? const CircularProgressIndicator()
                                    : isClicked == true
                                        ? isDone == true
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: const Text("Added"),
                                              )
                                            : const Text("Error")
                                        : const Text("")
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
            );
          },
          label: const Text("Add New Event Type")),
    );
  }

  Widget makeField(
      IconData? iconData, String value, MainAxisAlignment alignment) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        Icon(iconData),
        const SizedBox(
          width: 10,
        ),
        Text(
          value,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:eventrra_managers/data.dart';
// import 'editVenue.dart';
//
// class MyVenue extends StatefulWidget {
//   const MyVenue({Key? key}) : super(key: key);
//
//   @override
//   _MyVenueState createState() => _MyVenueState();
// }
//
// // class _MyVenueState extends State<MyVenue> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(currentVenue["Name"]),
// //       ),
// //       body: Column(
// //         children: [
// //           ElevatedButton(
// //             child: const Text("Request New Event Type"),
// //             onPressed: () {},
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// // class RequestEventType extends StatefulWidget {
// //   const RequestEventType({Key? key}) : super(key: key);
// //
// //   @override
// //   _RequestEventTypeState createState() => _RequestEventTypeState();
// // }
// //
// // class _RequestEventTypeState extends State<RequestEventType> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Request new Venue"),
// //       ),
// //     );
// //   }
// // }
//
// class _MyVenueState extends State<MyVenue> {
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     Color color = const Color(0xFF1B0250);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(" "),
//       ),
//       body: Column(
//         children: [
//           Container(
//               height: 0.6 * height,
//               width: 0.70 * width,
//               margin: EdgeInsets.only(top: 120, left: 55),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFf2f2f2),
//                 borderRadius: BorderRadius.circular(15.0),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color(0xFF8A959E),
//                     blurRadius: 30.0,
//                     spreadRadius: 0,
//                     offset: Offset(0.0, 10.0),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 50),
//                   Text(
//                     "Name : " + currentVenue["Name"],
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: color,
//                     ),
//                   ),
//                   const Divider(
//                     thickness: 2,
//                     color: Colors.blueAccent,
//                     indent: 10,
//                     endIndent: 10,
//                   ),
//                   Text(
//                     "OwnerName : " + currentVenue["OwnerName"],
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: color,
//                     ),
//                   ),
//                   const Divider(
//                     thickness: 2,
//                     color: Colors.blueAccent,
//                     indent: 10,
//                     endIndent: 10,
//                   ),
//                   Text(
//                     "Email : " + currentVenue["Email"],
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: color,
//                     ),
//                   ),
//                   const Divider(
//                     thickness: 2,
//                     color: Colors.blueAccent,
//                     indent: 10,
//                     endIndent: 10,
//                   ),
//                   Text(
//                     "Contact : " + currentVenue["Contact"],
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: color,
//                     ),
//                   ),
//                   const Divider(
//                     thickness: 2,
//                     color: Colors.blueAccent,
//                     indent: 10,
//                     endIndent: 10,
//                   ),
//                   Text(
//                     "Capacity : " + currentVenue["Capacity"],
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: color,
//                     ),
//                   ),
//                   const Divider(
//                     thickness: 2,
//                     color: Colors.blueAccent,
//                     indent: 10,
//                     endIndent: 10,
//                   ),
//                   Text(
//                     "Address : " +
//                         currentVenueAddress["Line1"] +
//                         " , " +
//                         currentVenueAddress["Line2"],
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: color,
//                     ),
//                   ),
//                   const Divider(
//                     thickness: 2,
//                     color: Colors.blueAccent,
//                     indent: 10,
//                     endIndent: 10,
//                   ),
//                   Text(
//                     "Landmark : " + currentVenueAddress["Landmark"],
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: color,
//                     ),
//                   ),
//                   const Divider(
//                     thickness: 2,
//                     color: Colors.blueAccent,
//                     indent: 10,
//                     endIndent: 10,
//                   ),
//                   Text(
//                     "City : " + currentVenueCity["Name"],
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: color,
//                     ),
//                   ),
//                   const Divider(
//                     thickness: 2,
//                     color: Colors.blueAccent,
//                     indent: 10,
//                     endIndent: 10,
//                   ),
//                   Text(
//                     "State : " + currentVenueCity["State"],
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: color,
//                     ),
//                   ),
//                   const Divider(
//                     thickness: 2,
//                     color: Colors.blueAccent,
//                     indent: 10,
//                     endIndent: 10,
//                   ),
//                   Text(
//                     "PinCode : " + currentVenueCity["Pincode"],
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: color,
//                     ),
//                   ),
//                 ],
//               )),
//           Container(
//             child: Column(children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => EditVenue()));
//                 },
//                 child: const Text(
//                   "Edit",
//                   style: TextStyle(color: Color(0xFF1B0250), fontSize: 17),
//                 ),
//               ),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
// }
