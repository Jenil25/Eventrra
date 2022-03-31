import 'package:eventrra/My%20Events/myevent.dart';
import 'package:eventrra/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'Authentication/login.dart';
import 'New Event/newevent.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List cardList = [];
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
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(Icons.logout)),
        ],
        title: const Text("Eventrra"),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 20,
            ),
            profile(currentUserName, currentUserEmail),
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
            _makeButton(
              s1: "MY",
              s2: "EVENTS",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyEvent(),
                  ),
                );
              },
              clr: [Colors.red.shade300, Colors.red.shade600],
              image: Image.asset(
                "assets/images/MyEvents.png",
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
                  MaterialPageRoute(
                    builder: (context) => const NewEvent(),
                  ),
                );
              },
              clr: [Colors.blue.shade300, Colors.blue.shade600],
              image: Image.asset(
                "assets/images/nevEvent.png",
                fit: BoxFit.fitHeight,
              ),
            ),
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
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    s2,
                    style: const TextStyle(
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

  Widget profile(String username, String useremail) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 120,
      child: Card(
        color: Colors.white60,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.purple.shade300,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    username[0],
                    style: const TextStyle(fontSize: 50, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.email),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          useremail,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
