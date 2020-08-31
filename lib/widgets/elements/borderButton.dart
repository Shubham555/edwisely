import 'package:flutter/material.dart';

class BorderButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final Color color;

  BorderButton({
    @required this.label,
    @required this.onPressed,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      // padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: FlatButton(
        child: Text(
          this.label,
          style: TextStyle(
            fontSize: 14,
            color: color,
          ),
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}
