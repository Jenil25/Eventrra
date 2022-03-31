// ignore_for_file: prefer_typing_uninitialized_variables, no_logic_in_create_state

import 'package:eventrra/data.dart';
import 'package:flutter/material.dart';
import 'package:eventrra/main.dart';

import 'finalPage.dart';

class SelectCaterer extends StatefulWidget {
  final venue;
  final city, fdate, tdate, eventType;
  const SelectCaterer(
      {Key? key,
      required this.venue,
      required this.city,
      required this.fdate,
      required this.tdate,
      required this.eventType})
      : super(key: key);

  @override
  _SelectCatererState createState() => _SelectCatererState(
        venue: venue,
        city: city,
        fdate: fdate,
        tdate: tdate,
        eventType: eventType,
      );
}

class _SelectCatererState extends State<SelectCaterer> {
  final venue;
  final city, fdate, tdate, eventType;

  _SelectCatererState(
      {this.venue, this.city, this.fdate, this.tdate, this.eventType});

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller = TextEditingController();
    TextEditingController contactcontroller = TextEditingController();

    String error = "Please Enter Valid Details!";
    AlertDialog invalidValuesAlert = AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          Text(
            " Error",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Text(error),
    );

    AlertDialog alert = AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[
          Text(
            " Enter Your Details",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            TextFormField(
                controller: namecontroller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                  labelText: "Name",
                )),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: contactcontroller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.call,
                  ),
                  labelText: "Contact",
                )),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  inputUserName = namecontroller.text;
                  inputContact = contactcontroller.text;
                  if (namecontroller.text == "" ||
                      contactcontroller.text == "" ||
                      contactcontroller.text.length != 10 ||
                      namecontroller.text.length < 2) {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return invalidValuesAlert;
                        });
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FinalPage(),
                      ),
                    );
                  }
                },
                child: const Text("Continue")),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Caterer"),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: getCatererForEvent(city['CId']),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Error(title: 'Error From Select Caterer');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: selectCaterer.length,
                      itemBuilder: (BuildContext context, int i) =>
                          catererCard1(selectCaterer[i], city, fdate, tdate,
                              eventType, context, alert)),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              inputCaterer = null;
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  });
            },
            child: const Text("Continue Without Caterer"),
          )
        ],
      ),
    );
  }
}

Widget catererCard(BuildContext context, var caterer, var city, var fdate,
    var tdate, var eventType, AlertDialog alert) {
  return ExpansionTile(
    title: Text(
      caterer["Name"],
      style: const TextStyle(fontSize: 20),
    ),
    children: [
      SizedBox(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(15)),
                      child:
                          Image.asset("assets/images/caterer/MyCaterer.png")),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        caterer["Name"],
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            caterer["Landmark"],
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  caterer["Email"],
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Contact No. : " + caterer["Contact"],
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      TextButton(
          onPressed: () {
            inputCaterer = caterer;
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                });
          },
          child: const Text("Continue"))
    ],
  );
}

Widget catererCard1(var caterer, var city, var fdate, var tdate, var eventType,
    BuildContext ctx, AlertDialog alert) {
  return TextButton(
    onPressed: () {},
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: 120,
                    width: 120,
                    color: Colors.grey,
                    child: Image.asset(
                      "assets/images/caterer/MyCaterer.png",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      caterer["Name"].toString().toUpperCase(),
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          caterer["Landmark"],
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.mail,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          caterer["Email"],
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          caterer["Contact"],
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    inputCaterer = caterer;
                    inputCaterer = caterer;
                    showDialog(
                        context: ctx,
                        builder: (BuildContext context) {
                          return alert;
                        });
                  },
                  child: Container(
                    height: 40,
                    width: 130,
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        "BOOK CATERER",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
