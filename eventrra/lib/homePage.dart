import 'dart:convert';

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
              height: 49,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //
            //   ],
            // ),
            Container(
              margin: EdgeInsets.all(15),
              // width: width / 2.5,
              height: height / 7,
              decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              // color: Colors.purple,
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // fixedSize: ,
                    primary: Colors.purple,
                    shadowColor: Colors.purple,
                  ),
                  child: const Text(
                    "My Events",
                    style: TextStyle(color: Colors.yellow, fontSize: 40),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            // const SizedBox(
            //   height: 19,
            // ),
            Container(
              margin: EdgeInsets.all(15),
              // width: width / 2.5,
              height: height / 7,
              decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              // color: Colors.purple,
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // fixedSize: ,
                    primary: Colors.purple,
                    shadowColor: Colors.purple,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewEvent()));
                  },
                  child: Text(
                    "New Event",
                    style: TextStyle(color: Colors.yellow, fontSize: 40),
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 19,
            // ),
            Container(
              // padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(15),
              // width: width / 2.5,
              height: height / 7,
              decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              // color: Colors.purple,
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // fixedSize: ,
                    primary: Colors.purple,
                    shadowColor: Colors.purple,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Pending Events",
                    style: TextStyle(color: Colors.yellow, fontSize: 40),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
