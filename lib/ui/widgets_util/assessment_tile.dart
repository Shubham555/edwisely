import 'package:flutter/material.dart';

class AssessmentTile extends StatelessWidget {
  final String title;
  final String description;
  final String noOfQuestions;

  AssessmentTile(this.title, this.description, this.noOfQuestions);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ],
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
              children: [

              ],
            ),
          )
        ],
      ),
    );
  }
}
