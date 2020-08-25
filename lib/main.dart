import 'package:edwisely/pages/assessmentPage.dart';
import 'package:edwisely/pages/dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(Edwisely());

class Edwisely extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Color.fromRGBO(0, 147, 105, 1),
        accentColor: Color.fromRGBO(255, 106, 106, 1),
        backgroundColor: Color.fromRGBO(229, 229, 229, 1),
      ),
      home: AssessmentPage(),
    );
  }
}
