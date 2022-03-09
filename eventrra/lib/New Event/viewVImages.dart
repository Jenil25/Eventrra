import 'package:flutter/material.dart';
import 'package:eventrra/data.dart';
import 'package:eventrra/main.dart';

class ViewVImages extends StatefulWidget {
  final venue;
  const ViewVImages({Key? key,required this.venue}) : super(key: key);

  @override
  State<ViewVImages> createState() => _ViewVImagesState(this.venue);
}

class _ViewVImagesState extends State<ViewVImages> {
  final venue;
  _ViewVImagesState(this.venue);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Images"),
      ),
      body : FutureBuilder(
        future: getVPhotos(venue['VId']),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return  Error(title: 'Error From Main');
          }

          if (snapshot.connectionState == ConnectionState.done) {
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
    );
  }
}
