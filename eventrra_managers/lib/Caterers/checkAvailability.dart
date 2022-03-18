import 'package:flutter/material.dart';
import 'package:eventrra_managers/main.dart';
import 'package:eventrra_managers/data.dart';
import 'package:intl/intl.dart';

class CheckAvailability extends StatefulWidget {
  @override
  _CheckAvailabilityState createState() => _CheckAvailabilityState();
}

class _CheckAvailabilityState extends State<CheckAvailability> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController reasoncontroller = TextEditingController();

  bool isClicked = false, isLoading = false, isDone = false;
  bool disClicked = false, disLoading = false, disDone = false;
  DateTime now = DateTime.now(),
      fromDate = DateTime.now(),
      toDate = DateTime.now(),
      todaysDate = DateTime.now();

  Future<void> _selectDate(
      BuildContext context, bool from, StateSetter setModalState) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: from ? fromDate : toDate,
        firstDate: DateTime(todaysDate.year),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      if (from) {
        if (pickedDate.year > toDate.year &&
            pickedDate.month > toDate.month &&
            pickedDate.day > toDate.day) {
          AlertDialog alert = AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(
                  Icons.error,
                  // color: Colors.red,
                ),
                Text(
                  " Error",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: const Text("Please enter valid to and from dates!"),
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        } else {
          setModalState(() {
            // if(from) {
            fromDate = pickedDate;
            // }
            // else{
            //   toDate = pickedDate;
            // }
          });
        }
      } else {
        if (pickedDate.year < fromDate.year &&
            pickedDate.month < fromDate.month &&
            pickedDate.day < fromDate.day) {
          AlertDialog alert = AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(
                  Icons.error,
                  // color: Colors.red,
                ),
                Text(
                  " Error",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: const Text("Please enter valid to and from dates!"),
          );
          setModalState(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                });
          });
        } else {
          setModalState(() {
            // if(from) {
            //   fromDate = pickedDate;
            // }
            // else{
            toDate = pickedDate;
            // }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Occupied Dates"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Your Catering Service is occupied on following dates:",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: getCatererOccupiedDetails(currentCaterer["CaId"]),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Error(title: 'Error From Main');
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      itemCount: catererOccupiedDates.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: const Icon(Icons.calendar_today),
                          title: Text(catererOccupiedDates[index]["FDate"]
                                  .toString() +
                              " - " +
                              catererOccupiedDates[index]["TDate"].toString() +
                              " for " +
                              catererOccupiedDates[index]["Reason"].toString()),
                          trailing: StatefulBuilder(builder:
                              (BuildContext context,
                                  StateSetter setModalState1) {
                            return TextButton(
                              onPressed: () {
                                deleteOccupiedCaterer(
                                        catererOccupiedDates[index]['OCaId'])
                                    .then((value) {
                                  print(value);
                                  if (value != "success") {
                                    print("If");
                                    setModalState1(() {
                                      disLoading = false;
                                      disClicked = true;
                                      disDone = true;
                                    });
                                  } else {
                                    print(value);
                                    setModalState1(() {
                                      disLoading = false;
                                      disClicked = true;
                                      disDone = false;
                                    });
                                    AlertDialog alert = AlertDialog(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: const <Widget>[
                                          Icon(
                                            Icons.done,
                                            color: Colors.green,
                                          ),
                                          Text(
                                            "Deleted Successfully ",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    );
                                    setState(() {});
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        });
                                  }
                                });
                              },
                              child: disLoading
                                  ? CircularProgressIndicator()
                                  : Icon(Icons.delete),
                              // : isClicked ? isDone ? :
                              //             :
                            );
                          }),
                        );
                      },
                    ),
                  );
                }

                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                  color: Colors.transparent,
                  child: StatefulBuilder(builder:
                      (BuildContext context, StateSetter setModalState) {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0)),
                      ),
                      padding: MediaQuery.of(context).viewInsets,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Select dates when the caterering service will be occupied:",
                              style: TextStyle(
                                color: Colors.blue.shade500,
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, right: 20, bottom: 10, left: 20),
                                  child: ElevatedButton(
                                    onPressed: () => _selectDate(
                                        context, true, setModalState),
                                    child: const Text(
                                      'From date',
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ),
                                ),
                                Text(
                                  fromDate.day.toString() +
                                      "-" +
                                      fromDate.month.toString() +
                                      "-" +
                                      fromDate.year.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 20),
                                  child: ElevatedButton(
                                    onPressed: () => _selectDate(
                                        context, false, setModalState),
                                    child: const Text(
                                      'To date',
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ),
                                ),
                                Text(
                                  toDate.day.toString() +
                                      "-" +
                                      toDate.month.toString() +
                                      "-" +
                                      toDate.year.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                controller: reasoncontroller,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.question_answer,
                                    color: Colors.blue.shade600,
                                    size: 30,
                                  ),
                                  labelText: "Reason",
                                ),
                              ),
                            ),
                            //     TextFormField(
                            //       controller: reasoncontroller,
                            //       keyboardType: TextInputType.text,
                            //
                            //       onChanged: (value) {},
                            //     ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      if (isLoading) return;
                                      setModalState(() {
                                        isLoading = true;
                                      });
                                      DateFormat formatter =
                                          DateFormat('dd-MM-yyyy');
                                      String fDate = formatter.format(fromDate);
                                      String tDate = formatter.format(toDate);
                                      addOccupiedCaterer(
                                              fDate,
                                              tDate,
                                              currentCaterer["CaId"],
                                              reasoncontroller.text)
                                          .then((value) {
                                        print(value);
                                        if (value == "success") {
                                          setState(() {});
                                          print("If");
                                          setModalState(() {
                                            fromDateController.text = "";
                                            toDateController.text = "";
                                            isLoading = false;
                                            isClicked = true;
                                            isDone = true;
                                          });
                                        } else {
                                          print(value);
                                          AlertDialog alert = AlertDialog(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: const <Widget>[
                                                Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                ),
                                                Text(
                                                  " Error",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            content: Text(value),
                                          );
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alert;
                                              });
                                          setModalState(() {
                                            isLoading = false;
                                            isClicked = true;
                                            isDone = false;
                                          });
                                        }
                                      });
                                    },
                                    child: const Text(
                                      "Add",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 100,
                                  // color: Colors.blue.shade300,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                isLoading == true
                                    ? const CircularProgressIndicator()
                                    : isClicked == true
                                        ? isDone == true
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: const Text("Added"),
                                              )
                                            : const Text("Error")
                                        : const Text("")
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
            );
          },
          label: const Text("Change Availability")),
    );
  }
}
