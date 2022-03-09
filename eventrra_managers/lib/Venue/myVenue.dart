import 'package:eventrra_managers/Venue/expandable_fab.dart';
import 'package:eventrra_managers/Venue/uploadImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eventrra_managers/data.dart';
import 'Vgallery.dart';
import 'addPhotos.dart';
import 'editVenue.dart';
import 'package:eventrra_managers/main.dart';


class MyVenue extends StatefulWidget {
  const MyVenue({Key? key}) : super(key: key);

  @override
  _MyVenueState createState() => _MyVenueState();
}

class _MyVenueState extends State<MyVenue> {
  TextEditingController eventTypeController = TextEditingController();

  bool isClicked = false, isLoading = false, isDone = false;

  @override
  Widget build(BuildContext context) {
    // DefaultCacheManager().removeFile("https://eventrra.000webhostapp.com/images/venue/${currentVenue['image']}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue.shade50),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.deepOrange.shade300),
                      child: Center(
                        child: Container(

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://eventrra.000webhostapp.com/images/venue/${currentVenue['image']}"),
                              fit: BoxFit.fill,
                            ),

                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadImages()));
                        },
                        child: Text("Change Profile Image")),
                    Text(
                      currentVenue["OwnerName"],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    makeField(Icons.email, currentVenue["Email"],
                        MainAxisAlignment.center),
                    const SizedBox(
                      height: 10,
                    ),
                    makeField(Icons.phone, currentVenue["Contact"],
                        MainAxisAlignment.center),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue.shade50),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    makeField(Icons.apartment, currentVenue["Name"],
                        MainAxisAlignment.start),
                    const SizedBox(
                      height: 5,
                    ),
                    makeField(Icons.location_on, currentVenueAddress["Line1"],
                        MainAxisAlignment.start),
                    makeField(null, currentVenueAddress["Line2"],
                        MainAxisAlignment.start),
                    makeField(
                        null,
                        currentVenueCity["Name"] +
                            " - " +
                            currentVenueCity["Pincode"],
                        MainAxisAlignment.start),
                    makeField(null, currentVenueCity["State"],
                        MainAxisAlignment.start),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hosted Event Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FutureBuilder(
                    future: ViewVenueEventTypes(currentVenue['VId']),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Error(
                            title:
                                'Error From getting event types:\n${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        return Expanded(
                          child: ListView.builder(
                              // physics: NeverScrollableScrollPhysics(),
                              // shrinkWrap: true,
                              itemCount: eventtypes.length,
                              itemBuilder: (BuildContext context, int i) =>
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      // color: Colors.blue.shade300,
                                      height: 50,
                                      child: Text(eventtypes[i]["EventType"]),
                                    ),
                                  )),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ExpandableFab(
        distance : 112.0,
        children: [
          ActionButton( icon: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      color: Colors.transparent,
                      child: StatefulBuilder(builder:
                          (BuildContext context, StateSetter setModalState) {
                        return Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0)),
                          ),
                          padding: MediaQuery.of(context).viewInsets,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Add New Event Type",
                                  style: TextStyle(
                                    color: Colors.blue.shade500,
                                    fontSize: 18,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: TextField(
                                    controller: eventTypeController,
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade300,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          if (isLoading) return;
                                          setModalState(() {
                                            isLoading = true;
                                          });
                                          addEventType(
                                              eventTypeController.text
                                                  .toString(),
                                              currentVenue["VId"])
                                              .then((value) => {
                                            if (value == true)
                                              {
                                                print("If"),
                                                setModalState(() {
                                                  eventTypeController.text =
                                                  "";
                                                  isLoading = false;
                                                  isClicked = true;
                                                  isDone = true;
                                                })
                                              }
                                            else
                                              {
                                                print("Else"),
                                                setModalState(() {
                                                  isLoading = false;
                                                  isClicked = true;
                                                  isDone = false;
                                                })
                                              }
                                          });
                                        },
                                        child: const Text(
                                          "Add",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 100,
                                      // color: Colors.blue.shade300,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade300,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    isLoading == true
                                        ? const CircularProgressIndicator()
                                        : isClicked == true
                                        ? isDone == true
                                        ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                      ),
                                      child: const Text("Added"),
                                    )
                                        : const Text("Error")
                                        : const Text("")
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                );
              },
          ),
          ActionButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Vgallery()));
              },
              icon: const Icon(Icons.insert_photo)),
          ActionButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const EditVenue()));
              },
              icon: const Icon(Icons.edit))
        ],
      )
    );
  }

  Widget makeField(
      IconData? iconData, String value, MainAxisAlignment alignment) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        Icon(iconData),
        const SizedBox(
          width: 10,
        ),
        Text(
          value,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}


