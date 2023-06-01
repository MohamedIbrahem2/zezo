// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomTextForm extends StatefulWidget {
  bool? secure = false;
  String? hint;
  bool obsecure = false;
  var controller;
  Function? onSave;
  Function? validate;

  CustomTextForm(
      {this.hint,
      this.secure,
      this.validate,
      this.onSave,
      this.controller,
      required this.obsecure});

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onSaved: (val) {
        widget.onSave!(val);
      },
      validator: (val) {
        widget.validate!(val);
      },
      obscureText: widget.obsecure,
      decoration: InputDecoration(
        hintStyle: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
        hintText: '${widget.hint}',
        suffixIcon: widget.secure == true
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.obsecure = !widget.obsecure;
                  });
                },
                child: Icon(Icons.remove_red_eye))
            : null,
      ),
    );
  }
}
