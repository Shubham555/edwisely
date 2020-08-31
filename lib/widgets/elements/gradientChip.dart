import 'package:edwisely/swatches/gradients.dart';
import 'package:flutter/material.dart';

class GradientChip extends StatelessWidget {
  final String label;

  GradientChip({@required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(68)),
        gradient: Gradients.peacock,
      ),
      margin: EdgeInsets.all(9),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
