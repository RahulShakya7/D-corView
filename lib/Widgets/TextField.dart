import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controllers;
  FormFieldValidator<String>? validator;
  String labelText;

  CustomTextField(
      {super.key,
      required this.labelText,
      required this.controllers,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        controller: controllers,
        validator: validator,
        // controller: customerName.text=i.customerName==null?'':i.customerName,
        autovalidateMode: AutovalidateMode.always,
        style: const TextStyle(),
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          filled: true,
        ),
      ),
    );
  }
}
