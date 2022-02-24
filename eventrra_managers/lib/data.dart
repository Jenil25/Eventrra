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
  // print(eventTypes[i]["Event-Type"]);
  // }
}

bool venueUser(String email) {
  for (int i = 0; i < venues.length; ++i) {
    if (venues[i]["Email"].toString().toLowerCase() == email.toLowerCase()) {
      currentVenue = venues[i];
      venueID = int.parse(venues[i]["VId"]);
      isVenueVerified = venues[i]["Verified"] == "1";
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
    String cid,
    String name,
    String capacity,
    String email,
    String contact,
    String ownername,
    Map<dynamic, bool?> venueEventTypes) async {
  print("line1:" + line1);
  print("line2:" + line2);
  print("landmark:" + landmark);
  print("cid:" + cid);
  print("name:" + name);
  print("capacity:" + capacity);
  print("email:" + email);
  print("contact:" + contact);
  print("ownername:" + ownername);
  print("venueEventTypes:");
  for (var key in venueEventTypes.keys) {
    print(key.toString() + ":" + venueEventTypes[key].toString());
  }
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/newVenueRequest.php"),
      body: {
        "line1": line1,
        "line2": line2,
        "landmark": landmark,
        "cid": cid,
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

  currentVenue = jsonDecode(venueResponse.body);

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

late var currentCaterer;
late int catererID;
bool isCatererVerified = false;
Future<bool> sendCaterersRequest(
    String line1,
    String line2,
    String landmark,
    String cid,
    String name,
    String email,
    String contact,
    String ownername) async {
  print("line1:" + line1);
  print("line2:" + line2);
  print("landmark:" + landmark);
  print("cid:" + cid);
  print("name:" + name);
  print("email:" + email);
  print("contact:" + contact);
  print("ownername:" + ownername);
  final response = await http.post(
      Uri.parse("https://eventrra.000webhostapp.com/newCaterersRequest.php"),
      body: {
        "line1": line1,
        "line2": line2,
        "landmark": landmark,
        "cid": cid,
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

  currentCaterer = jsonDecode(catererResponse.body);

  print("Current Caterer:");
  print(currentCaterer);

  print("Caterer Request ID=" + catererID.toString());
  return true;
}
