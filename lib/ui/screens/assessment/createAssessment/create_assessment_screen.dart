import 'package:edwisely/data/blocs/assessmentLandingScreen/objectiveBloc/objective_bloc.dart';
import 'package:edwisely/data/blocs/assessmentLandingScreen/subjectiveBloc/subjective_bloc.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/add_questions_screen.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAssessmentScreen extends StatefulWidget {
  final QuestionType _questionType;

  CreateAssessmentScreen(this._questionType);

  @override
  _CreateAssessmentScreenState createState() => _CreateAssessmentScreenState();
}

class _CreateAssessmentScreenState extends State<CreateAssessmentScreen> {
  bool _isExistingCoursesElected = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

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
                      builder: (BuildContext context) => AddQuestionsScreen(
                        _titleController.text,
                        _descriptionController.text,
                        10,
                        widget._questionType,
                        state.assessmentId,
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
                      builder: (BuildContext context) => AddQuestionsScreen(
                        _titleController.text,
                        _descriptionController.text,
                        10,
                        widget._questionType,
                          state.assessmentId,
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
                    'Create new ${widget._questionType == QuestionType.Objective ? 'Objective' : 'Subjective'} Assessment',
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
                  Row(
                    children: [
                      _createCourseCard(
                        'Existing Courses',
                        () {
                          setState(
                            () {
                              _isExistingCoursesElected =
                                  !_isExistingCoursesElected;
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      _createCourseCard(
                        'Other Subjects',
                        () => null,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _isExistingCoursesElected,
                    child: Row(
                      children: [
                        _createCourseCard(
                          'Custom Create subject',
                          () => null,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        _createCourseCard(
                          'Choose from Edwisely Subjects',
                          () => null,
                        ),
                      ],
                    ),
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
    //todo add subject check
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
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
          10,
        ),
      );
    } else {
      BlocProvider.of<SubjectiveBloc>(context).add(
        CreateSubjectiveQuestionnaire(
          _titleController.text,
          _descriptionController.text,
          10,
        ),
      );
    }
  }
}
