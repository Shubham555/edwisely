import 'package:edwisely/ui/screens/assessment/createAssessment/add_questions_screen.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final bool isConductedTile;

  AssessmentTile(
    this.assessmentId,
    this.title,
    this.description,
    this.noOfQuestions,
    this.doe,
    this.startTime,
    this.subjectName,
    this.subjectId,
    this.isConductedTile, [
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  //title and description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: _screenSize.width * 0.15,
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                          overflow: TextOverflow.ellipsis,
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
                      Spacer(),
                      isDateVisible
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('EEE , d/MM/yyyy HH:mm').format(
                                    DateTime.parse(
                                      startTime,
                                    ),
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                                Text(
                                  ' - ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),

                                Text(
                                    DateFormat('EEE , d/MM/yyyy HH:mm').format(
                                      DateTime.parse(
                                        doe,
                                      ),
                                    ) ,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),

                                // Text(
                                //   DateUtils().getMonthFromDateTime(
                                //       DateTime.parse(startTime).month),
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyText1
                                //       .copyWith(
                                //         color: Colors.black,
                                //       ),
                                // ),
                                // SizedBox(width: 3.0),
                                // Text(
                                //   DateTime.parse(startTime).day.toString(),
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyText1
                                //       .copyWith(
                                //         color: Colors.black,
                                //       ),
                                // ),
                                // SizedBox(width: 8.0),
                                // Text(
                                //   DateTime.parse(startTime).hour.toString(),
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyText1
                                //       .copyWith(
                                //         color: Colors.black,
                                //       ),
                                // ),
                                // Text(
                                //   ':',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyText1
                                //       .copyWith(
                                //         color: Colors.black,
                                //       ),
                                // ),
                                // Text(
                                //   DateTime.parse(startTime).minute.toString(),
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyText1
                                //       .copyWith(
                                //         color: Colors.black,
                                //       ),
                                // ),
                                // Text('  -  '),
                                // Text(
                                //   DateUtils().getMonthFromDateTime(
                                //       DateTime.parse(doe).month),
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyText1
                                //       .copyWith(
                                //         color: Colors.black,
                                //       ),
                                // ),
                                // SizedBox(width: 3.0),
                                // Text(
                                //   DateTime.parse(doe).day.toString(),
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyText1
                                //       .copyWith(
                                //         color: Colors.black,
                                //       ),
                                // ),
                                // SizedBox(width: 8.0),
                                // Text(
                                //   DateTime.parse(doe).hour.toString(),
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyText1
                                //       .copyWith(
                                //         color: Colors.black,
                                //       ),
                                // ),
                                // Text(
                                //   ':',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyText1
                                //       .copyWith(
                                //         color: Colors.black,
                                //       ),
                                // ),
                                // Text(
                                //   DateTime.parse(doe).minute.toString(),
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyText1
                                //       .copyWith(
                                //         color: Colors.black,
                                //       ),
                                // ),
                              ],
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  Spacer(),
                  isDateVisible
                      ? SizedBox.shrink()
                      : Transform.translate(
                          offset: Offset(10, -10),
                          child: isConductedTile
                              ? Container()
                              : IconButton(
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
                  // //date and sections
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     isDateVisible
                  //         ? SizedBox.shrink()
                  //         : Transform.translate(
                  //             offset: Offset(10, -10),
                  //             child: isConductedTile
                  //                 ? Container()
                  //                 : IconButton(
                  //                     padding: const EdgeInsets.all(0),
                  //                     icon: Icon(
                  //                       Icons.edit,
                  //                       size: 22.0,
                  //                       color: Colors.black,
                  //                     ),
                  //                     onPressed: () => Navigator.pushNamed(
                  //                       context,
                  //                       '/add-questions',
                  //                       arguments: {
                  //                         'title': title,
                  //                         'description': description,
                  //                         'subjectId': subjectId,
                  //                         'questionType': QuestionType.Objective,
                  //                         'assessmentId': assessmentId,
                  //                       },
                  //                     ),
                  //                   ),
                  //           ),
                  //     Spacer(),
                  //     isDateVisible
                  //         ? Row(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 DateUtils().getMonthFromDateTime(DateTime.parse(startTime).month),
                  //                 style: Theme.of(context).textTheme.bodyText1.copyWith(
                  //                       color: Colors.black,
                  //                     ),
                  //               ),
                  //               SizedBox(width: 8.0),
                  //               Text(
                  //                 DateTime.parse(startTime).day.toString(),
                  //                 style: Theme.of(context).textTheme.bodyText1.copyWith(
                  //                       color: Colors.black,
                  //                     ),
                  //               ),
                  //               Text('  -  '),
                  //               Text(
                  //                 DateUtils().getMonthFromDateTime(DateTime.parse(doe).month),
                  //                 style: Theme.of(context).textTheme.bodyText1.copyWith(
                  //                       color: Colors.black,
                  //                     ),
                  //               ),
                  //               SizedBox(width: 8.0),
                  //               Text(
                  //                 DateTime.parse(doe).day.toString(),
                  //                 style: Theme.of(context).textTheme.bodyText1.copyWith(
                  //                       color: Colors.black,
                  //                     ),
                  //               ),
                  //             ],
                  //           )
                  //         : SizedBox.shrink(),
                  //   ],
                  // )
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
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                        'Answered:',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        answeredCount == null ? '0' : '$answeredCount',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                //send button)
                isDateVisible
                    ? SizedBox.shrink()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                        child: GestureDetector(
                          onTap: () {
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
                          child: sentTo == null
                              ? Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    int.parse(noOfQuestions) == 0
                                        ? 'Add'
                                        : 'Send',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              : Container(),
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
