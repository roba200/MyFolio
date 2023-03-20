import 'package:flutter/material.dart';

class RoundedTextField extends StatefulWidget {
  String hintText = "";
  bool obsecureText = false;
  TextEditingController controller;
  int maxLines = 1;
  final validator;
  RoundedTextField(
      {super.key,
      required this.hintText,
      required this.obsecureText,
      required this.controller,
      this.maxLines = 1,
      this.validator = null});

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey),
            hintText: widget.hintText,
            fillColor: Colors.white70),
        obscureText: widget.obsecureText,
        controller: widget.controller,
        validator: widget.validator,
      ),
    );
  }
}
