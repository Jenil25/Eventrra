// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names, prefer_is_empty

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io';

var userEmail = "";
var vid;
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

late var currentVenue, currentVenueAddress, currentVenueCity, temp1;
late int venueID;
bool isVenueVerified = false;
bool venueUser(String email) {
  for (int i = 0; i < venues.length; ++i) {
    if (venues[i]["Email"].toString().toLowerCase().trim() ==
        email.toLowerCase().trim()) {
      currentVenue = venues[i];
      getEventDates(currentVenue['VId']);
      venueID = int.parse(venues[i]["VId"]);
      isVenueVerified = venues[i]["Verified"] == "1";

      for (int j = 0; j < addresses.length; j++) {
        if (addresses[j]["AId"] == currentVenue["AId"]) {
          currentVenueAddress = addresses[j];
          temp1 = addresses[j]["CId"];
          break;
        }
      }

      for (int k = 0; k < cities.length; k++) {
        if (cities[k]["CId"] == temp1) {
          currentVenueCity = cities[k];
          break;
        }
      }
      return true;
    }
  }
  return false;
}

late var currentCaterer, currentCatererAddress, currentCatererCity, temp;
late int catererID;
bool isCatererVerified = false;
bool catererUser(String email) {
  for (int i = 0; i < caterers.length; ++i) {
    if (caterers[i]["Email"].toString().toLowerCase().trim() ==
        email.toLowerCase().trim()) {
      currentCaterer = caterers[i];
      catererID = int.parse(caterers[i]["CaId"]);
      isCatererVerified = caterers[i]["Verified"] == "1";

      for (int j = 0; j < addresses.length; j++) {
        if (addresses[j]["AId"] == currentCaterer["AId"]) {
          currentCatererAddress = addresses[j];
          temp = addresses[j]["CId"];
          break;
        }
      }
      for (int k = 0; k < cities.length; k++) {
        if (cities[k]["CId"] == temp) {
          currentCatererCity = cities[k];
          break;
        }
      }
      return true;
    }
  }
  return false;
}

Future<bool> sendVenueRequest(
    String line1,
    String line2,
    String landmark,
    String pincode,
    String cityName,
    String stateName,
    String name,
    String capacity,
    String email,
    String contact,
    String ownername,
    Map<dynamic, bool?> venueEventTypes) async {
  var city = [];
  final cityresponse = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/uploadNewCity.php"),
      body: {"pincode": pincode, "name": cityName, "state": stateName});

  if (cityresponse.body == "error") return false;

  city = jsonDecode(cityresponse.body);

  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/newVenueRequest.php"),
      body: {
        "line1": line1,
        "line2": line2,
        "landmark": landmark,
        "cid": city[0]["CId"],
        "name": name,
        "capacity": capacity,
        "email": email,
        "contact": contact,
        "ownername": ownername,
      });

  venueID = int.parse(response.body);
  isVenueVerified = false;

  final venueResponse = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getVenue.php"),
      body: {"vid": venueID.toString()});

  var v = jsonDecode(venueResponse.body);
  currentVenue = v[0];
  for (var key in venueEventTypes.keys) {
    if (venueEventTypes[key] == true) {
      final response2 = await http.post(
          Uri.parse("https://eventrra.000webhostapp.com/uploadVenueEvents.php"),
          body: {"vid": venueID.toString(), "etid": key["EtId"]});
      var res = response2.body;
      if (res == "error") {
        print("Error while adding venue event type in database!!");
      }
    }
  }
  return true;
}

Future<bool> sendCaterersRequest(
    String line1,
    String line2,
    String landmark,
    String pincode,
    String cityName,
    String stateName,
    String name,
    String email,
    String contact,
    String ownername) async {
  final cityresponse = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/uploadNewCity.php"),
      body: {"pincode": pincode, "name": cityName, "state": stateName});

  if (cityresponse.body == "error") return false;
  var city = [];
  city = jsonDecode(cityresponse.body);

  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/newCaterersRequest.php"),
      body: {
        "line1": line1,
        "line2": line2,
        "landmark": landmark,
        "cid": city[0]["CId"],
        "name": name,
        "email": email,
        "contact": contact,
        "ownername": ownername,
      });

  catererID = int.parse(response.body);
  isCatererVerified = false;

  final catererResponse = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getCaterer.php"),
      body: {"caid": catererID.toString()});

  var v = jsonDecode(catererResponse.body);
  currentCaterer = v[0];
  return true;
}

