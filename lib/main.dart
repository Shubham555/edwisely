// Feel free to reach out to me anytime for doubts :)
// Been an awesome experience working on this project
// Signing off - Vis

import 'package:edwisely/swatches/themes.dart';
import 'package:edwisely/widgets/assessment/assessment_landing_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(Edwisely());

class Edwisely extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.peacock,
      // Assessment model containing dummy data
      //Reset home page when the design is done
      home: AssessmentLandingPage(),
    );
  }
}