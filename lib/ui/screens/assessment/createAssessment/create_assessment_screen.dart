import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:edwisely/ui/widgets_util/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

import '../../../../data/blocs/coursesBloc/courses_bloc.dart';
import '../../../../data/blocs/objectiveBloc/objective_bloc.dart';
import '../../../../data/blocs/subjectiveBloc/subjective_bloc.dart';
import '../../../../data/model/course/coursesEntity/data.dart';
import '../../../../data/provider/selected_page.dart';
import '../../../../util/enums/question_type_enum.dart';
import '../../../widgets_util/navigation_drawer.dart';
import 'add_questions_screen.dart';

class CreateAssessmentScreen extends StatefulWidget {
  final QuestionType _questionType;

  CreateAssessmentScreen(this._questionType);

  @override
  _CreateAssessmentScreenState createState() => _CreateAssessmentScreenState();
}

class _CreateAssessmentScreenState extends State<CreateAssessmentScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  int selectedCouerse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => MultiBlocListener(
          listeners: [
            BlocListener(
              cubit: context.bloc<ObjectiveBloc>(),
              listener: (BuildContext context, state) {
                if (state is ObjectiveAssessmentCreated) {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AddQuestionsScreen(
                        _titleController.text,
                        _descriptionController.text,
                        selectedCouerse,
                        widget._questionType,
                        state.assessmentId,
                      ),
                    ),
                  );
                }
                if (state is ObjectiveFailed) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Creation of Assessment Failed. PLease try again'),
                    ),
                  );
                }
              },
            ),
            BlocListener(
              cubit: context.bloc<SubjectiveBloc>(),
              listener: (BuildContext context, state) {
                if (state is SubjectiveAssessmentCreated) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AddQuestionsScreen(
                        _titleController.text,
                        _descriptionController.text,
                        selectedCouerse,
                        widget._questionType,
                        state.assessmentId,
                      ),
                    ),
                  );
                }
                if (state is SubjectiveFailed) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Creation of Assessment Failed. Please try again'),
                    ),
                  );
                }
              },
            ),
          ],
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              NavigationDrawer(
                isCollapsed: true,
                key: context.watch<SelectedPageProvider>().navigatorKey,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigAppBar(
                      actions: [],
                      titleText:
                          'Create new ${widget._questionType == QuestionType.Objective ? 'Objective' : 'Subjective'} Assessment',
                      bottomTab: null,
                      appBarSize: MediaQuery.of(context).size.height / 3,
                      appBarTitle: Text(
                        'Create Assesment',
                      ),
                      flatButton: RaisedButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        onPressed: () => _continueButtonOnPressed(context),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/save.png',
                              color: Colors.white,
                              height: 24.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Continue',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ],
                        ),
                      ),
                      route: 'Home > Assesments > Create Assesment',
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: MediaQuery.of(context).size.width * 0.27,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextFieldWidget('Add Title', 80, _titleController),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          _buildTextFieldWidget('Description', 200, _descriptionController),
                          // Text(
                          //   'Choose Subject',
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: MediaQuery.of(context).size.width / 50),
                          // ),
                          BlocBuilder(
                            cubit: context.bloc<CoursesBloc>()
                              ..add(
                                GetCoursesByFaculty(),
                              ),
                            // ignore: missing_return
                            builder: (BuildContext context, state) {
                              if (state is CoursesInitial) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is CoursesFetchFailed) {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('There is some server error please retry'),
                                    RaisedButton(
                                      color: Color(0xFF1D2B64).withOpacity(.3),
                                      onPressed: () => context.bloc<CoursesBloc>().add(
                                            GetCoursesByFaculty(),
                                          ),
                                      child: Text('Retry'),
                                    )
                                  ],
                                );
                              }
                              if (state is CoursesFetched) {
                                return SmartSelect.single(
                                  title: 'Subjects',
                                  placeholder: 'Select a Subject',
                                  value: selectedCouerse,
                                  choiceItems: S2Choice.listFrom(
                                    source: state.coursesEntity.data,
                                    value: (index, Data item) => item.id,
                                    title: (index, Data item) => item.name,
                                    group: (index, Data item) => '',
                                  ),
                                  modalTitle: 'Choose Subject',
                                  modalType: S2ModalType.popupDialog,
                                  choiceType: S2ChoiceType.chips,
                                  choiceStyle: S2ChoiceStyle(
                                    showCheckmark: true,
                                  ),
                                  choiceLayout: S2ChoiceLayout.wrap,
                                  onChange: (state) => setState(() {
                                    selectedCouerse = state.value;

                                  }),
                                  tileBuilder: (context, state) => S2Tile.fromState(
                                    state,
                                    isTwoLine: true,
                                    leading: Container(
                                      width: 40,
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.subject),
                                    ),
                                  ),
                                );
                              }
                            },
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
      ),
    );
  }

  _buildTextFieldWidget(
    String title,
    int maxLength,
    TextEditingController controller,
  ) =>
      TextInput(
        controller: controller,
        label: title,
        hint: '',
        maxLength: maxLength,
        inputType: TextInputType.text,
        autofocus: true,
        validator: (String value) {
          if (value.trim().length == 0) {
            return 'This field cannot be empty!';
          }
          return null;
        },
      );

  void _continueButtonOnPressed(BuildContext context) {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        selectedCouerse == null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please double check the entries !'),
        ),
      );
      return null;
    } else if (widget._questionType == QuestionType.Objective) {
      BlocProvider.of<ObjectiveBloc>(context).add(
        CreateObjectiveQuestionnaire(
          _titleController.text,
          _descriptionController.text,
          selectedCouerse,
        ),
      );
    } else {
      BlocProvider.of<SubjectiveBloc>(context).add(
        CreateSubjectiveQuestionnaire(
          _titleController.text,
          _descriptionController.text,
          selectedCouerse,
        ),
      );
    }
  }
}