Future<bool> editCaterersRequest(String line1, String line2, String landmark,
    String cateringname, String contact, String ownername) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/editCaterer.php"),
      body: {
        "line1": line1,
        "line2": line2,
        "landmark": landmark,
        "name": cateringname,
        "contact": contact,
        "ownername": ownername,
        "caid": currentCaterer["CaId"],
        "aid": currentCatererAddress["AId"],
      });

  var status = response.body.toString();
  return true;
}

Future<bool> editVenueRequest(
    String line1,
    String line2,
    String landmark,
    String venuename,
    String email,
    String contact,
    String capacity,
    String ownername) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/editVenue.php"),
      body: {
        "line1": line1,
        "line2": line2,
        "landmark": landmark,
        "name": venuename,
        "email": email,
        "contact": contact,
        "ownername": ownername,
        "capacity": capacity,
        "vid": currentVenue["VId"],
        "aid": currentVenueAddress["AId"],
      });

  var status = response.body.toString();
  return true;
}

var venueeventtypes = [];
Future<bool> ViewVenueEventTypes(var vid) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getVenueEventType.php"),
      body: {
        "vid": vid,
      });

  venueeventtypes = jsonDecode(response.body);
  return true;
}

var cityName = "", stateName = "";
Future<bool> verifyPincode(String pincode) async {
  if (pincode.length < 6) return false;
  final response = await http
      .get(Uri.parse("https://api.postalpincode.in/pincode/" + pincode));

  var res = jsonDecode(response.body);
  if (res[0]["Status"] == "Error") return false;

  cityName = res[0]["PostOffice"][0]["Name"];
  stateName = res[0]["PostOffice"][0]["State"];

  return true;
}

Future<bool> addEventType(String eventType, var vid) async {
  if (eventType.length < 3) return false;
  final response = await http.post(
    Uri.parse("https://eventrra.000webhostapp.com/uploadNewEventType.php"),
    body: {
      "eventtype": eventType,
      "vid": vid,
    },
  );

  var res = response.body;
  if (res == "success") return true;
  return false;
}

var venueOccupiedDates = [];
Future<void> getVenueOccupiedDetails(var vid) async {
  final response = await http.post(
      Uri.parse(
          "https://eventrra.000webhostapp.com/getVenueOccupiedDetails.php"),
      body: {
        "vid": vid,
      });
  venueOccupiedDates = jsonDecode(response.body);
  venueOccupiedDates.sort((a, b) {
    var adate = DateFormat('dd-MM-yyyy').parse(a['FDate']);
    var bdate = DateFormat('dd-MM-yyyy').parse(b['FDate']);
    return adate.compareTo(bdate);
  });
  return;
}

var catererOccupiedDates = [];
Future<void> getCatererOccupiedDetails(var caid) async {
  final response = await http.post(
      Uri.parse(
          "https://eventrra.000webhostapp.com/getCatererOccupiedDetails.php"),
      body: {
        "caid": caid,
      });
  catererOccupiedDates = jsonDecode(response.body);
  catererOccupiedDates.sort((a, b) {
    var adate = DateFormat('dd-MM-yyyy').parse(a['FDate']);
    var bdate = DateFormat('dd-MM-yyyy').parse(b['FDate']);
    return adate.compareTo(bdate);
  });

  return;
}

