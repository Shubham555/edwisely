// Widget to display assessments on the My Assessments Page
// TODO: Modify to adhere to new design

import 'package:flutter/material.dart';

class AssessmentTile extends StatelessWidget {
  final String title;
  final String subject;
  final List<int> units;
  final int questions;

  AssessmentTile({
    @required this.title,
    @required this.subject,
    @required this.questions,
    @required this.units,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: Container(
        width: 624,
        height: 100,
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 22,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Unit ${units[0]}, ${units[1]}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(116, 116, 116, 1),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subject,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(116, 116, 116, 1),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'No of questions: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(116, 116, 116, 1),
                      ),
                    ),
                    Text(
                      '$questions',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      feedback: Container(
        width: 624,
        height: 100,
        color: Colors.grey,
      ),
      childWhenDragging: Container(
        width: 624,
        height: 100,
        color: Colors.blue,
      ),
    );
  }
}
