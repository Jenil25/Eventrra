import 'package:eventrra_managers/Caterers/events.dart';
import 'package:eventrra_managers/data.dart';
import 'package:flutter/material.dart';
import 'package:eventrra_managers/main.dart';

class LoadingCalendar extends StatefulWidget {
  const LoadingCalendar({Key? key}) : super(key: key);

  @override
  _LoadingCalendarState createState() => _LoadingCalendarState();
}

class _LoadingCalendarState extends State<LoadingCalendar> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCatererEventDates(currentCaterer['CaId']),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Error(title: 'Error From Loading Calendar');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          test obj = test();
          obj.testfunction();
          return const Events();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Calendar"),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
