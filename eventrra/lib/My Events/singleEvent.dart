import 'package:flutter/material.dart';
import 'package:eventrra/data.dart';
import 'package:timelines/timelines.dart';
import 'package:intl/intl.dart';

class SingleEvent extends StatefulWidget {
  final event;
  const SingleEvent({Key? key, required this.event}) : super(key: key);

  @override
  State<SingleEvent> createState() => _SingleEventState(this.event);
}

class _SingleEventState extends State<SingleEvent> {
  final event;
  _SingleEventState(this.event);
  @override
  Widget build(BuildContext context) {
    var venue = null,
        caterer = null,
        vaddress = null,
        caddress = null,
        city = null,
        eventtype = null;
    for (int k = 0; k < cities.length; ++k) {
      if (cities[k]["CId"] == event["CId"]) {
        city = cities[k];
        break;
      }
    }
    for (int k = 0; k < eventTypes.length; ++k) {
      if (eventTypes[k]["EtId"] == event["EtId"]) {
        eventtype = eventTypes[k];
        break;
      }
    }
    for (int i = 0; i < venues.length; ++i) {
      if (venues[i]["VId"] == event["VId"]) {
        venue = venues[i];
        for (int j = 0; j < addresses.length; ++j) {
          if (addresses[j]["AId"] == venue["AId"]) {
            vaddress = addresses[j];
            break;
          }
        }
        break;
      }
    }
    if (event["CaId"] != 0) {
      for (int i = 0; i < caterers.length; ++i) {
        if (caterers[i]["CaId"] == event["CaId"]) {
          caterer = caterers[i];
          for (int j = 0; j < addresses.length; ++j) {
            if (addresses[j]["AId"] == caterer["AId"]) {
              caddress = addresses[j];
              break;
            }
          }
          break;
        }
      }
    }
    var status = ["0", "0", "0", "0", "0", "0"];
    var msg = ["", "", "", "", "", ""];
    bool isDeletable = false;

    status[0] = "1";
    msg[0] = "Requested";

    status[1] = event['VerifiedV'];
    if (status[1] == "1") {
      msg[1] = "Accepted By VenueOwner";
    } else if (status[1] == "-1") {
      msg[1] = "Declined by VenueOwner";
      isDeletable = true;
    } else if (status[1] == "0") {
      msg[1] = "Requested for Venue";
      isDeletable = true;
    }

    status[2] = event['VerifiedC'];
    if (status[2] == "1") {
      msg[2] = "Accepted By CateringOwner";
    } else if (status[2] == "-1") {
      msg[2] = "Declined by CateringOwner";
      isDeletable = true;
    } else if (status[2] == "0") {
      msg[2] = "Requested to CateringOwner";
      isDeletable = true;
    }

    status[3] = event['VerifiedO'];
    if (status[3] == "1") {
      msg[3] = "Accepted By OrchestraOwner";
    } else if (status[3] == "-1") {
      msg[3] = "Declined by OrchestraOwner";
      isDeletable = true;
    } else if (status[3] == "0") {
      msg[3] = "Requested to OrchestraOwner";
      isDeletable = true;
    }

    status[4] = event['VerifiedD'];
    if (status[4] == "1") {
      msg[4] = "Accepted By DecoratorOwner";
    } else if (status[4] == "-1") {
      msg[4] = "Declined by DecoratorOwner";
      isDeletable = true;
    } else if (status[4] == "0") {
      msg[4] = "Requested to DecoratorOwner";
      isDeletable = true;
    }

    DateTime current = DateTime.now();
    DateTime tDate = DateFormat("dd-MM-yyyy").parse(event['TDate']);
    DateTime fDate = DateFormat("dd-MM-yyyy").parse(event['FDate']);
    int daysLeft = (fDate.difference(current).inHours / 24).round();
    print("DaysLeft:");
    print(daysLeft);
    if (current.isAfter(tDate) && event["VerifiedV"] != "-1") {
      status[5] = "1";
      msg[5] = "Event Completed";
      isDeletable = false;
    } else {
      status[5] = "0";
      msg[5] = "Event yet to be Scheduled";
      if (daysLeft > 2) {
        isDeletable = true;
      } else {
        isDeletable = false;
      }
    }

    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Column(
    //     children: [
    //       Text("City : " + city['Name']),
    //       Text("From Date : " + event['FDate']),
    //       Text("To Date : " + event['TDate']),
    //       Text("User Details "),
    //       Text("Username : " + event['Name']),
    //       Text("Contact : " + event['Contact']),
    //       Text("Venue Details "),
    //       Text("Venue Name : " + venue['Name']),
    //       Text("Venue Owner : " + venue['OwnerName']),
    //       Text("Venue Email : " + venue['Email']),
    //       Text("Venue Capacity : " + venue['Capacity']),
    //       Text("Venue Contact : " + venue['Contact']),
    //       Text("Venue Address : " +
    //           vaddress['Line1'] +
    //           " , " +
    //           vaddress['Line2'] +
    //           " , " +
    //           vaddress['Landmark']),
    //       caterer != null
    //           ? Column(
    //               children: [
    //                 Text("Caterer Details "),
    //                 Text("Caterer Name : " + caterer['Name']),
    //                 Text("Caterer Owner : " + caterer['OwnerName']),
    //                 Text("Caterer Email : " + caterer['Email']),
    //                 Text("Caterer Contact : " + caterer['Contact']),
    //                 Text("Caterer Address : " +
    //                     caddress['Line1'] +
    //                     " , " +
    //                     caddress['Line2'] +
    //                     " , " +
    //                     caddress['Landmark']),
    //               ],
    //             )
    //           : Container(),
    //         Container(
    //         height: 250,
    //         alignment: Alignment.topCenter,
    //         child: Timeline.tileBuilder(
    //           shrinkWrap: true,
    //           padding: EdgeInsets.zero,
    //           theme: TimelineThemeData(
    //             direction: Axis.horizontal,
    //             connectorTheme: ConnectorThemeData(space: 8.0, thickness: 2.0),
    //           ),
    //           builder: TimelineTileBuilder.connected(
    //             connectionDirection: ConnectionDirection.before,
    //             itemCount: 6,
    //             itemExtentBuilder: (_, __) {
    //               return (MediaQuery.of(context).size.width - 120) / 4.0;
    //             },
    //             oppositeContentsBuilder: (context, index) {
    //               return Container();
    //             },
    //             contentsBuilder: (context, index) {
    //               return Padding(
    //                 padding: const EdgeInsets.only(top: 15.0),
    //                 child: Text(msg[index]),
    //               );
    //             },
    //             indicatorBuilder: (_, index) {
    //                 if(status[index]=="1") {
    //                   return DotIndicator(
    //                     size: 20.0,
    //                     color: Colors.green,
    //                   );
    //                 }
    //                 else if(status[index]=="-1"){
    //                   return DotIndicator(
    //                     size: 20.0,
    //                     color: Colors.red,
    //                   );
    //                 }
    //                 else {
    //                   return OutlinedDotIndicator(
    //                     borderWidth: 4.0,
    //                     color: Colors.green,
    //                   );
    //                 }
    //             },
    //             connectorBuilder: (_, index, type) {
    //               if (index > 0) {
    //                 return SolidLineConnector(
    //                   color: Colors.green,
    //                 );
    //               } else {
    //                 return null;
    //               }
    //             },
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );

    bool isLoading = false;
    bool isClicked = false;
    bool isCorrect = false;

    AlertDialog deleteEventAlert = AlertDialog(
      title: const Text(
        "Are you sure you want to delete this event?",
        style: TextStyle(color: Colors.black),
      ),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
        return Container(
          height: 50,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isLoading
                      ? const CircularProgressIndicator()
                      : isClicked
                          ? const Icon(Icons.done)
                          : TextButton(
                              onPressed: () {
                                if (isClicked) return;
                                setModalState(() {
                                  isLoading = true;
                                });
                                if (isLoading && mounted == true) {
                                  deleteEvent(
                                          event["EId"],
                                          event["UId"],
                                          event["VId"],
                                          event["CaId"],
                                          event["OrId"],
                                          event["DId"],
                                          venue["Name"],
                                          eventtype["EventType"],
                                          event["VerifiedV"],
                                          event["VerifiedC"],
                                          event["VerifiedD"],
                                          event["VerifiedO"],
                                          event["TDate"],
                                          event["FDate"])
                                      .then(
                                    (value) => {
                                      setModalState(() {
                                        isLoading = false;
                                        isClicked = true;
                                        isCorrect = true;
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      }),
                                    },
                                  );
                                }
                                setModalState(() {
                                  isLoading = true;
                                });
                              },
                              child: const Text("YES")),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("NO"),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(venue["Name"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ) //TextStyle
                    ), //Text
                background: Stack(children: [
                  Center(
                    child: venue["image"] != ""
                        ? Image.network(
                            "https://eventrra.000webhostapp.com/images/venue/${venue["image"]}",
                            fit: BoxFit.cover,
                          )
                        : Image.asset("assets/images/noimageavailableicon.jpg"),
                  ),
                  Opacity(
                    opacity: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.grey.shade700,
                            Colors.black,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ), //Images.network
                ]),
              ), //FlexibleSpaceBar
              expandedHeight: 262,
              backgroundColor: Colors.blueAccent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ), //<Widget>[]
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      eventDetails(event, eventtype['EventType'], city['Name'],
                          event['FDate'], event['TDate']),
                      const SizedBox(
                        height: 10,
                      ),
                      userDetails(event['Name'], event['Contact']),
                      const SizedBox(
                        height: 10,
                      ),
                      venueDetails(venue, vaddress),
                      const SizedBox(
                        height: 10,
                      ),
                      event['CaId'] != "0"
                          ? catererDetails(caterer, caddress)
                          : SizedBox(),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Container(
                        height: 200,
                        alignment: Alignment.topCenter,
                        child: Timeline.tileBuilder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          theme: TimelineThemeData(
                            direction: Axis.horizontal,
                            connectorTheme:
                                ConnectorThemeData(space: 8.0, thickness: 2.0),
                          ),
                          builder: TimelineTileBuilder.connected(
                            connectionDirection: ConnectionDirection.before,
                            itemCount: 6,
                            itemExtentBuilder: (_, __) {
                              return (MediaQuery.of(context).size.width - 120) /
                                  4.0;
                            },
                            oppositeContentsBuilder: (context, index) {
                              return Container();
                            },
                            contentsBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(msg[index]),
                              );
                            },
                            indicatorBuilder: (_, index) {
                              if (status[index] == "1") {
                                return DotIndicator(
                                  size: 20.0,
                                  color: Colors.green,
                                );
                              } else if (status[index] == "-1") {
                                return DotIndicator(
                                  size: 20.0,
                                  color: Colors.red,
                                );
                              } else {
                                return OutlinedDotIndicator(
                                  borderWidth: 4.0,
                                  color: Colors.green,
                                );
                              }
                            },
                            connectorBuilder: (_, index, type) {
                              if (index > 0) {
                                return SolidLineConnector(
                                  color: Colors.green,
                                );
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      isDeletable
                          ? Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return deleteEventAlert;
                                      });
                                },
                                child: const Text(
                                  "Delete Event",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ), //SliverAppBar
          ],
        ),
      ),
    );
  }
}

Widget eventDetails(
    var event, String eventtype, String city, String fdate, String tdate) {
  print("Here Event[caid]=");
  print(event["CaId"]);
  return SizedBox(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("EVENT DETAILS"),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.event_available,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(eventtype),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(city),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(fdate + " to " + tdate),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget userDetails(var name, var contact) {
  return SizedBox(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("BOOKED BY"),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 85,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(name),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(contact),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget venueDetails(var venue, var address) {
  return SizedBox(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("VENUE DETAILS"),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(venue['OwnerName']), // owner name
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(venue["Email"]),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(venue["Contact"]),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.people_rounded,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(venue['Capacity']),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(address["Line1"]),
                        Text(address["Line2"]),
                        Text(address["Landmark"]),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget catererDetails(var caterer, var address) {
  return SizedBox(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("CATERER DETAILS"),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(caterer["OwnerName"]), // owner name
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(caterer['Email']),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(caterer['Contact']),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(address["Line1"]),
                        Text(address["Line2"]),
                        Text(address["Landmark"]),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
