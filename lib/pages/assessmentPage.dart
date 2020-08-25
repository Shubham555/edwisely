import 'package:edwisely/widgets/assessmentPanel.dart';
import 'package:edwisely/widgets/borderButton.dart';
import 'package:edwisely/widgets/previewTile.dart';
import 'package:flutter/material.dart';

class AssessmentPage extends StatefulWidget {
  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          color: Theme.of(context).primaryColor,
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Edwisely',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Assessment Title',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                child: Text(
                  'Preview',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: null,
              ),
              FlatButton(
                child: Text(
                  'Exit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: null,
              ),
              BorderButton(
                label: 'Done',
                onPressed: null,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   height: 50,
          //   color: Theme.of(context).primaryColor,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Row(
          //           children: [
          //             Text(
          //               'Edwisely',
          //               style: TextStyle(
          //                 fontSize: 20,
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //               child: Text(
          //                 'Assessment Title',
          //                 style: TextStyle(
          //                   fontSize: 20,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       FlatButton(
          //         child: Text(
          //           'Preview',
          //           style: TextStyle(
          //             color: Colors.white,
          //           ),
          //         ),
          //         onPressed: null,
          //       ),
          //       FlatButton(
          //         child: Text(
          //           'Exit',
          //           style: TextStyle(
          //             color: Colors.white,
          //           ),
          //         ),
          //         onPressed: null,
          //       ),
          //       BorderButton(
          //         label: 'Done',
          //         onPressed: null,
          //         color: Colors.white,
          //       )
          //     ],
          //   ),
          // ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 5,
                  color: Colors.grey.withOpacity(0.5),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            PreviewTile(
                              title: '1. Quiz',
                              question:
                                  'Who is the president of the United States?',
                            ),
                            PreviewTile(
                              title: '2. True or False',
                              question:
                                  'Churchill was Queen Elizabeth\'s first Prime Minister',
                            ),
                            PreviewTile(
                              title: '3. Quiz',
                              question: 'Which is the largest freshwater lake?',
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          'Add Question',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text(
                          'Question Bank',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text(
                          'Import spreadsheet',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AssessmentPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
