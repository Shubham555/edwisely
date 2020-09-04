import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssessmentTile extends StatelessWidget {
  final String title;
  final String description;
  final String noOfQuestions;
  final String doe;
  final String startTime;

  AssessmentTile(this.title, this.description, this.noOfQuestions, this.doe,
      this.startTime);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'No. of Questions : ',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '$noOfQuestions',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Card(
            child: Column(
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
