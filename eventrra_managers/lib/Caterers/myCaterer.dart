import 'package:flutter/material.dart';
import 'package:eventrra_managers/data.dart';
import 'editprofile.dart';

class MyCaterer extends StatefulWidget {
  const MyCaterer({Key? key}) : super(key: key);

  @override
  _MyCatererState createState() => _MyCatererState();
}

class _MyCatererState extends State<MyCaterer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EditProfile()));
            },
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 290,
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
                        child: Text(
                          currentCaterer["OwnerName"][0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      currentCaterer["OwnerName"],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    makeField(Icons.email, currentCaterer["Email"],
                        MainAxisAlignment.center),
                    const SizedBox(
                      height: 10,
                    ),
                    makeField(Icons.phone, currentCaterer["Contact"],
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
                    makeField(Icons.apartment, currentCaterer["Name"],
                        MainAxisAlignment.start),
                    const SizedBox(
                      height: 5,
                    ),
                    makeField(Icons.location_on, currentCatererAddress["Line1"],
                        MainAxisAlignment.start),
                    makeField(null, currentCatererAddress["Line2"],
                        MainAxisAlignment.start),
                    makeField(
                        null,
                        currentCatererCity["Name"] +
                            " - " +
                            currentCatererCity["Pincode"],
                        MainAxisAlignment.start),
                    makeField(null, currentCatererCity["State"],
                        MainAxisAlignment.start),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
