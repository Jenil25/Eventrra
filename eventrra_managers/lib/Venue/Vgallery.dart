import 'package:eventrra_managers/Venue/addPhotos.dart';
import 'package:eventrra_managers/Venue/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:eventrra_managers/data.dart';
import 'package:eventrra_managers/main.dart';

class Vgallery extends StatefulWidget {
  const Vgallery({Key? key}) : super(key: key);

  @override
  State<Vgallery> createState() => _VgalleryState();
}

class _VgalleryState extends State<Vgallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title : Text("Venue Gallery"),
      ),
      body : FutureBuilder(
        future: getVPhotos(currentVenue['VId']),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Error(title: 'Error From Main');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            print(vphotos);
            return ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
                itemCount: vphotos.length,
                itemBuilder: (BuildContext context, int i) =>
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          // shape: BoxShape.squar,
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://eventrra.000webhostapp.com/images/venue/gallery/${vphotos[i]['image']}"),
                            fit: BoxFit.fill,
                          ),

                        ),
                      ),
                    ));
          }

          return  Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: ActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPhotos()));
        },
        icon: Icon(Icons.add),
      ),
    );
  }
}
