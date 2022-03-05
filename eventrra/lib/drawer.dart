import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eventrra/Authentication/login.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final auth = FirebaseAuth.instance;

  late User user;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.purple,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/drawer_top.png"))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35,
                    child: Center(
                      child: Text(
                        "J",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'Jenil',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              title: const Text(
                'Profile',
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () => {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SettingsUI()),
                // )
              },
            ),
            // const Divider(
            //   height: 0,
            //   color: Colors.white,
            //   thickness: 0.4,
            //   indent: 40,
            //   endIndent: 40,
            // ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.shopping_basket,
            //     color: Colors.white,
            //   ),
            //   title: const Text(
            //     'My Orders',
            //     style: const TextStyle(color: Colors.white),
            //   ),
            //   onTap: () => {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => MyOrders()),
            //     // )
            //   },
            // ),
            // const Divider(
            //   height: 0,
            //   color: Colors.white,
            //   thickness: 0.4,
            //   indent: 40,
            //   endIndent: 40,
            // ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.favorite,
            //     color: Colors.white,
            //   ),
            //   title: const Text(
            //     'Favourites',
            //     style: const TextStyle(color: Colors.white),
            //   ),
            //   onTap: () => {
            //     // GetFav(user_uid),
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //       builder: (context) => FavouritesNavigator()),
            //     // )
            //   },
            // ),
            // const Divider(
            //   height: 0,
            //   color: Colors.white,
            //   thickness: 0.4,
            //   indent: 40,
            //   endIndent: 40,
            // ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.shopping_cart,
            //     color: Colors.white,
            //   ),
            //   title: const Text(
            //     'My cart',
            //     style: const TextStyle(color: Colors.white),
            //   ),
            //   onTap: () => {
            //     // GetCart(user_uid),
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => CartNavigator()),
            //     // )
            //   },
            // ),
            const Divider(
              height: 0,
              color: Colors.white,
              thickness: 0.4,
              indent: 40,
              endIndent: 40,
            ),
            ListTile(
              leading: const Icon(
                Icons.help,
                color: Colors.white,
              ),
              title: const Text(
                'Help',
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () => {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Help()),
                // )
              },
            ),
            const Divider(
              height: 0,
              color: Colors.white,
              thickness: 0.4,
              indent: 40,
              endIndent: 40,
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              title: const Text(
                'Logout',
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () => {
                auth.signOut(),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage())),
              },
            ),
            const Divider(
              height: 0,
              color: Colors.white,
              thickness: 0.4,
              indent: 40,
              endIndent: 40,
            ),
          ],
        ),
      ),
    );
  }
}
