import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
var inputCity,inputFDate,inputTDate,inputEventType,inputVenue,inputCaterer,inputUserName,inputContact,uid;

var userEmail = "";

var cities = [];
void getCities() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getCities.php"));
  cities = jsonDecode(response.body);
  // print("Citites:");
  // for (int i = 0; i < cities.length; ++i) {
  //   print(cities[i]["Name"] +
  //       cities[i]["Location"] +
  //       cities[i]["Pincode"] +
  //       cities[i]["State"]);
  // }
}

var addresses = [];
void getAddresses() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getAddresses.php"));
  addresses = jsonDecode(response.body);
  // print("Addresses:");
  // for (int i = 0; i < addresses.length; ++i) {
  //   print(addresses[i]["Line1"] +
  //       "," +
  //       addresses[i]["Line2"] +
  //       "," +
  //       addresses[i]["Landmark"] +
  //       "," +
  //       addresses[i]["CId"]);
  // }
}
var users = [];
void getUsers() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getUsers.php"));
  users = jsonDecode(response.body);
  print("Users"+users.toString());
}
var venues = [];
void getVenues() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getVenues.php"));
  venues = jsonDecode(response.body);
  print("Got Venues! length= " + venues.length.toString());
//   print("Venues:");
//   for (int i = 0; i < venues.length; ++i) {
//     print(venues[i]["Name"] +
//         "," +
//         venues[i]["Capacity"] +
//         "," +
//         venues[i]["Email"] +
//         "," +
//         venues[i]["Contact"] +
//         "," +
//         venues[i]["OwnerName"]);
//   }
}
// void getAddressVenues(int CId) async {
//   final response = await http
//       .post(Uri.parse("https://eventrra.000webhostapp.com/getAddressVenues.php"));
//   cities = jsonDecode(response.body);
//   for (int i = 0; i < cities.length; ++i) {
//     print(cities[i]["Name"] +
//         cities[i]["Location"] +
//         cities[i]["Pincode"] +
//         cities[i]["State"]);
//   }
// }

var orchestra = [];
void getOrchestra() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getOrchestra.php"));
  orchestra = jsonDecode(response.body);
  // print("Orchestra:");
  // for (int i = 0; i < orchestra.length; ++i) {
  //   print(orchestra[i]["Name"] +
  //       "," +
  //       orchestra[i]["Email"] +
  //       "," +
  //       orchestra[i]["Contact"] +
  //       "," +
  //       orchestra[i]["OwnerName"]);
  // }
}

var decoraters = [];
void getDecoraters() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getDecoraters.php"));
  decoraters = jsonDecode(response.body);
  // print("Decoraters:");
  // for (int i = 0; i < decoraters.length; ++i) {
  //   print(decoraters[i]["Name"] +
  //       "," +
  //       decoraters[i]["Email"] +
  //       "," +
  //       decoraters[i]["Contact"] +
  //       "," +
  //       decoraters[i]["OwnerName"]);
  // }
}

var caterers = [];
void getCaterers() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getCaterers.php"));
  caterers = jsonDecode(response.body);
}

var eventTypes = [];
void getEventTypes() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getEventTypes.php"));
  eventTypes = jsonDecode(response.body);
  // print("Event-Types:");
  // for (int i = 0; i < eventTypes.length; ++i) {
  // print(eventTypes[i]["EventType"]);
  // }
}

var selectVenue = [], length;
Future<void> getVenueForEvent(var city, var eventType) async {
  print("Inside function in data.dart");
  print(city);
  print(eventType);
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getVenueForEvent.php"),
      body: {
        "cid": city,
        "etid": eventType,
      });
  // print("a");
  selectVenue = jsonDecode(response.body);
  print(selectVenue);
  length = selectVenue.length;
}

var selectCaterer = [];
Future<void> getCatererForEvent(var cid) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getCatererForEvent.php"),
      body: {
        "cid": cid,
      });
  selectCaterer = jsonDecode(response.body);
  return;
}


Future<bool> uploadEventRequest(var city,var fdate,var tdate,var eventtype,var venue,var caterer,var decorator,var orchestra,var username,var usercontact,var uid) async {
  print("Inside upload event function in data.dart");
  print("name"+ username+"\n"+
    "contact"+usercontact+"\n"+
    "uid" + uid+"\n"+
    "cid" + city['CId']+"\n"+
    "etid" + eventtype['EtId']+"\n"+
    "fdate" + fdate+"\n"+
    "tdate" + tdate+"\n"+
    "vid" + venue['VId']+"\n"+
    "caid" + caterer['CaId']  +"\n");
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/newEventRequest.php"),
      body: {
        "name": username,
        "contact": usercontact,
        "uid" : uid,
        "cid" : city['CId'],
        "etid" : eventtype['EtId'],
        "fdate" : fdate,
        "tdate" : tdate,
        "vid" : venue['VId'],
        "caid" : caterer!=null ? caterer['CaId'] : "0",
        "orid" : orchestra!=null ? orchestra['OrId'] : "0",
        "did" : decorator!=null ? decorator['DId'] : "0",
      });
  // print("a");

    var res=int.parse(response.body);


    if(res>0) {

      final response1 = await http.post(
          Uri.parse("https://eventrra.000webhostapp.com/sendMailToUser.php"),
          body: {
            "eid": res.toString(),
            "email" : userEmail,
            "cityname" : city['Name'],
          });

        final response2 = await http.post(
            Uri.parse("https://eventrra.000webhostapp.com/sendMailToVendors.php"),
            body: {
              "eid": res.toString(),
              "email" : venue['Email'],
              "cityname" : city['Name'],
            });

        if(caterer!=null) {
          final response3 = await http.post(
              Uri.parse(
                  "https://eventrra.000webhostapp.com/sendMailToVendors.php"),
              body: {
                "eid": res.toString(),
                "email": caterer['Email'],
                "cityname" : city['Name'],
              });
        }
        if(orchestra!=null) {
          final response4 = await http.post(
              Uri.parse(
                  "https://eventrra.000webhostapp.com/sendMailToVendors.php"),
              body: {
                "eid": res.toString(),
                "email": orchestra['Email'],
                "cityname" : city['Name'],
              });
        }
        if(decorator !=null) {
          final response5 = await http.post(
              Uri.parse(
                  "https://eventrra.000webhostapp.com/sendMailToVendors.php"),
              body: {
                "eid": res.toString(),
                "email": decorator['Email'],
                "cityname" : city['Name'],
              });
        }
        return true;



    }else {
      return false;
    }
}

var myEvents = [];
Future<void> getUserEvents(var uid) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getUserEvents.php"),
      body: {
        "uid": uid,
      });
   myEvents= jsonDecode(response.body);
  return;
}
