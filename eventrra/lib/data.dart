import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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
