// this is the main appbar for edwisely

import 'package:edwisely/util/gradients.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigAppBar extends StatelessWidget {
  final List<Widget> actions;
  final String titleText;
  final TabBar bottomTab;
  final double appBarSize;
  final Text appBarTitle;

  BigAppBar(
      {@required this.actions,
      @required this.titleText,
      @required this.bottomTab,
      @required this.appBarSize,
      @required this.appBarTitle});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: appBarTitle,
      elevation: 3,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(appBarSize),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration:
                  BoxDecoration(gradient: EdwiselyGradients.appBarGradient),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: Text(
                      titleText,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 30,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: bottomTab,
            )
          ],
        ),
      ),
    );
  }
}
