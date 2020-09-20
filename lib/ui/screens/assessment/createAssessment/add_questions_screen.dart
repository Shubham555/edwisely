import 'package:edwisely/data/blocs/addQuestionScreen/add_question_bloc.dart';
import 'package:edwisely/data/model/add_question/typed_objective_questions.dart';
import 'package:edwisely/data/model/add_question/typed_subjective_questions.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/choose_from_selected_tab.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/type_question_tab.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/upload_excel_tab.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../widgets_util/side_drawer_item.dart';

class AddQuestionsScreen extends StatefulWidget {
  final String _title;
  final String _description;
  final int _subjectId;
  final QuestionType _questionType;
  final int _assessmentId;

  AddQuestionsScreen(
    this._title,
    this._description,
    this._subjectId,
    this._questionType,
    this._assessmentId,
  );

  @override
  _AddQuestionsScreenState createState() => _AddQuestionsScreenState();
}

class _AddQuestionsScreenState extends State<AddQuestionsScreen>
    with SingleTickerProviderStateMixin {
  TabController _questionController;

  Size screenSize;
  TextTheme textTheme;

  bool _isSideDrawerCollapsed = true;

  @override
  void initState() {
    _questionController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;

    return MultiProvider(
      providers: [
        Provider(create: (context) => TypedObjectiveQuestionProvider()),
        Provider(create: (context) => TypedSubjectiveQuestionProvider()),
      ],
      child: Scaffold(
          appBar: BigAppBar(
            actions: [],
            bottomTab: null,
            appBarSize: MediaQuery.of(context).size.height / 3.5,
            appBarTitle: Text(
              'Edwisely',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            flatButton: FlatButton(
              onPressed: () => null,
              child: Text('Save'),
            ),
            titleText: 'Add Questions to ${widget._title} Assessment',
          ).build(context),
          body: Row(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutBack,
                width: _isSideDrawerCollapsed
                    ? screenSize.width * 0.05
                    : screenSize.width * 0.15,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SideDrawerItem(
                      isCollapsed: _isSideDrawerCollapsed,
                      title: 'Send Notification',
                      icon: Icons.notifications_active,
                    ),
                    SideDrawerItem(
                      isCollapsed: _isSideDrawerCollapsed,
                      title: 'Get Feedback',
                      icon: Icons.feedback,
                    ),
                    SideDrawerItem(
                      isCollapsed: _isSideDrawerCollapsed,
                      title: 'Conduct Live Class',
                      icon: Icons.live_tv,
                    ),
                    SideDrawerItem(
                        isCollapsed: _isSideDrawerCollapsed,
                        title: 'Conduct Live Assesment',
                        icon: Icons.assessment),
                    SideDrawerItem(
                      isCollapsed: _isSideDrawerCollapsed,
                      title: 'Send Assignment',
                      icon: Icons.assignment,
                    ),
                    SideDrawerItem(
                      isCollapsed: _isSideDrawerCollapsed,
                      title: 'Schedule Event',
                      icon: Icons.calendar_today,
                    ),
                    SideDrawerItem(
                      isCollapsed: _isSideDrawerCollapsed,
                      title: 'My Assesment',
                      icon: Icons.assignment_ind,
                    ),
                    SideDrawerItem(
                      isCollapsed: _isSideDrawerCollapsed,
                      title: 'Add Course Material',
                      icon: Icons.add,
                    ),
                    SideDrawerItem(
                      isCollapsed: _isSideDrawerCollapsed,
                      title: 'Upcoming Events',
                      icon: Icons.event,
                    ),
                    SideDrawerItem(
                      isCollapsed: _isSideDrawerCollapsed,
                      title: 'Recently Viewed',
                      icon: Icons.schedule,
                    ),
                    //collapse controller
                    IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      icon: Icon(
                        _isSideDrawerCollapsed
                            ? Icons.arrow_forward_ios
                            : Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onPressed: () => setState(() =>
                          _isSideDrawerCollapsed = !_isSideDrawerCollapsed),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 5,
                color: Colors.grey.withOpacity(.5),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      'Create Questions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 40,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => BlocProvider(
                                  create: (BuildContext context) =>
                                      AddQuestionBloc(),
                                  child: TypeQuestionTab(
                                      widget._title,
                                      widget._description,
                                      widget._subjectId,
                                      widget._questionType,
                                      widget._assessmentId),
                                ),
                              ),
                            ),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_circle_outline,
                                      size: 45,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text('Add Questions')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 150,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => BlocProvider(
                                  create: (BuildContext context) =>
                                      AddQuestionBloc(),
                                  child: UploadExcelTab(),
                                ),
                              ),
                            ),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload_file,
                                      size: 45,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text('Upload Questions')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 150,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => BlocProvider(
                                  create: (BuildContext context) =>
                                      AddQuestionBloc(),
                                  child: ChooseFromSelectedTab(
                                      widget._title,
                                      widget._description,
                                      widget._subjectId,
                                      widget._questionType,
                                      widget._assessmentId),
                                ),
                              ),
                            ),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.handyman,
                                      size: 45,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text('Choose from Question Bank')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
