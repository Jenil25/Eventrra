import 'package:http/http.dart' as http;
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
  // print(eventTypes[i]["Event-Type"]);
  // }
}

late var currentVenueAddress, currentVenueCity, temp1;
bool venueUser(String email) {
  for (int i = 0; i < venues.length; ++i) {
    if (venues[i]["Email"].toString().toLowerCase() == email.toLowerCase()) {
      currentVenue = venues[i];
      print("Current Venue:");
      print(currentVenue);
      venueID = int.parse(venues[i]["VId"]);
      isVenueVerified = venues[i]["Verified"] == "1";

      for (int j = 0; j < addresses.length; j++) {
        if (addresses[j]["AId"] == currentVenue["AId"]) {
          currentVenueAddress = addresses[j];
          temp1 = addresses[j]["CId"];
          print(temp1);
        }
      }

      for (int k = 0; k < cities.length; k++) {
        if (cities[k]["CId"] == temp1) {
          currentVenueCity = cities[k];
          print(currentVenueCity);
        }
      }
      return true;
    }
  }
  return false;
}

bool catererUser(String email) {
  for (int i = 0; i < caterers.length; ++i) {
    if (caterers[i]["Email"].toString().toLowerCase() == email.toLowerCase()) {
      currentCaterer = caterers[i];
      venueID = int.parse(caterers[i]["CaId"]);
      isVenueVerified = caterers[i]["Verified"] == "1";
      print("CurrentCaterer:");
      print(currentCaterer);

      for (int j = 0; j < addresses.length; j++) {
        if (addresses[j]["AId"] == currentCaterer["AId"]) {
          currentCatererAddress = addresses[j];
          temp = addresses[j]["CId"];
          print(temp);
        }
      }
      for (int k = 0; k < cities.length; k++) {
        if (cities[k]["CId"] == temp) {
          currentCatererCity = cities[k];
          print(currentCatererCity);
        }
      }
      return true;
    }
  }
  return false;
}

late var currentVenue;
late int venueID;
bool isVenueVerified = false;
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
  print("line1:" + line1);
  print("line2:" + line2);
  print("landmark:" + landmark);
  print("pincode:" + pincode);
  print("cityName:" + cityName);
  print("stateName:" + stateName);
  print("name:" + name);
  print("capacity:" + capacity);
  print("email:" + email);
  print("contact:" + contact);
  print("ownername:" + ownername);
  print("venueEventTypes:");
  for (var key in venueEventTypes.keys) {
    print(key.toString() + ":" + venueEventTypes[key].toString());
  }

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

  print("Current Venue:");
  print(currentVenue);

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
  print("Venue Request ID=" + venueID.toString());
  return true;
}

late var currentCaterer, currentCatererAddress, currentCatererCity, temp;
late int catererID;
bool isCatererVerified = false;
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

  print("Current Caterer AId:");
  print(currentCaterer);
  print("Caterer Request ID=" + catererID.toString());
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
  print("Status after editing" + status);
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
  print("Status after editing venue" + status);
  return true;
}
var eventtypes=[];
Future<bool> ViewVenueEventTypes(var vid) async {
  print(vid);
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/getVenueEventType.php"),
      body: {
        "vid": vid,
      });

  eventtypes = jsonDecode(response.body);
  print("Status(show event types)" + eventtypes.toString());
  // eventtypes=res;
  return true;
}

var cityName = "", stateName = "";
Future<bool> verifyPincode(String pincode) async {
  if (pincode.length < 6) return false;
  final response = await http
      .get(Uri.parse("https://api.postalpincode.in/pincode/" + pincode));

  var res = jsonDecode(response.body);

  print("Status:");
  print(res[0]["Status"]);
  if (res[0]["Status"] == "Error") return false;

  cityName = res[0]["PostOffice"][0]["Name"];
  stateName = res[0]["PostOffice"][0]["State"];

  print("City=" + cityName);
  print("State=" + stateName);

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

  print("Status:");
  print(res);

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
  print(venueOccupiedDates);
  return;
}

Future<bool> addOccupiedVenue(String fromDate, String toDate, var vid) async {
  print("From:" + fromDate);
  print("To:" + toDate);
  if (fromDate.length == 0 || toDate.length == 0) return false;
  final response = await http.post(
    Uri.parse("https://eventrra.000webhostapp.com/uploadOccupiedVenue.php"),
    body: {
      "fromdate": fromDate,
      "todate": toDate,
      "vid": vid,
    },
  );

  var res = response.body;

  print("Status:");
  print(res);

  if (res == "success") return true;
  return false;
}
