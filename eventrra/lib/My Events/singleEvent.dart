import 'package:flutter/material.dart';
import 'package:eventrra/data.dart';

class SingleEvent extends StatefulWidget {
  final event;
  const SingleEvent({Key? key ,required this.event}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(),
      body : Column(
        children: [
          Text("City : "+city['Name']),
          Text("From Date : "+event['FDate']),
          Text("To Date : "+event['TDate']),

          Text("User Details "),
          Text("Username : "+event['Name']),
          Text("Contact : "+event['Contact']),

          Text("Venue Details "),
          Text("Venue Name : "+venue['Name']),
          Text("Venue Owner : "+venue['OwnerName']),
          Text("Venue Email : "+venue['Email']),
          Text("Venue Capacity : "+venue['Capacity']),
          Text("Venue Contact : "+venue['Contact']),
          Text("Venue Address : "+vaddress['Line1']+" , "+vaddress['Line2'] + " , "+vaddress['Landmark']),

          caterer!=null
              ? Column(
                    children: [
                      Text("Caterer Details "),
                      Text("Caterer Name : "+caterer['Name']),
                      Text("Caterer Owner : "+caterer['OwnerName']),
                      Text("Caterer Email : "+caterer['Email']),
                      Text("Caterer Contact : "+caterer['Contact']),
                      Text("Caterer Address : "+caddress['Line1']+" , "+caddress['Line2'] + " , "+caddress['Landmark']),

                    ],
          )
              : Container(),
        ],
      ),
    );
  }
}
