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
  final FlatButton flatButton;

  BigAppBar(
      {@required this.actions,
      @required this.titleText,
      @required this.bottomTab,
      @required this.appBarSize,
      @required this.appBarTitle,
      @required this.flatButton});

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
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Align(
                        child: Text(
                          titleText,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 30,
                              fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: flatButton,
                      )
                    ],
                  ),
                )),
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
