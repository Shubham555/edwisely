import 'package:edwisely/data/blocs/conductdBloc/conducted_bloc.dart';
import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:edwisely/data/blocs/objectiveBloc/objective_bloc.dart';
import 'package:edwisely/data/blocs/subjectiveBloc/subjective_bloc.dart';
import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/conductedTab/conducted_tab.dart';
import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/objective_tab.dart';
import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/subjective_tab.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/create_assessment_screen.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:edwisely/ui/widgets_util/navigation_drawer.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import '../../../../data/provider/selected_page.dart';
import '../../../../util/theme.dart';

class AssessmentLandingScreen extends StatefulWidget {
  @override
  _AssessmentLandingScreenState createState() =>
      _AssessmentLandingScreenState();
}

class _AssessmentLandingScreenState extends State<AssessmentLandingScreen>
    with SingleTickerProviderStateMixin {
  TabController _assessmentLandingScreenTabController;

  @override
  void initState() {
    _assessmentLandingScreenTabController =
        TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationDrawer(
            isCollapsed: false,
            key: context.watch<SelectedPageProvider>().navigatorKey,
          ),
          Expanded(
            child: Column(
              children: [
                BigAppBar(
                  actions: [],
                  titleText: 'My Assessments',
                  bottomTab: null,
                  appBarSize: MediaQuery.of(context).size.height / 3,
                  appBarTitle: Text(
                    'Edwisely',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  flatButton: FlatButton(
                    hoverColor: Color(0xFF1D2B64).withOpacity(.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(
                        color: Color(0xFF1D2B64),
                      ),
                    ),
                    onPressed: () => _showAlertDialog(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Create Assessment',
                          style: TextStyle(
                            color: Color(0xFF1D2B64),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Color(0xFF1D2B64),
                        )
                      ],
                    ),
                  ),
                ).build(context),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TabBar(
                          labelPadding: EdgeInsets.symmetric(horizontal: 36.0),
                          indicatorColor: EdwiselyTheme.PRIMARY_COLOR,
                          labelColor: Colors.white,
                          indicator: BoxDecoration(
                            color: EdwiselyTheme.PRIMARY_COLOR,
                          ),
                          indicatorPadding: const EdgeInsets.only(top: 8.0),
                          unselectedLabelColor: EdwiselyTheme.PRIMARY_COLOR,
                          unselectedLabelStyle:
                              Theme.of(context).textTheme.headline6,
                          labelStyle: Theme.of(context).textTheme.headline5,
                          controller: _assessmentLandingScreenTabController,
                          isScrollable: true,
                          tabs: [
                            Tab(
                              text: 'Objective',
                            ),
                            Tab(
                              text: 'Subjective',
                            ),
                            Tab(
                              text: 'Conducted',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _assessmentLandingScreenTabController,
                          children: [
                            MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (BuildContext context) =>
                                      ObjectiveBloc()
                                        ..add(
                                          GetObjectiveTests(),
                                        ),
                                ),
                                BlocProvider(
                                  create: (BuildContext context) =>
                                      CoursesBloc()
                                        ..add(
                                          GetCoursesList(),
                                        ),
                                ),
                              ],
                              child: ObjectiveTab(),
                            ),
                            MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (BuildContext context) =>
                                      SubjectiveBloc()
                                        ..add(
                                          GetSubjectiveTests(),
                                        ),
                                ),
                                BlocProvider(
                                  create: (BuildContext context) =>
                                      CoursesBloc()
                                        ..add(
                                          GetCoursesList(),
                                        ),
                                ),
                              ],
                              child: SubjectiveTab(),
                            ),
                            MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (BuildContext context) =>
                                      ConductedBloc()
                                        ..add(
                                          GetObjectiveQuestions(),
                                        ),
                                ),
                                BlocProvider(
                                  create: (BuildContext context) =>
                                      CoursesBloc()
                                        ..add(
                                          GetSectionsAndGetCoursesList(71),
                                        ),
                                ),
                              ],
                              child: ConductedTab(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showAlertDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Create a New Assignment',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 40),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  ListTile(
                    trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text('Objective'),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (BuildContext context) => ObjectiveBloc(),
                            ),
                            BlocProvider(
                              create: (BuildContext context) =>
                                  SubjectiveBloc(),
                            ),
                            BlocProvider(
                              create: (BuildContext context) => CoursesBloc(),
                            ),
                          ],
                          child: CreateAssessmentScreen(QuestionType.Objective),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text('Subjective'),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (BuildContext context) => ObjectiveBloc(),
                            ),
                            BlocProvider(
                              create: (BuildContext context) =>
                                  SubjectiveBloc(),
                            ),
                            BlocProvider(
                              create: (BuildContext context) => CoursesBloc(),
                            ),
                          ],
                          child:
                              CreateAssessmentScreen(QuestionType.Subjective),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
