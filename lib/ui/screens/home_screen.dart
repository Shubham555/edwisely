import 'package:edwisely/ui/screens/course/courses_landing_screen.dart';
import 'package:flutter/material.dart';
import '../widgets_util/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size screenSize;
  TextTheme textTheme;

  List<Widget> _screens = [
    
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
          NavigationDrawer(isCollapsed: false),
          //rest of the screen
          Expanded(
            child: Container(
              color: Colors.white,
              child: CoursesLandingScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
