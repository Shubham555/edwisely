import 'package:edwisely/ui/screens/assessment/createAssessment/add_questions_screen.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:flutter/material.dart';

import '../../util/date_utild.dart';
import '../../util/theme.dart';
import '../screens/assessment/sendAssessment/send_assessment_screen.dart';

class AssessmentTile extends StatelessWidget {
  final int assessmentId;
  final String title;
  final String description;
  final String noOfQuestions;
  final String doe;
  final String startTime;
  final int sentTo;
  final int answeredCount;
  final String subjectName;
  final int subjectId;

  AssessmentTile(
    this.assessmentId,
    this.title,
    this.description,
    this.noOfQuestions,
    this.doe,
    this.startTime,
    this.subjectName,
    this.subjectId, [
    this.sentTo,
    this.answeredCount,
  ]);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    bool isDateVisible = startTime != null &&
        doe != null &&
        startTime.isNotEmpty &&
        doe.isNotEmpty;
    // int st = DateTime.parse(startTime).month;
    //
    // DateFormat formatter = DateFormat('hh : mm');
    // String displayStartTime = formatter.format(st);
    // String displayStartTime = '';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(blurRadius: 2.0, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: Column(
        children: [
          //top part
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title and description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: _screenSize.height * 0.035,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        height: _screenSize.height * 0.025,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            description,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                      Container(
                        height: _screenSize.height * 0.0225,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Subject: $subjectName',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontSize: 14.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //date and sections
                  Column(
                    children: [
                      isDateVisible
                          ? SizedBox.shrink()
                          : Transform.translate(
                              offset: Offset(10, -10),
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.edit,
                                  size: 22.0,
                                  color: Colors.black,
                                ),
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  '/add-questions',
                                  arguments: {
                                    'title': title,
                                    'description': description,
                                    'subjectId': subjectId,
                                    'questionType': QuestionType.Objective,
                                    'assessmentId': assessmentId,
                                  },
                                ),
                              ),
                            ),
                      Spacer(),
                      isDateVisible
                          ? Row(
                              children: [
                                Text(
                                  DateUtils().getMonthFromDateTime(
                                    DateTime.parse(
                                      startTime,
                                    ).month,
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  DateTime.parse(
                                    startTime,
                                  ).day.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                    ],
                  )
                ],
              ),
            ),
          ),
          //bottom Part
          Container(
            height: _screenSize.height * 0.05,
            color: EdwiselyTheme.CARD_COLOR,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Row(
              children: [
                //no. of questions
                Text(
                  'Questions : ',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(width: 4.0),
                Text(
                  '$noOfQuestions',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                //spacing
                Spacer(),
                //sent to
                if (sentTo != null)
                  Row(
                    children: [
                      Text(
                        'Sent To : ',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        '$sentTo',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                //spacing
                Spacer(),
                //answered count
                if (sentTo != null)
                  Row(
                    children: [
                      Text(
                        'Answered : ',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        '$answeredCount',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                Spacer(),
                //send button
                isDateVisible
                    ? SizedBox.shrink()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                        child: RaisedButton(
                          onPressed: () {
                            if (int.parse(noOfQuestions) == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddQuestionsScreen(
                                    title,
                                    description,
                                    subjectId,
                                    QuestionType.Objective,
                                    assessmentId,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SendAssessmentScreen(
                                    assessmentId,
                                    title,
                                    description,
                                  ),
                                ),
                              );
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          elevation: 2.0,
                          child: Text(
                            int.parse(noOfQuestions) == 0 ? 'Add' : 'Send',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   mainAxisSize: MainAxisSize.max,
    //   children: [
    //     Flexible(
    //       // width: MediaQuery.of(context).size.width / 1.2,
    //       child: Card(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(6),
    //         ),
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 title,
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 20,
    //                 ),
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 mainAxisSize: MainAxisSize.max,
    //                 children: [
    //                   Text(
    //                     description,
    //                     style: TextStyle(
    //                       fontSize: 16,
    //                       color: Colors.grey,
    //                     ),
    //                   ),
    //                   Row(
    //                     children: [
    //                       Text(
    //                         'No. of Questions : ',
    //                         style: TextStyle(
    //                           color: Colors.grey,
    //                         ),
    //                       ),
    //                       Text(
    //                         '$noOfQuestions',
    //                         style: TextStyle(
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       )
    //                     ],
    //                   )
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //     if (startTime != null &&
    //         doe != null &&
    //         startTime.isNotEmpty &&
    //         doe.isNotEmpty)
    //       Card(
    //         child: Padding(
    //           padding: const EdgeInsets.all(10),
    //           child: Column(
    //             children: [
    //               Text(
    //                 DateUtils().getMonthFromDateTime(
    //                   DateTime.parse(
    //                     startTime,
    //                   ).month,
    //                 ),
    //                 style: TextStyle(),
    //               ),
    //               Text(
    //                 DateTime.parse(
    //                   startTime,
    //                 ).day.toString(),
    //               ),
    //             ],
    //           ),
    //         ),
    //       )
    //     else
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Column(
    //           children: [
    //             IconButton(
    //               icon: Icon(
    //                 Icons.send,
    //                 size: 30,
    //               ),
    //               onPressed: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (BuildContext context) => MultiBlocProvider(
    //                       providers: [
    //                         BlocProvider(
    //                           create: (BuildContext context) =>
    //                               SendAssessmentCubit(),
    //                         ),
    //                         BlocProvider(
    //                           create: (BuildContext context) =>
    //                               SelectStudentsCubit(),
    //                         ),
    //                       ],
    //                       child: SendAssessmentScreen(assessmentId, title, []),
    //                     ),
    //                   ),
    //                 );
    //               },
    //             ),
    //             Text('Send')
    //           ],
    //         ),
    //       )
    //   ],
    // );
  }
}
