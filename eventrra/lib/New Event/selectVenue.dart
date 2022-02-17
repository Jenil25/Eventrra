import 'package:flutter/material.dart';
import 'package:eventrra/data.dart';

//city,date,event-type
class SelectVenue extends StatefulWidget {
  final city, date, eventType;
  const SelectVenue({Key? key, this.city, this.date, this.eventType})
      : super(key: key);

  @override
  _SelectVenueState createState() => _SelectVenueState(
        city: city,
        date: date,
        eventType: eventType,
      );
}

class _SelectVenueState extends State<SelectVenue> {
  final city, date, eventType;
  _SelectVenueState({this.city, this.date, this.eventType});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Venue"),
      ),
      body: Column(
        children: [
          Text(city.toString()),
          Text(date.toString()),
          Text(eventType.toString()),
        ],
      ),
    );
  }
}
