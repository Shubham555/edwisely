import 'package:flutter/material.dart';

class RedChip extends StatelessWidget {
  final String label;

  RedChip({@required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(68)),
        color: Theme.of(context).accentColor,
      ),
      margin: EdgeInsets.all(9),
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 19,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
