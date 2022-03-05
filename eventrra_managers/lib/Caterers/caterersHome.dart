import 'package:eventrra_managers/Authentication/login.dart';
import 'package:eventrra_managers/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'myCaterer.dart';

class CaterersHome extends StatefulWidget {
  @override
  _CaterersHomeState createState() => _CaterersHomeState();
}

class _CaterersHomeState extends State<CaterersHome> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Color color = const Color(0xFF1B0250);
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventrra"),
        actions: [
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      // Implement From here. Use venueHome.dart
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 0.2 * height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.blue.shade400,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Text(
                  "Welcome \n${currentCaterer["Name"]}",
                  style: const TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                const Spacer(),
                SizedBox(
                  height: 0.26 * height,
                  width: 0.23 * height,
                  child: Image.asset(
                    "assets/images/venue/WelcomeImage.png",
                    fit: BoxFit.fill,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          currentCaterer["Verified"] == "1"
              ? Center(
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                                child: Container(
                                  height: 0.24 * height,
                                  width: 0.4 * width,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 8,
                                          child: Image.asset(
                                              "assets/images/venue/MyVenue.png")),
                                      const Divider(
                                        thickness: 2,
                                        color: Colors.blueAccent,
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Center(
                                              child: Text(
                                            "My Caterer",
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: color,
                                            ),
                                          ))),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyCaterer()));
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              child: Container(
                                height: 0.24 * height,
                                width: 0.4 * width,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: Image.asset(
                                            "assets/images/venue/Request.png")),
                                    const Divider(
                                      thickness: 2,
                                      color: Colors.blueAccent,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                          "Requests",
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: color,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              child: Container(
                                height: 0.24 * height,
                                width: 0.4 * width,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: Image.asset(
                                            "assets/images/venue/MyProfile.png")),
                                    const Divider(
                                      thickness: 2,
                                      color: Colors.blueAccent,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Center(
                                            child: Text(
                                          "My Profile",
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: color,
                                          ),
                                        ))),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {},
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              child: Container(
                                height: 0.24 * height,
                                width: 0.4 * width,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 8,
                                        child: Image.asset(
                                            "assets/images/venue/Events.png")),
                                    const Divider(
                                      thickness: 2,
                                      color: Colors.blueAccent,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                            "Caterers",
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: color,
                                            ),
                                          )),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Your request has been submitted!"),
                        const Text(
                            "You will receive an email as soon as it gets verified! :)"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // TextButton(
                            //     child: Container(
                            //       height: 0.24 * height,
                            //       width: 0.4 * width,
                            //       decoration: BoxDecoration(
                            //         color: const Color(0xFFf2f2f2),
                            //         borderRadius: BorderRadius.circular(15.0),
                            //         boxShadow: const [
                            //           BoxShadow(
                            //             color: Color(0xFF8A959E),
                            //             blurRadius: 30.0,
                            //             spreadRadius: 0,
                            //             offset: Offset(0.0, 10.0),
                            //           ),
                            //         ],
                            //       ),
                            //       child: Column(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         children: [
                            //           Expanded(
                            //               flex: 8,
                            //               child: Image.asset(
                            //                   "assets/images/venue/MyVenue.png")),
                            //           const Divider(
                            //             thickness: 2,
                            //             color: Colors.blueAccent,
                            //             indent: 10,
                            //             endIndent: 10,
                            //           ),
                            //           Expanded(
                            //               flex: 2,
                            //               child: Container(
                            //                 child: Center(
                            //                     child: Text(
                            //                   "My Caterer",
                            //                   maxLines: 2,
                            //                   style: TextStyle(
                            //                     fontSize: 18.0,
                            //                     color: color,
                            //                   ),
                            //                 )),
                            //               )),
                            //           const SizedBox(
                            //             height: 10,
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //     onPressed: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) =>
                            //                   const MyCaterer()));
                            //     }),
                            const SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              child: Container(
                                height: 0.24 * height,
                                width: 0.4 * width,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: Image.asset(
                                            "assets/images/venue/MyProfile.png")),
                                    const Divider(
                                      thickness: 2,
                                      color: Colors.blueAccent,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                            "Profile",
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: color,
                                            ),
                                          )),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyCaterer()));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
