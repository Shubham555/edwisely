import 'package:flutter/material.dart';

class DateTile extends StatelessWidget {
  final String month;
  final String date;

  DateTile({
    @required this.month,
    @required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            month,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 36,
            ),
          ),
        ],
      ),
    );
  }
}
