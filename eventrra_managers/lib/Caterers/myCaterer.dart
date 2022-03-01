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
            Text("Name : " + currentCaterer["Name"],style: TextStyle(
              fontSize: 18.0,
              color: color,
            ),),
            const Divider(
              thickness: 2,
              color: Colors.blueAccent,
              indent: 10,
              endIndent: 10,
            ),
            Text("OwnerName : " + currentCaterer["OwnerName"],style: TextStyle(
              fontSize: 18.0,
              color: color,
            ),),
            const Divider(
              thickness: 2,
              color: Colors.blueAccent,
              indent: 10,
              endIndent: 10,
            ),
            Text("Email : " +currentCaterer["Email"],style: TextStyle(
              fontSize: 18.0,
              color: color,
            ),),
            const Divider(
              thickness: 2,
              color: Colors.blueAccent,
              indent: 10,
              endIndent: 10,
            ),
            Text("Contact : " +currentCaterer["Contact"],style: TextStyle(
              fontSize: 18.0,
              color: color,
            ),),
            const Divider(
              thickness: 2,
              color: Colors.blueAccent,
              indent: 10,
              endIndent: 10,
            ),
            Text("Address : " + currentCatererAddress["Line1"]+" , "+currentCatererAddress["Line2"],style: TextStyle(
              fontSize: 18.0,
              color: color,
            ),),
            const Divider(
              thickness: 2,
              color: Colors.blueAccent,
              indent: 10,
              endIndent: 10,
            ),
            Text("Landmark : " +currentCatererAddress["Landmark"],style: TextStyle(
              fontSize: 18.0,
              color: color,
            ),),
            const Divider(
              thickness: 2,
              color: Colors.blueAccent,
              indent: 10,
              endIndent: 10,
            ),
            Text("City : " +currentCatererCity["Name"],style: TextStyle(
              fontSize: 18.0,
              color: color,
            ),),
            const Divider(
              thickness: 2,
              color: Colors.blueAccent,
              indent: 10,
              endIndent: 10,
            ),
            Text("State : " +currentCatererCity["State"],style: TextStyle(
              fontSize: 18.0,
              color: color,
            ),),
            const Divider(
              thickness: 2,
              color: Colors.blueAccent,
              indent: 10,
              endIndent: 10,
            ),
            Text("PinCode : " +currentCatererCity["Pincode"],style: TextStyle(
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
                   context, MaterialPageRoute(builder: (context) => EditProfile()));
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
