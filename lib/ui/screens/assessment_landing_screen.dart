import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:flutter/material.dart';

class AssessmentLandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigAppBar(
        actions: [],
        titleText: 'My Assessments',
        bottomRow: Row(),
        appBarSize: MediaQuery.of(context).size.height / 3.5,
        appBarTitle: Text(
          'Edwisely',
          style: TextStyle(color: Colors.black),
        ),
      ).build(context),
    );
  }
}
