import 'package:flutter/material.dart';
import 'package:eventrra_managers/data.dart';
import 'editVenue.dart';

class MyVenue extends StatefulWidget {
  const MyVenue({Key? key}) : super(key: key);

  @override
  _MyVenueState createState() => _MyVenueState();
}

// class _MyVenueState extends State<MyVenue> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(currentVenue["Name"]),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             child: const Text("Request New Event Type"),
//             onPressed: () {},
//           )
//         ],
//       ),
//     );
//   }
// }

// class RequestEventType extends StatefulWidget {
//   const RequestEventType({Key? key}) : super(key: key);
//
//   @override
//   _RequestEventTypeState createState() => _RequestEventTypeState();
// }
//
// class _RequestEventTypeState extends State<RequestEventType> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Request new Venue"),
//       ),
//     );
//   }
// }



class _MyVenueState extends State<MyVenue> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Color color = const Color(0xFF1B0250);
    return Scaffold(
        appBar: AppBar(
        title: Text(" "),
    ),
    body: Column(

    children :[

    Container(
    height: 0.6 * height,
    width: 0.70 * width,
    margin: EdgeInsets.only(top:120,left:55),
    decoration: BoxDecoration(
    color: const Color(0xFFf2f2f2),
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: const [
    BoxShadow(
    color: Color(0xFF8A959E),
    blurRadius: 30.0,
    spreadRadius: 0,
    offset: Offset(0.0, 10.0),
    ),
    ],
    ),

    child: Column(
    children: [
    SizedBox(height:50),
    Text("Name : " + currentVenue["Name"],style: TextStyle(
    fontSize: 18.0,
    color: color,
    ),),
    const Divider(
    thickness: 2,
    color: Colors.blueAccent,
    indent: 10,
    endIndent: 10,
    ),
    Text("OwnerName : " + currentVenue["OwnerName"],style: TextStyle(
    fontSize: 18.0,
    color: color,
    ),),
    const Divider(
    thickness: 2,
    color: Colors.blueAccent,
    indent: 10,
    endIndent: 10,
    ),
    Text("Email : " +currentVenue["Email"],style: TextStyle(
    fontSize: 18.0,
    color: color,
    ),),
    const Divider(
    thickness: 2,
    color: Colors.blueAccent,
    indent: 10,
    endIndent: 10,
    ),
    Text("Contact : " +currentVenue["Contact"],style: TextStyle(
    fontSize: 18.0,
    color: color,
    ),),
    const Divider(
    thickness: 2,
    color: Colors.blueAccent,
    indent: 10,
    endIndent: 10,
    ),
    Text("Capacity : " + currentVenue["Capacity"],style: TextStyle(
    fontSize: 18.0,
    color: color,
    ),),
    const Divider(
    thickness: 2,
    color: Colors.blueAccent,
    indent: 10,
    endIndent: 10,
    ),
    Text("Address : " + currentVenueAddress["Line1"]+" , "+currentVenueAddress["Line2"],style: TextStyle(
    fontSize: 18.0,
    color: color,
    ),),
    const Divider(
    thickness: 2,
    color: Colors.blueAccent,
    indent: 10,
    endIndent: 10,
    ),
    Text("Landmark : " +currentVenueAddress["Landmark"],style: TextStyle(
    fontSize: 18.0,
    color: color,
    ),),
    const Divider(
    thickness: 2,
    color: Colors.blueAccent,
    indent: 10,
    endIndent: 10,
    ),
    Text("City : " +currentVenueCity["Name"],style: TextStyle(
    fontSize: 18.0,
    color: color,
    ),),
    const Divider(
    thickness: 2,
    color: Colors.blueAccent,
    indent: 10,
    endIndent: 10,
    ),
    Text("State : " +currentVenueCity["State"],style: TextStyle(
    fontSize: 18.0,
    color: color,
    ),),
    const Divider(
    thickness: 2,
    color: Colors.blueAccent,
    indent: 10,
    endIndent: 10,
    ),
    Text("PinCode : " +currentVenueCity["Pincode"],style: TextStyle(
    fontSize: 18.0,
    color: color,
    ),),
    ],
    )
    ),

      Container(
        child : Column(
            children:[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => EditVenue()));
                },
                child: const Text(
                  "Edit",
                  style: TextStyle(color: Color(0xFF1B0250), fontSize: 17),
                ),
              ),
            ]
        ),
      ),

    ],

    ),
    );
  }
}


