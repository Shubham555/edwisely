// Appbar used on the Dashboard

import 'package:edwisely/widgets/elements/borderButton.dart';
import 'package:flutter/material.dart';

class WhiteAppBar extends StatelessWidget {
  final String title;
  final FlatButton flatButton;
  final BorderButton borderButton;

  WhiteAppBar({
    @required this.title,
    @required this.borderButton,
    @required this.flatButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 60),
      decoration: BoxDecoration(
        color: Colors.white,
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          flatButton,
          borderButton,
        ],
      ),
    );
  }
}