Future<String> addOccupiedVenue(
    String fromDate, String toDate, var vid, var reason) async {
  if (fromDate.length == 0 || toDate.length == 0) return "error";

  DateTime fdatetemp = DateFormat("dd-MM-yyyy").parse(fromDate);
  DateTime tdatetemp = DateFormat("dd-MM-yyyy").parse(toDate);
  for (int i = 0; i < calenderDates.length; i++) {
    if ((fdatetemp.isAfter(calenderDates[i]['FDate']) &&
            fdatetemp.isBefore(calenderDates[i]['TDate'])) ||
        fdatetemp.isAtSameMomentAs(calenderDates[i]['FDate']) ||
        fdatetemp.isAtSameMomentAs(calenderDates[i]['TDate']) ||
        (tdatetemp.isAfter(calenderDates[i]['FDate']) &&
            tdatetemp.isBefore(calenderDates[i]['TDate'])) ||
        tdatetemp.isAtSameMomentAs(calenderDates[i]['FDate']) ||
        tdatetemp.isAtSameMomentAs(calenderDates[i]['TDate'])) {
      return "There is already a event scheduled from ${calenderDates[i]['FDate'].day}/${calenderDates[i]['FDate'].month}/${calenderDates[i]['FDate'].year} to ${calenderDates[i]['TDate'].day}/${calenderDates[i]['TDate'].month}/${calenderDates[i]['TDate'].year}";
    }
  }
  final response = await http.post(
    Uri.parse("https://eventrra.000webhostapp.com/uploadOccupiedVenue.php"),
    body: {
      "fromdate": fromDate,
      "todate": toDate,
      "vid": vid,
      "reason": reason,
    },
  );

  var res = response.body;
  if (res == "success") return "success";
  return "error";
}

Future<String> addOccupiedCaterer(
    String fromDate, String toDate, var caid, var reason) async {
  if (fromDate.length == 0 || toDate.length == 0 || reason.length == 0) {
    return "Please fill in all the details";
  }

  DateTime fdatetemp = DateFormat("dd-MM-yyyy").parse(fromDate);
  DateTime tdatetemp = DateFormat("dd-MM-yyyy").parse(toDate);

  for (int i = 0; i < calenderCatererDates.length; i++) {
    if ((fdatetemp.isAfter(calenderCatererDates[i]['FDate']) &&
            fdatetemp.isBefore(calenderCatererDates[i]['TDate'])) ||
        fdatetemp.isAtSameMomentAs(calenderCatererDates[i]['FDate']) ||
        fdatetemp.isAtSameMomentAs(calenderCatererDates[i]['TDate']) ||
        (tdatetemp.isAfter(calenderCatererDates[i]['FDate']) &&
            tdatetemp.isBefore(calenderCatererDates[i]['TDate'])) ||
        tdatetemp.isAtSameMomentAs(calenderCatererDates[i]['FDate']) ||
        tdatetemp.isAtSameMomentAs(calenderCatererDates[i]['TDate'])) {
      return "There is already a event scheduled from ${calenderCatererDates[i]['FDate'].day}/${calenderCatererDates[i]['FDate'].month}/${calenderCatererDates[i]['FDate'].year} to ${calenderCatererDates[i]['TDate'].day}/${calenderCatererDates[i]['TDate'].month}/${calenderCatererDates[i]['TDate'].year}";
    }
  }

  final response = await http.post(
    Uri.parse("https://eventrra.000webhostapp.com/uploadOccupiedCaterer.php"),
    body: {
      "fromdate": fromDate,
      "todate": toDate,
      "caid": caid,
      "reason": reason,
    },
  );

  var res = response.body;

  if (res == "success") return "success";
  return "error";
}

var venueRequests = [];
Future<bool> getVenueRequests(var vid) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getVenueRequests.php"),
      body: {"vid": vid});
  venueRequests = jsonDecode(response.body);
  return true;
}

var catererRequests = [];
Future<bool> getCatererRequests(var caid) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getCatererRequests.php"),
      body: {"caid": caid});
  catererRequests = jsonDecode(response.body);
  return true;
}

Future<bool> AcceptRequest(var eid, var venuename, var eventtype, var fdate,
    var tdate, var uid) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/venueRequestAccepted.php"),
      body: {
        "eid": eid,
        "uid": uid,
        "venuename": venuename,
        "eventtype": eventtype,
        "fdate": fdate,
        "tdate": tdate,
      });
  if (response.body == "error") return false;
  return true;
}

Future<bool> AcceptCatererRequest(var eid, var caterername, var eventtype,
    var fdate, var tdate, var uid) async {
  final response = await http.post(
      Uri.parse(
          "https://eventrra.000webhostapp.com/catererRequestAccepted.php"),
      body: {
        "eid": eid,
        "uid": uid,
        "caterername": caterername,
        "eventtype": eventtype,
        "fdate": fdate,
        "tdate": tdate,
      });
  if (response.body == "error") return false;
  return true;
}

