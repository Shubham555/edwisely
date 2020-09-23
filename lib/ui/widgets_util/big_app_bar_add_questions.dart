import 'package:flutter/material.dart';

import '../../util/gradients.dart';

class BigAppBarAddQuestionScreen extends StatelessWidget {
  final List<Widget> actions;
  final String titleText;

  final double appBarSize;
  final Text appBarTitle;
  final FlatButton flatButton;
  final String description;
  final String subject;

  BigAppBarAddQuestionScreen(
      {@required this.actions,
      @required this.titleText,
      @required this.appBarSize,
      @required this.appBarTitle,
      @required this.flatButton,
      @required this.description,
      @required this.subject});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarSize),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2.0,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 32.0,
                horizontal: MediaQuery.of(context).size.width * 0.17,
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          titleText,
                          style: Theme.of(context).textTheme.headline1,
                          // TextStyle(
                          //   color: Colors.white,
                          //   fontSize: MediaQuery.of(context).size.width / 45,
                          //   fontWeight: FontWeight.bold,
                          // ),
                        ),
                      ),
                      Align(
                        child: Text(
                          description,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 60,
                              fontWeight: FontWeight.w400),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Align(
                        child: Text(
                          subject,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 60,
                              fontWeight: FontWeight.w400),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: flatButton,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // AppBar(
    //   backgroundColor: Colors.white,
    //   iconTheme: IconThemeData(color: Colors.black),
    //   automaticallyImplyLeading: false,
    //   // title: appBarTitle,
    //   elevation: 3,
    //   actions: actions,
    //   bottom: PreferredSize(
    //     preferredSize: Size.fromHeight(appBarSize),
    //     child: Column(
    //       children: [
    //         Container(
    //             width: MediaQuery.of(context).size.width,
    //             height: MediaQuery.of(context).size.height / 5,
    //             decoration:
    //                 BoxDecoration(gradient: EdwiselyGradients.appBarGradient),
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 20),
    //               child: Stack(children: [
    //                 Column(
    //                   children: [
    //                     Align(
    //                       child: Text(
    //                         titleText,
    //                         style: TextStyle(
    //                             color: Colors.white,
    //                             fontSize:
    //                                 MediaQuery.of(context).size.width / 45,
    //                             fontWeight: FontWeight.bold),
    //                       ),
    //                       alignment: Alignment.centerLeft,
    //                     ),
    //                     Align(
    //                       child: Text(
    //                         description,
    //                         textAlign: TextAlign.left,
    //                         style: TextStyle(
    //                             color: Colors.white,
    //                             fontSize:
    //                                 MediaQuery.of(context).size.width / 60,
    //                             fontWeight: FontWeight.w400),
    //                       ),
    //                       alignment: Alignment.centerLeft,
    //                     ),
    //                     Align(
    //                       child: Text(
    //                         subject,
    //                         style: TextStyle(
    //                             color: Colors.white,
    //                             fontSize:
    //                                 MediaQuery.of(context).size.width / 60,
    //                             fontWeight: FontWeight.w400),
    //                       ),
    //                       alignment: Alignment.centerLeft,
    //                     ),
    //                   ],
    //                 ),
    //                 Align(
    //                   alignment: Alignment.bottomRight,
    //                   child: flatButton,
    //                 )
    //               ]),
    //             )),
    //       ],
    //     ),
    //   ),
    // );
  }
}
