import 'package:eventrra/My%20Events/myevent.dart';
import 'package:eventrra/data.dart';
import 'package:flutter/cupertino.dart';
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
        title: const Text("Details"),
      ),
      body: StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isCorrect
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.verified,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: const Text(
                              "Your request has been send to the corresponding vendors. You will receive a mail soon !!",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const Text(""),
            showDetails(),
            Column(
              children: [
                isCorrect ? const Text("Confirmed") : const Text(""),
                Container(
                  color: Colors.blue.shade300,
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      if (isCorrect) return;
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
                                uid,
                                eid)
                            .then(
                          (value) => {
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
            isCorrect
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        //final city, fdate, tdate, eventType;
                        MaterialPageRoute(
                          builder: (context) => const MyEvent(),
                        ),
                      );
                    },
                    child: const Text("View Details"))
                : const Text(" "),
          ],
        );
      }),
    );
  }

  Widget showDetails() {
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String fDate = formatter.format(inputFDate);
    String tDate = formatter.format(inputTDate);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            makeField(Icons.location_on, inputCity['Name']),
            makeField(Icons.calendar_today_rounded, fDate + " to " + tDate),
            makeField(Icons.article_rounded, inputEventType['EventType']),
            makeField(Icons.apartment_rounded, inputVenue['Name']),
            inputCaterer != null
                ? makeField(Icons.food_bank_outlined, inputCaterer['Name'])
                : const SizedBox(),
            makeField(Icons.person, inputUserName),
            makeField(Icons.phone, inputContact),
          ],
        ),
      ),
    );
  }

  Widget makeField(IconData icon, String value) {
    TextStyle style = const TextStyle(
      fontSize: 18,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 30,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            value,
            style: style,
          ),
        ],
      ),
    );
  }
}
