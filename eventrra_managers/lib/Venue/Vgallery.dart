// ignore_for_file: avoid_init_to_null

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
          imageFile = File(pickedFile.path);
          addVenuePhotos(
              imageFile!, currentVenue['VId'], vphotos.length.toString());
          Navigator.pop(context);
        });
      }
    }

    _getFromCamera(BuildContext context) async {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 640,
        maxHeight: 480,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          addVenuePhotos(
              imageFile!, currentVenue['VId'], vphotos.length.toString());
          Navigator.pop(context);
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Venue Gallery"),
        ),
        body: FutureBuilder(
          future: getVPhotos(currentVenue['VId']),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Error(title: 'Error From Main');
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: vphotos.length,
                itemBuilder: (BuildContext context, int i) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://eventrra.000webhostapp.com/gallery/venue/gallery/${vphotos[i]['image']}"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: ExpandableFab(
          distance: 80.0,
          children: [
            ActionButton(
              icon: const Icon(Icons.insert_photo),
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
