import 'package:flutter/material.dart';
import 'package:eventrra/data.dart';
import 'package:eventrra/main.dart';
import 'package:intl/intl.dart';

class FinalPage extends StatefulWidget {
  const FinalPage({Key? key}) : super(key: key);

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  @override
  Widget build(BuildContext context) {

    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String fDate = formatter.format(inputFDate);
    String tDate = formatter.format(inputTDate);
    bool isLoading=false,isCorrect=false,isVerified=false;

    return Scaffold(
      appBar: AppBar(),
      body : Column(
        children : [
        Text(inputCity['Name']),
          Text(inputFDate.toString()),
          Text(inputTDate.toString()),
          Text(inputEventType['EventType']),
          Text(inputVenue['Name']),

          inputCaterer != null ? Text(inputCaterer['Name']) : Text(" "),
          Text(inputUserName),
          Text(inputContact),
          ElevatedButton(
              onPressed : () {


                FutureBuilder(

                  // Initialize FlutterFire
                  future: uploadEventRequest(inputCity,fDate,tDate,inputEventType,inputVenue,inputCaterer,null,null,inputUserName,inputContact,uid),
                  builder: (context, snapshot) {
                    // Check for errors
                    if (snapshot.hasError) {
                      return Error(title: 'Error From Final Page');
                    }

                    // Once complete, show your application
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        child : Text("Confirmed")
                      );
                    }

                    // Otherwise, show something whilst waiting for initialization to complete
                    return CircularProgressIndicator();
                  },
                );

          }, child: Text("Confirm")),
          Container(
            child: TextButton(
              onPressed: (){
                if(isLoading)
                  return;
                setState((){
                  isLoading=true;
                });
                uploadEventRequest(inputCity,fDate,tDate,inputEventType,inputVenue,inputCaterer,null,null,inputUserName,inputContact,uid).then((value) =>
                {
                  print(value),
                  if(value == true)
                    setState((){
                        isCorrect=true;
                        isLoading=false;
                        isVerified= true;

                        print(isCorrect);
                        print(isLoading);
                        print(isVerified);
                    })
                  else
                    setState(() {
                      isCorrect=false;
                      isLoading=false;
                      isVerified=true;

                      print("else");
                      print(isCorrect);
                      print(isLoading);
                      print(isVerified);
                    })
                }
                );

                },

              child : isLoading==true
                      ? const CircularProgressIndicator()
                      : isVerified==true
                         ?  Text("View Details")
                         : Text("Confirm"),
            ),
          ),
          isCorrect==true
          ?  Text("Confirmed")
          : Text(" "),
        ],
      )
    );

  }
}
