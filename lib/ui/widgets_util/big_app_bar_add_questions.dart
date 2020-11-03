import 'package:flutter/material.dart';

class BigAppBarAddQuestionScreen extends StatelessWidget {
  final List<Widget> actions;
  final String titleText;
  final double appBarSize;
  final Text appBarTitle;
  final Widget flatButton;
  final String description;
  final String subject;
  final String route;

  BigAppBarAddQuestionScreen({
    @required this.actions,
    @required this.titleText,
    @required this.appBarSize,
    @required this.appBarTitle,
    @required this.flatButton,
    @required this.description,
    @required this.subject,
    @required this.route,
  });

  @override
  PreferredSizeWidget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarSize),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.22,
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        width: _screenSize.width * 0.4,
                        child: Text(
                          titleText,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Container(
                        height: 6.0,
                        width: MediaQuery.of(context).size.width * 0.05,
                        margin: const EdgeInsets.only(top: 2.0, bottom: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32.0),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      // Text(
                      //   description,
                      //   textAlign: TextAlign.left,
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: MediaQuery.of(context).size.width / 60,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                      // Text(
                      //   subject,
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: MediaQuery.of(context).size.width / 60,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                      Container(
                        alignment: Alignment.topLeft,
                        height: _screenSize.height * 0.03,
                        width: _screenSize.width * 0.2,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            route,
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  flatButton != null ? flatButton : SizedBox.shrink(),
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
