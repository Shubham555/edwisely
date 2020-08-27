import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String label;

  ListItem({@required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(82, 4.5, 0, 4.5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 7),
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Color.fromRGBO(54, 54, 54, 1),
            ),
          ),
        ],
      ),
    );
  }
}
