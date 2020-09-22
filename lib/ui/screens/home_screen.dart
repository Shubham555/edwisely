import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/assessment_landing_screen.dart';
import 'package:edwisely/ui/screens/course/add_course_screen.dart';
import 'package:edwisely/ui/screens/course/courses_landing_screen.dart';
import 'package:flutter/material.dart';

import '../widgets_util/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  int _selectedPage = 0;

  Size screenSize;
  TextTheme textTheme;

  List<Widget> _screens = [
    CoursesLandingScreen(),
    // CourseDetailScreen(_courseName, semesterSubjectId),
    AddCourseScreen(),
    AssessmentLandingScreen(),
    // CreateAssessmentScreen(_questionType)
    // AddQuestionsScreen(_title, _description, _subjectId, _questionType, _assessmentId)
    // SendAssessmentScreen(assessmentId, title, noOfQuestions)
  ];

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //side bar
          NavigationDrawer(
            isCollapsed: false,
            pageController: _pageController,
          ),
          //rest of the screen
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              scrollDirection: Axis.vertical,
              children: _screens,
              onPageChanged: (int value) =>
                  setState(() => _selectedPage = value),
            ),
          ),
        ],
      ),
    );
  }
}
