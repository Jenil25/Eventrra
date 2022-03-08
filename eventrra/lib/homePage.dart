import 'dart:convert';

import 'package:eventrra/My%20Events/myevent.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'New Event/newevent.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var carousal_images;
  List cardList = [];
  // void func(){
  //   // for(int i=0;i < 4;++i){
  //   //   cardList.add(const Image(
  //   //     image: AssetImage("assets/images/event.jpg"),
  //   //     fit: BoxFit.fitWidth,
  //   //   ),);
  //   // }
  // }

  // void CarousalImages() async {
  //   final response = await http.post(
  //     "https://shoperaweb.com/offer_images/carousal/getImages.php",
  //   );
  //   carousal_images = jsonDecode(response.body);
  //   cardList.clear();
  //   for (int i = 0; i < carousal_images.length; ++i) {
  //     cardList.add(Image.network(
  //         "https://shoperaweb.com/offer_images/carousal/${carousal_images[i]["ci_name"]}",
  //         fit: BoxFit.cover));
  //   }
  //   print(cardList);
  // }

  @override
  Widget build(BuildContext context) {
    cardList.clear();
    cardList.add(
      const Image(
        image: AssetImage("assets/images/carousel/event1.jpg"),
        fit: BoxFit.fill,
      ),
    );
    cardList.add(
      const Image(
        image: AssetImage("assets/images/carousel/event2.jpg"),
        fit: BoxFit.fill,
      ),
    );
    cardList.add(
      const Image(
        image: AssetImage("assets/images/carousel/event3.jpg"),
        fit: BoxFit.fill,
      ),
    );
    cardList.add(
      const Image(
        image: AssetImage("assets/images/carousel/event4.jpg"),
        fit: BoxFit.fill,
      ),
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Eventrra"),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Container(
            //   child: Text("Home Page"),
            // ),
            const SizedBox(
              height: 20,
            ),
            CarouselSlider(
              items: cardList.map((card) {
                return Builder(builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: width > height ? width / 5 : height * 0.30,
                    width: width > height ? height * 1.5 : width,
                    child: Card(
                      color: Colors.blue,
                      child: card,
                    ),
                  );
                });
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //
            //   ],
            // ),
            _makeButton(
              s1: "MY",
              s2: "EVENTS",
              onPressed: () {
                Navigator.push(
                  context,
                  //final city, fdate, tdate, eventType;
                  MaterialPageRoute(
                    builder: (context) => MyEvent(),
                  ),
                );
              },
              clr: [Colors.red.shade300, Colors.red.shade600],
              image: Image.network(
                "https://www.kindpng.com/picc/m/246-2465825_event-management-gurgaon-illustration-png-calendar-vector-transparent.pnghttps://www.kindpng.com/picc/m/246-2465825_event-management-gurgaon-illustration-png-calendar-vector-transparent.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _makeButton(
                s1: "NEW",
                s2: "EVENT",
                onPressed: () {
                  Navigator.push(
                    context,
                    //final city, fdate, tdate, eventType;
                    MaterialPageRoute(
                      builder: (context) => NewEvent(),
                    ),
                  );
                },
                clr: [Colors.blue.shade300, Colors.blue.shade600],
                image: Image.network(
                  "https://img.freepik.com/free-vector/businessman-planning-events-deadlines-agenda_74855-6274.jpg?size=626&ext=jpg",
                  fit: BoxFit.fitWidth,
                )),
            // Container(
            //   margin: EdgeInsets.all(15),
            //   // width: width / 2.5,
            //   height: height / 7,
            //   decoration: const BoxDecoration(
            //       color: Colors.purple,
            //       borderRadius: BorderRadius.all(Radius.circular(20))),
            //   // color: Colors.purple,
            //   child: Center(
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         // fixedSize: ,
            //         primary: Colors.purple,
            //         shadowColor: Colors.purple,
            //       ),
            //       child: const Text(
            //         "My Events",
            //         style: TextStyle(color: Colors.yellow, fontSize: 40),
            //       ),
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           //final city, fdate, tdate, eventType;
            //           MaterialPageRoute(
            //             builder: (context) => MyEvent(),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            // // const SizedBox(
            // //   height: 19,
            // // ),
            // Container(
            //   margin: EdgeInsets.all(15),
            //   // width: width / 2.5,
            //   height: height / 7,
            //   decoration: const BoxDecoration(
            //       color: Colors.purple,
            //       borderRadius: BorderRadius.all(Radius.circular(20))),
            //   // color: Colors.purple,
            //   child: Center(
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         // fixedSize: ,
            //         primary: Colors.purple,
            //         shadowColor: Colors.purple,
            //       ),
            //       onPressed: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => NewEvent()));
            //       },
            //       child: Text(
            //         "New Event",
            //         style: TextStyle(color: Colors.yellow, fontSize: 40),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 19,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _makeButton({
    required Image image,
    required Function()? onPressed,
    required List<Color> clr,
    required String s1,
    required String s2,
  }) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: size.width * 0.9,
        height: 120,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF8A959E),
              blurRadius: 30.0,
              spreadRadius: 0,
              offset: Offset(0.0, 10.0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: clr,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    color: Colors.purple,
                    height: 120,
                    width: 180,
                    child: image,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s1,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    s2,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
