import 'package:edwisely/widgets/assessmentTile.dart';
import 'package:edwisely/widgets/dateTile.dart';
import 'package:edwisely/widgets/listItem.dart';
import 'package:edwisely/widgets/redChip.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 130,
              color: Theme.of(context).primaryColor,
            ),
            Column(
              children: [
                Column(
                  children: [
                    RedChip(label: 'Knowledge'),
                    ListItem(label: 'Lorem ipsum dolor sit amet'),
                    Container(
                      width: 904,
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                        boxShadow: null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Course Description',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(116, 116, 116, 1)),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   width: 904,
                    //   margin:
                    //       EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                    //   padding:
                    //       EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.all(
                    //       Radius.circular(24),
                    //     ),
                    //     boxShadow: null,
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         'Learning Outcomes',
                    //         style: TextStyle(
                    //           fontSize: 24,
                    //         ),
                    //       ),
                    //       ListItem(
                    //           label:
                    //               'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'),
                    //       ListItem(
                    //           label:
                    //               'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'),
                    //       ListItem(
                    //           label:
                    //               'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'),
                    //       ListItem(
                    //           label:
                    //               'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   width: 904,
                    //   margin:
                    //       EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                    //   padding:
                    //       EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(
                    //       Radius.circular(24),
                    //     ),
                    //     boxShadow: null,
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         'Pre - requisite knowledge',
                    //         style: TextStyle(
                    //           fontSize: 24,
                    //         ),
                    //       ),
                    //       Row(
                    //         children: [
                    //           RedChip(label: 'Knowledge'),
                    //           RedChip(label: 'Knowledge'),
                    //           RedChip(label: 'Knowledge'),
                    //           RedChip(label: 'Knowledge'),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // DateTile(
                    //   month: 'July',
                    //   date: '24',
                    // ),
                    AssessmentTile(
                      questions: 12,
                      subject: 'Subject',
                      title: 'Title',
                      units: [1, 2],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
