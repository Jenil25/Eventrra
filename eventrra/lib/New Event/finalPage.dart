import 'package:eventrra/My%20Events/myevent.dart';
import 'package:eventrra/data.dart';
import 'package:flutter/material.dart';
import 'package:eventrra/main.dart';
import 'package:intl/intl.dart';

class FinalPage extends StatefulWidget {
  @override
  _FinalPageState createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    bool isLoading = false;
    bool isClicked = false;
    bool isCorrect = false;
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String fDate = formatter.format(inputFDate);
    String tDate = formatter.format(inputTDate);

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Column(
              children: [
                isCorrect ? Text("Your request has been send to the corresponding vendors.You will receive a mail soon !!\n\n") : Text(""),
                Text(inputCity['Name']),
                Text(inputFDate.toString()),
                Text(inputTDate.toString()),
                Text(inputEventType['EventType']),
                Text(inputVenue['Name']),
                inputCaterer != null ? Text(inputCaterer['Name']) : Text(" "),
                Text(inputUserName),
                Text(inputContact),
                Column(
                  children: [
                    isCorrect ? Text("Confirmed") : Text(""),
                    Container(
                      color: Colors.blue.shade300,
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          setModalState(() {
                            isLoading = true;
                          });
                          if (isLoading && mounted == true) {

                            uploadEventRequest(
                                inputCity,
                                fDate,
                                tDate,
                                inputEventType,
                                inputVenue,
                                inputCaterer,
                                null,
                                null,
                                inputUserName,
                                inputContact,
                                uid).then(
                                  (value) =>
                              {
                                if (value)
                                  {
                                    setModalState(() {
                                      isLoading = false;
                                      isClicked = true;
                                      isCorrect = true;
                                    }),
                                  }
                                else
                                  {
                                    setModalState(() {
                                      isLoading = false;
                                      isClicked = true;
                                      isCorrect = false;
                                    })
                                  }
                              },
                            );
                          }

                          setModalState(() {
                            isLoading = true;
                          });
                        },
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : isClicked
                            ? isCorrect
                            ? const Icon(
                          Icons.verified,
                          color: Colors.white,
                        )
                            : const Icon(Icons.error, color: Colors.white)
                            : const Text(
                          "CONFIRM",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                isCorrect ? ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    //final city, fdate, tdate, eventType;
                    MaterialPageRoute(
                      builder: (context) => MyEvent(),
                    ),
                  );

                }, child:  Text("View Details")) : Text( " "),
              ],
            );
          }),
    );
  }
}