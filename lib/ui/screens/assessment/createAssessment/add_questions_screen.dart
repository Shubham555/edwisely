import 'package:edwisely/data/blocs/assessmentLandingScreen/addQuestionScreen/add_question_bloc.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/choose_from_selected_tab.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/type_question_tab.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/upload_excel_tab.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    _questionController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                child: TypeQuestionTab(),
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
                                child: ChooseFromSelectedTab(),
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
        ));
  }
}
