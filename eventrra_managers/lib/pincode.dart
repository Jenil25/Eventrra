import 'package:flutter/material.dart';

class Pincode extends StatefulWidget {
  @override
  _PincodeState createState() => _PincodeState();
}

class _PincodeState extends State<Pincode> {
  TextEditingController pincode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        keyboardType: TextInputType.number,
        controller: pincode,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Pincode',
        ),
      ),
    );
  }
}
