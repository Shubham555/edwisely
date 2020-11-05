// this is the main appbar for edwisely

import 'package:auto_size_text/auto_size_text.dart';
import 'package:edwisely/util/gradients.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigAppBar extends StatelessWidget {
  final List<Widget> actions;
  final String titleText;
  final TabBar bottomTab;
  final double appBarSize;
  final Text appBarTitle;
  final Widget flatButton;
  final String route;

  BigAppBar({
    @required this.actions,
    @required this.titleText,
    @required this.bottomTab,
    @required this.appBarSize,
    @required this.appBarTitle,
    @required this.flatButton,
    @required this.route,
  });

  @override
  PreferredSizeWidget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.15,
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
                vertical: 0.0,
                horizontal: MediaQuery.of(context).size.width * 0.17,
              ),
              child: Row(
                // fit: StackFit.expand,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          // Heading
                          titleText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(fontSize: 28.0),
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
                      Container(
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                              // Route
                              route,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: Theme.of(context).primaryColor)),
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
          Align(
            alignment: Alignment.centerLeft,
            child: bottomTab,
          )
        ],
      ),
    );
  }
}
