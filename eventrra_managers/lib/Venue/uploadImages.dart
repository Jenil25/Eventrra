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
        imageFile = File(pickedFile.path);
      });
    }
  }

  _getFromCamera() async {
    print("_getFromCamera Start");
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        print("_getFromCamera");
        // String temp = "file" +currentVenue['VId']+".jpg";
        imageFile = File(pickedFile.path);
        // String fileDir = path1.dirname(imageFile!.path);
        // String newPath = path1.join(fileDir, temp);
        // // imageFile!.rename(newPath);
        // print(newPath);
        String filepath = imageFile!.path.split('/').last;
        print("Here");
        uploadImageFile(imageFile!, filepath);
        uploadImageFileTRY(imageFile!, filepath);
        print(imageFile!.path.split('/').last);
        // print(imageFile!.);
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
                            _getFromCamera();
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
