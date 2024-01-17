import 'package:flutter/material.dart';

class DividerHeading extends StatelessWidget {
  String heading;

  DividerHeading({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 9, right: 9, top: 20, bottom: 10),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Divider(
                thickness: 1.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                heading,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Expanded(
                child: Divider(
              thickness: 1.5,
            )),
          ],
        ),
      ),
    );
  }
}
