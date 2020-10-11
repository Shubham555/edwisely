import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../data/blocs/conductdBloc/conducted_bloc.dart';
import '../../../../data/blocs/coursesBloc/courses_bloc.dart';
import '../../../../data/blocs/objectiveBloc/objective_bloc.dart';
import '../../../../data/blocs/subjectiveBloc/subjective_bloc.dart';
import '../../../../data/provider/selected_page.dart';
import '../../../../util/enums/question_type_enum.dart';
import '../../../widgets_util/big_app_bar.dart';
import '../../../widgets_util/navigation_drawer.dart';
import '../createAssessment/create_assessment_screen.dart';
import 'conductedTab/conducted_tab.dart';
import 'objective_tab.dart';
import 'subjective_tab.dart';

class AssessmentLandingScreen extends StatefulWidget {
  @override
  _AssessmentLandingScreenState createState() => _AssessmentLandingScreenState();
}

class _AssessmentLandingScreenState extends State<AssessmentLandingScreen> with SingleTickerProviderStateMixin {
  TabController _assessmentLandingScreenTabController;

  @override
  void initState() {
    _assessmentLandingScreenTabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationDrawer(
            isCollapsed: MediaQuery.of(context).size.width <= 1366 ? true : false,
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
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  route: 'Home > My Assesments',
                  flatButton: RaisedButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => CreateAssessmentScreen(QuestionType.Objective),
                      ),
                    ),
                    child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/create_vc.png',
                            color: Colors.white,
                            height: 24.0,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Create Assesment',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ],
                      ),
                  ),
                ).build(context),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: MediaQuery.of(context).size.width * 0.17,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          labelPadding: EdgeInsets.symmetric(horizontal: 36.0),
                          indicatorColor: Colors.black,
                          labelColor: Colors.black,
                          indicatorPadding: const EdgeInsets.only(top: 8.0),
                          unselectedLabelColor: Colors.grey,
                          unselectedLabelStyle: Theme.of(context).textTheme.headline6,
                          labelStyle: Theme.of(context).textTheme.headline5.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
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
                        Expanded(
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: _assessmentLandingScreenTabController,
                            children: [
                              MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (BuildContext context) => ObjectiveBloc()
                                      ..add(
                                        GetObjectiveTests(),
                                      ),
                                  ),
                                  BlocProvider(
                                    create: (BuildContext context) => CoursesBloc()
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
                                    create: (BuildContext context) => SubjectiveBloc()
                                      ..add(
                                        GetSubjectiveTests(),
                                      ),
                                  ),
                                  BlocProvider(
                                    create: (BuildContext context) => CoursesBloc()
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
                                    create: (BuildContext context) => ConductedBloc()
                                      ..add(
                                        GetObjectiveQuestions(),
                                      ),
                                  ),
                                  BlocProvider(
                                    create: (BuildContext context) => CoursesBloc()
                                      ..add(
                                        GetSectionsAndGetCoursesList(),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* no-op */
  _showAlertDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Create a New Assignment',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height / 40),
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
                        builder: (BuildContext context) => CreateAssessmentScreen(QuestionType.Objective),
                      ),
                    ),
                  ),
                  ListTile(
                    trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text('Subjective'),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => CreateAssessmentScreen(QuestionType.Subjective),
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
