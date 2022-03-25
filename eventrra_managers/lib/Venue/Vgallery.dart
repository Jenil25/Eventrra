import 'package:eventrra_managers/Venue/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:eventrra_managers/data.dart';
import 'package:eventrra_managers/main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Vgallery extends StatefulWidget {
  const Vgallery({Key? key}) : super(key: key);

  @override
  State<Vgallery> createState() => _VgalleryState();
}

class _VgalleryState extends State<Vgallery> {
  @override
  Widget build(BuildContext context) {
    File? imageFile = null;
    _getFromGallery() async {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          print("_getFromGallery");
          imageFile = File(pickedFile.path);
          String filepath = imageFile!.path.split('/').last;
          print("Here");
          addVenuePhotos(
              imageFile!, currentVenue['VId'], vphotos.length.toString());
          print(imageFile!.path.split('/').last);
          Navigator.pop(context);
        });
      }
      print("_getFromGallery End");
    }

    _getFromCamera(BuildContext context) async {
      print("_getFromCamera Start");
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 640,
        maxHeight: 480,
      );
      if (pickedFile != null) {
        setState(() {
          print("_getFromCamera");
          imageFile = File(pickedFile.path);
          String filepath = imageFile!.path.split('/').last;
          print("Here");
          addVenuePhotos(
              imageFile!, currentVenue['VId'], vphotos.length.toString());
          print(imageFile!.path.split('/').last);
          Navigator.pop(context);
        });
      }
      print("_getFromCamera End");
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Venue Gallery"),
        ),
        body: FutureBuilder(
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
                  itemBuilder: (BuildContext context, int i) => Padding(
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

            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: ExpandableFab(
          distance: 80.0,
          children: [
            ActionButton(
              icon: Icon(Icons.insert_photo),
              onPressed: () {
                _getFromGallery();
              },
            ),
            ActionButton(
              onPressed: () {
                _getFromCamera(context);
              },
              icon: const Icon(Icons.camera_alt_outlined),
            ),
          ],
        ));
  }
}
