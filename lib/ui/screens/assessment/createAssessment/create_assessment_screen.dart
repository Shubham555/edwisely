import 'package:edwisely/data/blocs/assessmentLandingScreen/addQuestionScreen/add_question_bloc.dart';
import 'package:edwisely/data/blocs/assessmentLandingScreen/coursesBloc/courses_bloc.dart';
import 'package:edwisely/data/blocs/assessmentLandingScreen/objectiveBloc/objective_bloc.dart';
import 'package:edwisely/data/blocs/assessmentLandingScreen/subjectiveBloc/subjective_bloc.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/add_questions_screen.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAssessmentScreen extends StatelessWidget {
  final QuestionType _questionType;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _selectedCourseId;

  CreateAssessmentScreen(this._questionType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: //<editor-fold desc="White AppBar Need to Create a stless when confirmed for use// ">
          AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 3,
        backgroundColor: Colors.white,
        title: Text(
          'Logo here',
          style: TextStyle(color: Colors.black),
        ),
      ),
      //</editor-fold>
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
                      builder: (BuildContext context) => BlocProvider(
                        create: (BuildContext context) => AddQuestionBloc(),
                        child: AddQuestionsScreen(
                          _titleController.text,
                          _descriptionController.text,
                          10,
                          _questionType,
                          state.assessmentId,
                        ),
                      ),
                    ),
                  );
                }
                if (state is ObjectiveFailed) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Creation of Assessment Failed. PLease try again'),
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
                      builder: (BuildContext context) => BlocProvider(
                        create: (BuildContext context) => AddQuestionBloc(),
                        child: AddQuestionsScreen(
                          _titleController.text,
                          _descriptionController.text,
                          10,
                          _questionType,
                          state.assessmentId,
                        ),
                      ),
                    ),
                  );
                }
                if (state is SubjectiveFailed) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Creation of Assessment Failed. Please try again'),
                    ),
                  );
                }
              },
            ),
          ],
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Create new ${_questionType == QuestionType.Objective ? 'Objective' : 'Subjective'} Assessment',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 50),
                  ),
                  _buildTextFieldWidget('Add Title', 80, _titleController),
                  _buildTextFieldWidget(
                      'Description', 200, _descriptionController),
                  Text(
                    'Choose Subject',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 50),
                  ),
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
                        return Wrap(
                          spacing: 20,
                          children: List.generate(
                            state.coursesEntity.data.length + 1,
                            (index) {
                              if (index < state.coursesEntity.data.length) {
                                return _createCourseCard(
                                    state.coursesEntity.data[index].name, () {
                                  _selectedCourseId =
                                      state.coursesEntity.data[index].id;
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Selected ${state.coursesEntity.data[index].name}'),
                                    ),
                                  );
                                });
                              } else {
                                return _createCourseCard('Add Subject', null);
                              }
                            },
                          ),
                        );
                      }
                    },
                  ),
                  RaisedButton(
                    disabledColor: Colors.grey,
                    disabledElevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Color(0xFF1D2B64),
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => _continueButtonOnPressed(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildTextFieldWidget(
          String title, int maxLength, TextEditingController controller) =>
      Column(
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: title,
              border: OutlineInputBorder(),
            ),
            maxLength: maxLength,
          ),
        ],
      );

  _createCourseCard(String text, Function onPressed) => FlatButton(
        hoverColor: Color(0xFF1D2B64).withOpacity(.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            color: Color(0xFF1D2B64),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
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
      );

  void _continueButtonOnPressed(BuildContext context) {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedCourseId == null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please double check the entries !'),
        ),
      );
      return null;
    } else if (_questionType == QuestionType.Objective) {
      BlocProvider.of<ObjectiveBloc>(context).add(
        CreateObjectiveQuestionnaire(
          _titleController.text,
          _descriptionController.text,
          _selectedCourseId,
        ),
      );
    } else {
      BlocProvider.of<SubjectiveBloc>(context).add(
        CreateSubjectiveQuestionnaire(
          _titleController.text,
          _descriptionController.text,
          _selectedCourseId,
        ),
      );
    }
  }
}
