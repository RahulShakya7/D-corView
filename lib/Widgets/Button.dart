import 'package:flutter/material.dart';

class UploadDataButton extends StatefulWidget {
  String text;
  Function onPressed;
  UploadDataButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  State<UploadDataButton> createState() => _UploadDataButtonState();
}

class _UploadDataButtonState extends State<UploadDataButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 10, left: 80, right: 80),
      child: SizedBox(
        child: ElevatedButton(
          onPressed: () async {
            widget.onPressed();
          },
          child: Center(
              child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          )),
        ),
      ),
    );
  }
}