Future<bool> DeclineRequest(
    var eid,
    var venuename,
    var venuedeclinereason,
    var eventtype,
    var fdate,
    var tdate,
    var uid,
    var caid,
    var orid,
    var did) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/venueRequestDeclined.php"),
      body: {
        "eid": eid,
        "uid": uid,
        "venuename": venuename,
        "venuedeclinereason": venuedeclinereason,
        "eventtype": eventtype,
        "fdate": fdate,
        "tdate": tdate,
        "caid": caid,
        "did": did,
        "orid": orid,
      });
  if (response.body == "error") return false;
  return true;
}

Future<bool> DeclineCatererRequest(var eid, var uid, var caterername,
    var eventtype, var fdate, var tdate) async {
  final response = await http.post(
      Uri.parse(
          "https://eventrra.000webhostapp.com/catererRequestDeclined.php"),
      body: {
        "eid": eid,
        "uid": uid,
        "caterername": caterername,
        "eventtype": eventtype,
        "fdate": fdate,
        "tdate": tdate
      });
  if (response.body == "error") return false;
  return true;
}

var occupiedDates = [], calenderDates = [];
Future<bool> getEventDates(var vid) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getVCalenderEvents.php"),
      body: {"vid": vid});
  calenderDates = jsonDecode(response.body);
  for (int i = 0; i < calenderDates.length; i++) {
    calenderDates[i]['FDate'] =
        DateFormat("dd-MM-yyyy").parse(calenderDates[i]['FDate']);
    calenderDates[i]['TDate'] =
        DateFormat("dd-MM-yyyy").parse(calenderDates[i]['TDate']);
  }
  final response1 = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getVOccupied.php"),
      body: {"vid": vid});
  occupiedDates = jsonDecode(response1.body);
  for (int i = 0; i < occupiedDates.length; i++) {
    occupiedDates[i]['FDate'] =
        DateFormat("dd-MM-yyyy").parse(occupiedDates[i]['FDate']);
    occupiedDates[i]['TDate'] =
        DateFormat("dd-MM-yyyy").parse(occupiedDates[i]['TDate']);
  }

  return true;
}

var occupiedCatererDates = [], calenderCatererDates = [];
Future<bool> getCatererEventDates(var caid) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getCCalenderEvents.php"),
      body: {"caid": caid});

  calenderCatererDates = jsonDecode(response.body);

  for (int i = 0; i < calenderCatererDates.length; i++) {
    calenderCatererDates[i]['FDate'] =
        DateFormat("dd-MM-yyyy").parse(calenderCatererDates[i]['FDate']);
    calenderCatererDates[i]['TDate'] =
        DateFormat("dd-MM-yyyy").parse(calenderCatererDates[i]['TDate']);
  }
  final response1 = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getCOccupied.php"),
      body: {"caid": caid});

  occupiedCatererDates = jsonDecode(response1.body);

  for (int i = 0; i < occupiedCatererDates.length; i++) {
    occupiedCatererDates[i]['FDate'] =
        DateFormat("dd-MM-yyyy").parse(occupiedCatererDates[i]['FDate']);
    occupiedCatererDates[i]['TDate'] =
        DateFormat("dd-MM-yyyy").parse(occupiedCatererDates[i]['TDate']);
  }

  return true;
}

Future<String> deleteOccupiedVenue(var ovid) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/deleteOccupiedVenue.php"),
      body: {"ovid": ovid});
  if (response.body == "success") return "success";
  return "error";
}

Future<String> deleteOccupiedCaterer(var ocaid) async {
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/deleteOccupiedCaterer.php"),
      body: {"ocaid": ocaid});
  if (response.body == "success") return "success";
  return "error";
}

Future<void> uploadImageFile(File file, String name) async {
  final response = await http.post(
      Uri.parse(
          "https://eventrra.000webhostapp.com/gallery/venue/uploadVenueProfileImage.php"),
      body: {
        "file": base64Encode(file.readAsBytesSync()),
        "vid": currentVenue['VId']
      });
  return;
}

Future<void> addVenuePhotos(File file, var vid, var num) async {
  final response = await http.post(
      Uri.parse(
          "https://eventrra.000webhostapp.com/gallery/venue/gallery/uploadVenueImages.php"),
      body: {
        "file": base64Encode(file.readAsBytesSync()),
        "vid": vid,
        "num": num,
      });
  return;
}

Future<void> testFunction() async {
  final response = await http
      .post(Uri.parse("https://eventrra.000webhostapp.com/getCities.php"));
  return;
}
