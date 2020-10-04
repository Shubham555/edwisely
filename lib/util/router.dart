import 'package:edwisely/ui/screens/assessment/createAssessment/add_questions_screen.dart';
import 'package:edwisely/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../ui/screens/assessment/assessmentLandingScreen/assessment_landing_screen.dart';
import '../ui/screens/course/add_course_screen.dart';
import '../ui/screens/course/courses_landing_screen.dart';
import '../ui/screens/create_vc.dart';
import '../ui/screens/send_notification_screen.dart';

class MyRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _getPageRoute(HomeScreen(), settings);
        break;
      case '/all-courses':
        return _getPageRoute(CoursesLandingScreen(), settings);
        break;
      case '/add-course':
        return _getPageRoute(AddCourseScreen(), settings);
        break;
      case '/send-assesment':
        return _getPageRoute(AssessmentLandingScreen(), settings);
        break;
      case '/create-live-class':
        return _getPageRoute(CreateVCScreen(), settings);
        break;
      case '/send-notification':
        return _getPageRoute(SendNotificationScreen(), settings);
        break;
      case '/add-questions':
        final map = settings.arguments as Map<String, dynamic>;
        return _getPageRoute(
            AddQuestionsScreen(
              map['title'],
              map['description'],
              map['subjectId'],
              map['questionType'],
              map['assessmentId'],
            ),
            settings);
    }
    // for (Path path in paths) {
    //   final regExpPattern = RegExp(path.pattern);
    //   if (regExpPattern.hasMatch(settings.name)) {
    //     final firstMatch = regExpPattern.firstMatch(settings.name);
    //     final match = (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;
    //     return MaterialPageRoute<void>(
    //       builder: (context) => path.builder(context, match),
    //       settings: settings,
    //     );
    //   }
    // }
    // If no match is found, [WidgetsApp.onUnknownRoute] handles it.
    return null;
  }

  Future<dynamic> navigateTo(
    GlobalKey<NavigatorState> navigatorKey,
    String routeName,
  ) {
    return navigatorKey.currentState.pushNamed(routeName);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;

  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
