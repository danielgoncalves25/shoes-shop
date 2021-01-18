import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputForm extends StatefulWidget {
  TextEditingController controller;
  String type;
  IconData icon;

  InputForm(this.controller, this.type, this.icon);

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.type,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        prefixIcon: Icon(widget.icon),
        hintText: "Please enter your ${widget.type.toLowerCase()}",
      ),
    );
  }
}
