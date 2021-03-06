import 'package:edwisely/data/blocs/objectiveBloc/objective_bloc.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/upload_excel_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../data/cubits/objective_questions_cubit.dart';
import '../../../../data/provider/selected_page.dart';
import '../../../../util/enums/question_type_enum.dart';
import '../../../widgets_util/big_app_bar.dart';
import '../../../widgets_util/navigation_drawer.dart';
import '../../this_way_up.dart';
import 'choose_objective_from_selected_tab.dart';
import 'choose_subjective_from_selected_tab.dart';
import 'type_question_tab.dart';

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
  final _questionFetchCubit = QuestionsCubit();
  Size screenSize;
  TextTheme textTheme;
  List<int> questions = [];

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;
    return oneWay(context)
        ? ThisWayUp()
        : Scaffold(
            body: Row(
              children: [
                NavigationDrawer(
                  isCollapsed: true,
                  key: context.watch<SelectedPageProvider>().navigatorKey,
                ),
                Expanded(
                  child: Column(
                    children: [
                      BigAppBar(
                        actions: [],
                        bottomTab: null,
                        appBarSize: MediaQuery.of(context).size.height * 0.3,
                        appBarTitle: Text(
                          'Edwisely',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        route: 'Home > Add Questions',
                        flatButton: RaisedButton(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          onPressed: () {
                            context.bloc<ObjectiveBloc>().add(
                                  GetObjectiveTests(),
                                 );
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icons/save.png',
                                color: Colors.white,
                                height: 24.0,
                              ),
                              SizedBox(width: 8.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Save',
                                  style: Theme.of(context).textTheme.button,
                                ),
                              ),
                            ],
                          ),
                        ),
                        titleText: '${widget._title}',
                      ).build(context),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.17),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Container(
                            //   width: MediaQuery.of(context).size.width / 6,
                            //   height: MediaQuery.of(context).size.height * 0.7,
                            //   color: Colors.grey.shade500,
                            //   child: BlocBuilder(
                            //     cubit: _questionFetchCubit
                            //       ..getQuestionsToAnAssessment(
                            //         widget._assessmentId,
                            //       ),
                            //     builder: (BuildContext context, state) {
                            //       if (state is QuestionsToAnAssessmentFetched) {
                            //         state.assessmentQuestionsEntity.data.forEach((element) {
                            //           questions.add(element.id);
                            //         });
                            //         return ListView.builder(
                            //           itemCount: state.assessmentQuestionsEntity.data.length,
                            //           itemBuilder: (BuildContext context, int index) => Card(
                            //             child: ListTile(
                            //               title: Row(
                            //                 children: [
                            //                   Text('Q ${index + 1}   '),
                            //                   Expanded(
                            //                     child: Text(
                            //                       state.assessmentQuestionsEntity.data[index].name,
                            //                       // overflow: TextOverflow.ellipsis,
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //         );
                            //       }
                            //       if (state is QuestionsToAnAssessmentEmpty) {
                            //         return Center(
                            //           child: Text('Add Questions to this Assessment'),
                            //         );
                            //       } else {
                            //         return Center(
                            //           child: CircularProgressIndicator(),
                            //         );
                            //       }
                            //     },
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Create Questions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              40,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Visibility(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          height: 150,
                                          margin: const EdgeInsets.only(
                                              right: 22.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 6.0,
                                              ),
                                            ],
                                          ),
                                          child: GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    TypeQuestionTab(
                                                        widget._title,
                                                        widget._description,
                                                        widget._subjectId,
                                                        widget._questionType,
                                                        widget._assessmentId,
                                                        false),
                                              ),
                                            ).then((value) =>
                                                _questionFetchCubit
                                                    .getQuestionsToAnAssessment(
                                                        widget._assessmentId)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/icons/add.png',
                                                    height: 48.0,
                                                    width: 48.0,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    'Add Questions',
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        visible: widget._questionType ==
                                            QuestionType.Objective,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                UploadExcelTab(),
                                          ),
                                        ).then((value) => _questionFetchCubit
                                            .getQuestionsToAnAssessment(
                                                widget._assessmentId)),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          height: 150,
                                          margin: const EdgeInsets.only(
                                              right: 22.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 6.0,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/icons/upload_black.png',
                                                  height: 48.0,
                                                  width: 48.0,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  'Upload Questions',
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          height: 150,
                                          margin: const EdgeInsets.only(
                                              right: 22.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 6.0,
                                              ),
                                            ],
                                          ),
                                          child: GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    ChooseObjectiveFromSelectedTab(
                                                        widget._title,
                                                        widget._description,
                                                        widget._subjectId,
                                                        widget._questionType,
                                                        widget._assessmentId),
                                              ),
                                            ).then((value) =>
                                                _questionFetchCubit
                                                    .getQuestionsToAnAssessment(
                                                        widget._assessmentId)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/icons/question_bank.png',
                                                    height: 48.0,
                                                    width: 48.0,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    'Choose from Question Bank',
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        visible: widget._questionType ==
                                            QuestionType.Objective,
                                      ),
                                      Visibility(
                                        child: Container(
                                          width: 150,
                                          height: 150,
                                          child: Container(
                                            width: 150,
                                            height: 150,
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      ChooseSubjectiveFromSelectedTab(
                                                    widget._title,
                                                    widget._description,
                                                    widget._subjectId,
                                                    widget._questionType,
                                                    widget._assessmentId,
                                                  ),
                                                ),
                                              ).then((value) =>
                                                  _questionFetchCubit
                                                      .getQuestionsToAnAssessment(
                                                          widget
                                                              ._assessmentId)),
                                              child: Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.handyman,
                                                        size: 45,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        'Choose from Question Bank',
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        visible: widget._questionType ==
                                            QuestionType.Subjective,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
