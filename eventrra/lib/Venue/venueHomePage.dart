// import 'package:eventrra/Authentication/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class VenueHome extends StatefulWidget {
//   @override
//   _VenueHomeState createState() => _VenueHomeState();
// }
//
// class _VenueHomeState extends State<VenueHome> {
//   final auth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     Color color = Color(0xFF1B0250);
//     return Scaffold(
//       // drawer: NavDrawer(),
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Eventrra"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               auth.signOut();
//               Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (context) => LoginPage()));
//             },
//             child: const Icon(
//               Icons.exit_to_app,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               height: 0.2 * height,
//               width: width,
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade400,
// //                borderRadius: BorderRadius.circular(15.0),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Spacer(),
//                   const Text(
//                     "Welcome", //, \n${shop_user["s_owner_name"]}",
//                     style: TextStyle(fontSize: 25.0, color: Colors.white),
//                   ),
//                   const Spacer(),
//                   Container(
//                     height: 0.26 * height,
//                     width: 0.23 * height,
//                     child: Image.asset(
//                       "assets/images/venue/WelcomeImage.png",
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   const Spacer(),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Center(
//               child: SafeArea(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextButton(
//                             child: Container(
//                               height: 0.24 * height,
//                               width: 0.4 * width,
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFf2f2f2),
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Color(0xFF8A959E),
//                                     blurRadius: 30.0,
//                                     spreadRadius: 0,
//                                     offset: Offset(0.0, 10.0),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                       flex: 8,
//                                       child: Image.asset(
//                                           "assets/images/venue/MyVenue.png")),
//                                   const Divider(
//                                     thickness: 2,
//                                     color: Colors.blueAccent,
//                                     indent: 10,
//                                     endIndent: 10,
//                                   ),
//                                   Expanded(
//                                       flex: 2,
//                                       child: Container(
//                                         child: Center(
//                                             child: Text(
//                                           "My Venue",
//                                           maxLines: 2,
//                                           style: TextStyle(
//                                             fontSize: 18.0,
//                                             color: color,
//                                           ),
//                                         )),
//                                       )),
//                                   const SizedBox(
//                                     height: 10,
//                                   )
//                                 ],
//                               ),
//                             ),
//                             onPressed: () {
//                               //My Shop - page
//                               // Navigator.push(context,
//                               //             MaterialPageRoute(builder: (context) => LoginPage()));
//                             }),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         TextButton(
//                           child: Container(
//                             height: 0.24 * height,
//                             width: 0.4 * width,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFf2f2f2),
//                               borderRadius: BorderRadius.circular(15.0),
//                               boxShadow: [
//                                 const BoxShadow(
//                                   color: Color(0xFF8A959E),
//                                   blurRadius: 30.0,
//                                   spreadRadius: 0,
//                                   offset: const Offset(0.0, 10.0),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                     flex: 7,
//                                     child: Image.asset(
//                                         "assets/images/venue/Request.png")),
//                                 const Divider(
//                                   thickness: 2,
//                                   color: Colors.blueAccent,
//                                   indent: 10,
//                                   endIndent: 10,
//                                 ),
//                                 Expanded(
//                                     flex: 2,
//                                     child: Container(
//                                       child: Center(
//                                           child: Text(
//                                         "Requests",
//                                         maxLines: 2,
//                                         style: TextStyle(
//                                           fontSize: 18.0,
//                                           color: color,
//                                         ),
//                                       )),
//                                     )),
//                                 const SizedBox(
//                                   height: 10,
//                                 )
//                               ],
//                             ),
//                           ),
//                           onPressed: () {
//                             // My Orders - page
//                           },
//                         )
//                       ],
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextButton(
//                           child: Container(
//                             height: 0.24 * height,
//                             width: 0.4 * width,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFf2f2f2),
//                               borderRadius: BorderRadius.circular(15.0),
//                               boxShadow: [
//                                 const BoxShadow(
//                                   color: Color(0xFF8A959E),
//                                   blurRadius: 30.0,
//                                   spreadRadius: 0,
//                                   offset: const Offset(0.0, 10.0),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                     flex: 7,
//                                     child: Image.asset(
//                                         "assets/images/venue/MyProfile.png")),
//                                 const Divider(
//                                   thickness: 2,
//                                   color: Colors.blueAccent,
//                                   indent: 10,
//                                   endIndent: 10,
//                                 ),
//                                 Expanded(
//                                     flex: 2,
//                                     child: Container(
//                                       child: Center(
//                                           child: Text(
//                                         "My Profile",
//                                         maxLines: 2,
//                                         style: TextStyle(
//                                           fontSize: 18.0,
//                                           color: color,
//                                         ),
//                                       )),
//                                     )),
//                                 const SizedBox(
//                                   height: 10,
//                                 )
//                               ],
//                             ),
//                           ),
//                           onPressed: () {
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //       builder: (context) => ShopProfilePage()),
//                             // );
//                             // My Profile - page
//                           },
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         TextButton(
//                           child: Container(
//                             height: 0.24 * height,
//                             width: 0.4 * width,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFf2f2f2),
//                               borderRadius: BorderRadius.circular(15.0),
//                               boxShadow: [
//                                 const BoxShadow(
//                                   color: Color(0xFF8A959E),
//                                   blurRadius: 30.0,
//                                   spreadRadius: 0,
//                                   offset: const Offset(0.0, 10.0),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                     flex: 8,
//                                     child: Image.asset(
//                                         "assets/images/venue/Events.png")),
//                                 const Divider(
//                                   thickness: 2,
//                                   color: Colors.blueAccent,
//                                   indent: 10,
//                                   endIndent: 10,
//                                 ),
//                                 Expanded(
//                                     flex: 2,
//                                     child: Container(
//                                       child: Center(
//                                           child: Text(
//                                         "Events",
//                                         maxLines: 2,
//                                         style: TextStyle(
//                                           fontSize: 18.0,
//                                           color: color,
//                                         ),
//                                       )),
//                                     )),
//                                 const SizedBox(
//                                   height: 10,
//                                 )
//                               ],
//                             ),
//                           ),
//                           onPressed: () {
//                             // My Products - page
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
