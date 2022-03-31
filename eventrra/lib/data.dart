// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

var inputCity,
    inputFDate,
    inputTDate,
    inputEventType,
    inputVenue,
    inputCaterer,
    inputUserName,
    inputContact,
    uid,
    eid = "-1";

var currentUserEmail = "";
var currentUserName = "";
var currentUserUId = "";

var cities = [];
void getCities() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getCities.php"));
  cities = jsonDecode(response.body);
}

var vphotos = [];
Future<bool> getVPhotos(var vid) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getVenueGalleryImages.php"),
      body: {
        "vid": vid,
      });
  vphotos = jsonDecode(response.body);
  return true;
}

var addresses = [];
void getAddresses() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getAddresses.php"));
  addresses = jsonDecode(response.body);
}

var users = [];
void getUsers() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getUsers.php"));
  users = jsonDecode(response.body);
}

var venues = [];
void getVenues() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getVenues.php"));
  venues = jsonDecode(response.body);
}

var orchestra = [];
void getOrchestra() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getOrchestra.php"));
  orchestra = jsonDecode(response.body);
}

var decoraters = [];
void getDecoraters() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getDecoraters.php"));
  decoraters = jsonDecode(response.body);
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
}

var selectVenue = [], length;
Future<void> getVenueForEvent(var city, var eventType) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getVenueForEvent.php"),
      body: {
        "cid": city,
        "etid": eventType,
      });
  selectVenue = jsonDecode(response.body);
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

Future<bool> uploadEventRequest(
    var city,
    var fdate,
    var tdate,
    var eventtype,
    var venue,
    var caterer,
    var decorator,
    var orchestra,
    var username,
    var usercontact,
    var uid,
    var eid) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/newEventRequest.php"),
      body: {
        "name": username,
        "contact": usercontact,
        "uid": uid,
        "eid": eid,
        "cid": city['CId'],
        "etid": eventtype['EtId'],
        "fdate": fdate,
        "tdate": tdate,
        "vid": venue['VId'],
        "caid": caterer != null ? caterer['CaId'] : "0",
        "orid": orchestra != null ? orchestra['OrId'] : "0",
        "did": decorator != null ? decorator['DId'] : "0",
      });

  var res = int.parse(response.body);

  if (res > 0) {
    final response2 = await http.post(
        Uri.parse("https://eventrra.000webhostapp.com/sendMailToVendors.php"),
        body: {
          "eid": res.toString(),
          "email": venue['Email'],
          "cityname": city['Name'],
        });

    if (caterer != null) {
      final response3 = await http.post(
          Uri.parse("https://eventrra.000webhostapp.com/sendMailToVendors.php"),
          body: {
            "eid": res.toString(),
            "email": caterer['Email'],
            "cityname": city['Name'],
          });
    }
    if (orchestra != null) {
      final response4 = await http.post(
          Uri.parse("https://eventrra.000webhostapp.com/sendMailToVendors.php"),
          body: {
            "eid": res.toString(),
            "email": orchestra['Email'],
            "cityname": city['Name'],
          });
    }
    if (decorator != null) {
      final response5 = await http.post(
          Uri.parse("https://eventrra.000webhostapp.com/sendMailToVendors.php"),
          body: {
            "eid": res.toString(),
            "email": decorator['Email'],
            "cityname": city['Name'],
          });
    }
    return true;
  } else {
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
  myEvents = jsonDecode(response.body);
  myEvents = List.from(myEvents.reversed);
  var temp = [];
  for (int i = 0; i < myEvents.length; ++i) {
    if (myEvents[i]["VerifiedV"] == "-1") {
      temp.add(myEvents[i]);
    }
  }
  for (int i = 0; i < myEvents.length; ++i) {
    if (myEvents[i]["VerifiedV"] != "-1") {
      temp.add(myEvents[i]);
    }
  }
  myEvents = temp;
  return;
}

Future<void> deleteEvent(
    var eid,
    var uid,
    var vid,
    var caid,
    var orid,
    var did,
    var venuename,
    var eventtype,
    var verifiedv,
    var verifiedc,
    var verifiedd,
    var verifiedo,
    var tdate,
    var fdate) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/deleteEvent.php"),
      body: {
        "eid": eid,
        "uid": uid,
        "vid": vid,
        "caid": caid,
        "orid": orid,
        "did": did,
        "venuename": venuename,
        "eventtype": eventtype,
        "verifiedv": verifiedv,
        "verifiedc": verifiedc,
        "verifiedd": verifiedd,
        "verifiedo": verifiedo,
        "tdate": tdate,
        "fdate": fdate,
      });
  return;
}

Future<void> testFunction() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getCities.php"));
  return;
}
