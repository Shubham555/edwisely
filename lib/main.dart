import 'package:edwisely/pages/dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(Edwisely());

class Edwisely extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: Dashboard(),
    );
  }
}
