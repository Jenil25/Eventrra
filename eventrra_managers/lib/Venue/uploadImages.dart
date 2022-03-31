// ignore_for_file: avoid_init_to_null

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:eventrra_managers/data.dart';
import 'package:image_picker/image_picker.dart';

class UploadImages extends StatefulWidget {
  const UploadImages({Key? key}) : super(key: key);

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
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
        String filepath = imageFile!.path.split('/').last;
        uploadImageFile(imageFile!, filepath);
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
        String filepath = imageFile!.path.split('/').last;
        uploadImageFile(imageFile!, filepath);
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Profile"),
      ),
      body: Container(
        child: imageFile == null
            ? Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        _getFromGallery();
                      },
                      child: const Text("PICK FROM GALLERY"),
                    ),
                    Container(
                      height: 40.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _getFromCamera(context);
                      },
                      child: const Text("PICK FROM CAMERA"),
                    )
                  ],
                ),
              )
            : Image.file(
                imageFile!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
