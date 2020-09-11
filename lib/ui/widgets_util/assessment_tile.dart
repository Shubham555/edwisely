import 'package:edwisely/data/blocs/assessmentLandingScreen/addQuestionScreen/add_question_bloc.dart';
import 'package:edwisely/ui/screens/assessment/sendAssessment/send_assessment_screen.dart';
import 'package:edwisely/util/date_utild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssessmentTile extends StatelessWidget {
  final int assessmentId;
  final String title;
  final String description;
  final String noOfQuestions;
  final String doe;
  final String startTime;

  AssessmentTile(this.assessmentId, this.title, this.description,
      this.noOfQuestions, this.doe, this.startTime);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Card(
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
        ),
        if (startTime != null &&
            doe != null &&
            startTime.isNotEmpty &&
            doe.isNotEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    DateUtils().getMonthFromDateTime(
                      DateTime.parse(
                        startTime,
                      ).month,
                    ),
                    style: TextStyle(),
                  ),
                  Text(
                    DateTime.parse(
                      startTime,
                    ).day.toString(),
                  ),
                ],
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.send,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => BlocProvider(
                          create: (BuildContext context) => AddQuestionBloc(),
                          child: SendAssessmentScreen(
                              assessmentId, title, noOfQuestions),
                        ),
                      ),
                    );
                  },
                ),
                Text('Send')
              ],
            ),
          )
      ],
    );
  }
}
