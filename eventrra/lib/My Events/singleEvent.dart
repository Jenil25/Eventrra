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

    status[0] = "1";
    msg[0] = "Requested";

    status[1] = event['VerifiedV'];
    if (status[1] == "1" || status[1] == "0") {
      msg[1] = "Accepted By VenueOwner";
    } else if (status[1] == "-1") {
      msg[1] = "Declined by VenueOwner";
    }

    status[2] = event['VerifiedC'];
    if (status[2] == "1" || status[2] == "0") {
      msg[2] = "Accepted By CateringOwner";
    } else if (status[2] == "-1") {
      msg[2] = "Declined by CateringOwner";
    }

    status[3] = event['VerifiedO'];
    if (status[3] == "1" || status[3] == "0") {
      msg[3] = "Accepted By OrchestraOwner";
    } else if (status[3] == "-1") {
      msg[3] = "Declined by OrchestraOwner";
    }

    status[4] = event['VerifiedD'];
    if (status[4] == "1" || status[4] == "0") {
      msg[4] = "Accepted By DecoratorOwner";
    } else if (status[4] == "-1") {
      msg[4] = "Declined by DecoratorOwner";
    }

    DateTime current = DateTime.now();
    DateTime tDate = DateFormat("dd-MM-yyyy").parse(event['TDate']);
    if (current.isAfter(tDate)) {
      status[5] = "1";
      msg[5] = "Event Completed";
    } else {
      status[5] = "0";
      msg[5] = "Event yet to be Scheduled";
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("City : " + city['Name']),
          Text("From Date : " + event['FDate']),
          Text("To Date : " + event['TDate']),
          Text("User Details "),
          Text("Username : " + event['Name']),
          Text("Contact : " + event['Contact']),
          Text("Venue Details "),
          Text("Venue Name : " + venue['Name']),
          Text("Venue Owner : " + venue['OwnerName']),
          Text("Venue Email : " + venue['Email']),
          Text("Venue Capacity : " + venue['Capacity']),
          Text("Venue Contact : " + venue['Contact']),
          Text("Venue Address : " +
              vaddress['Line1'] +
              " , " +
              vaddress['Line2'] +
              " , " +
              vaddress['Landmark']),
          caterer != null
              ? Column(
                  children: [
                    Text("Caterer Details "),
                    Text("Caterer Name : " + caterer['Name']),
                    Text("Caterer Owner : " + caterer['OwnerName']),
                    Text("Caterer Email : " + caterer['Email']),
                    Text("Caterer Contact : " + caterer['Contact']),
                    Text("Caterer Address : " +
                        caddress['Line1'] +
                        " , " +
                        caddress['Line2'] +
                        " , " +
                        caddress['Landmark']),
                  ],
                )
              : Container(),
            Container(
            height: 250,
            alignment: Alignment.topCenter,
            child: Timeline.tileBuilder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              theme: TimelineThemeData(
                direction: Axis.horizontal,
                connectorTheme: ConnectorThemeData(space: 8.0, thickness: 2.0),
              ),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemCount: 6,
                itemExtentBuilder: (_, __) {
                  return (MediaQuery.of(context).size.width - 120) / 4.0;
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
                    if(status[index]=="1") {
                      return DotIndicator(
                        size: 20.0,
                        color: Colors.green,
                      );
                    }
                    else if(status[index]=="-1"){
                      return DotIndicator(
                        size: 20.0,
                        color: Colors.red,
                      );
                    }
                    else {
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
          )
        ],
      ),
    );
  }
}
