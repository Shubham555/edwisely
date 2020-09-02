import 'package:edwisely/ui/screens/assessment_landing_screen.dart';
import 'package:edwisely/util/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EdWisely());
}

class EdWisely extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edwisely',
      theme: EdwiselyTheme.themeDataEdwisely,
      home: AssessmentLandingScreen(),
    );
  }
}
