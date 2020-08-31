// Appbar used on the Assessment Page

import 'package:edwisely/swatches/gradients.dart';
import 'package:edwisely/widgets/elements/borderButton.dart';
import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget {
  final String title;
  final FlatButton flatButton;
  final BorderButton borderButton;

  GradientAppBar({
    @required this.title,
    @required this.borderButton,
    @required this.flatButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 60),
      decoration: BoxDecoration(
        gradient: Gradients.peacock,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  'Edwisely',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
            child: Text(
              'Exit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: null,
          ),
          BorderButton(
            label: 'Done',
            onPressed: null,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
