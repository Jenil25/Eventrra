import 'dart:io';
import 'package:path/path.dart' as path1;
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

        print("_getFromGallery");
        imageFile = File(pickedFile.path);
        String filepath = imageFile!.path.split('/').last;
        print("Here");
        uploadImageFile(imageFile!, filepath);
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
        uploadImageFile(imageFile!, filepath);
        print(imageFile!.path.split('/').last);
        Navigator.pop(context);
      });
    }
    print("_getFromCamera End");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Upload Images"),
        ),
        body: Container(
            child: imageFile == null
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          // color: Colors.greenAccent,
                          onPressed: () {
                            _getFromGallery();
                          },
                          child: Text("PICK FROM GALLERY"),
                        ),
                        Container(
                          height: 40.0,
                        ),
                        ElevatedButton(
                          // color: Colors.lightGreenAccent,
                          onPressed: () {
                            _getFromCamera(context);

                          },
                          child: Text("PICK FROM CAMERA"),
                        )
                      ],
                    ),
                  )
                : Container(
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )));
  }
}