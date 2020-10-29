import 'dart:convert';

import 'package:edwisely/data/cubits/question_add_cubit.dart';
import 'package:edwisely/data/model/assessment/assessmentQuestions/data.dart'
    as assesmentData;
import 'package:edwisely/ui/widgets_util/my_checkbox.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

import '../../../../data/cubits/add_question_cubit.dart';
import '../../../../data/cubits/objective_questions_cubit.dart';
import '../../../../data/cubits/topic_cubit.dart';
import '../../../../data/model/add_question/typed_objective_questions.dart';
import '../../../../data/model/questionBank/topicEntity/data.dart';
import '../../../../data/provider/selected_page.dart';
import '../../../../util/enums/question_type_enum.dart';
import '../../../widgets_util/big_app_bar_add_questions.dart';
import '../../../widgets_util/navigation_drawer.dart';

class TypeQuestionTab extends StatefulWidget {
  final String _title;
  final String _description;
  final int _subjectId;
  final QuestionType _questionType;
  final int _assessmentId;
  final bool isFromQuestionBank;
  assesmentData.Data data;
  TypedObjectiveQuestionProvider newQues;

  int _bloomValue = 1;
  int quesCounter = 0;
  bool option5Selected = false;

  TypeQuestionTab(this._title, this._description, this._subjectId,
      this._questionType, this._assessmentId, this.isFromQuestionBank,
      {this.data});

  @override
  _TypeQuestionTabState createState() => _TypeQuestionTabState();
}

class _TypeQuestionTabState extends State<TypeQuestionTab> {
  TextEditingController _questionController = TextEditingController();
  TextEditingController _fillInTheBlanksController = TextEditingController();
  TextEditingController _option1Controller = TextEditingController();
  TextEditingController _option2Controller = TextEditingController();
  TextEditingController _option3Controller = TextEditingController();
  TextEditingController _option4Controller = TextEditingController();
  TextEditingController _option5Controller = TextEditingController();
  TextEditingController _hintController = TextEditingController();
  TextEditingController _solutionController = TextEditingController();
  TextEditingController _sourceController = TextEditingController();
  bool isPublic = true;

  int _correctAnswer = 1;

  //focus nodes
  FocusNode _option1Node;
  FocusNode _option2Node;
  FocusNode _option3Node;
  FocusNode _option4Node;
  FocusNode _option5Node;

  FilePickerCross _questionImage;
  String _question = '';
  FilePickerCross _option1Image;
  String _option1 = '';
  FilePickerCross _option2Image;
  String _option2 = '';
  FilePickerCross _option3Image;
  String _option3 = '';
  FilePickerCross _option4Image;
  String _option4 = '';
  FilePickerCross _option5Image;
  String _option5 = '';
  FilePickerCross _hintImage;
  String _hint = '';
  FilePickerCross _solutionImage;
  String _solution = '';

  bool _showHint = false;
  bool _showSolution = false;

  int _currentQuestionId;

  Future getImage(Function setState) async {
    final pickedFile =
        await FilePickerCross.importFromStorage(type: FileTypeCross.any);
    _question = pickedFile.toBase64();

    setState(() {
      _questionImage = pickedFile;
    });
  }

  Future getHintImage(Function setState) async {
    final pickedFile =
        await FilePickerCross.importFromStorage(type: FileTypeCross.any);
    _hint = pickedFile.toBase64();

    setState(() {
      _hintImage = pickedFile;
    });
  }

  Future getSolutionImage(Function setState) async {
    final pickedFile =
        await FilePickerCross.importFromStorage(type: FileTypeCross.any);
    _solution = pickedFile.toBase64();

    setState(() {
      _solutionImage = pickedFile;
    });
  }

  Future getOptionImage(int opt) async {
    final pickedFile =
        await FilePickerCross.importFromStorage(type: FileTypeCross.any);

    setState(() {
      switch (opt) {
        case 1:
          _option1Image = pickedFile;
          _option1 = pickedFile.toBase64();
          break;
        case 2:
          _option2Image = pickedFile;
          _option2 = pickedFile.toBase64();
          break;
        case 3:
          _option3Image = pickedFile;
          _option3 = pickedFile.toBase64();
          break;
        case 4:
          _option4Image = pickedFile;
          _option4 = pickedFile.toBase64();
          break;
        case 5:
          _option5Image = pickedFile;
          _option5 = pickedFile.toBase64();
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _option1Node = FocusNode();
    _option2Node = FocusNode();
    _option3Node = FocusNode();
    _option4Node = FocusNode();
    _option5Node = FocusNode();

    //initialize data
    if (widget.data != null) {
      _questionController.text = widget.data.name;
      _option1Controller.text = widget.data.questions_options[0].name;
      _option2Controller.text = widget.data.questions_options[1].name;
      _option3Controller.text = widget.data.questions_options[2].name;
      _option4Controller.text = widget.data.questions_options[3].name;
      _hintController.text = widget.data.hint;
      _solutionController.text = widget.data.solution;
    }
  }

  @override
  void dispose() {
    super.dispose();

    _questionController.dispose();
    _fillInTheBlanksController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
    _option5Controller.dispose();

    _option1Node.dispose();
    _option2Node.dispose();
    _option3Node.dispose();
    _option4Node.dispose();
    _option5Node.dispose();
  }

  List<Map<String, dynamic>> topics = [];
  final _questionFetchCubit = QuestionsCubit();
  List<int> questions = [];
  int difficultylevel = 1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Row(
          children: [
            NavigationDrawer(
              isCollapsed: true,
              key: context.watch<SelectedPageProvider>().navigatorKey,
            ),
            Expanded(
              child: Column(
                children: [
                  BigAppBarAddQuestionScreen(
                    route: 'Home > Add Question > Add Objective Question',
                    actions: [],
                    appBarSize: MediaQuery.of(context).size.height / 5.5,
                    appBarTitle: Text(
                      'Edwisely',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    flatButton: RaisedButton(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/save.png',
                            color: Colors.white,
                            height: 24.0,
                          ),
                          SizedBox(width: 8.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Save',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ],
                      ),
                    ),
                    titleText: 'Type Questions to ${widget._title} Assessment',
                    description: "${widget._description}",
                    subject: "Subject: ${widget._subjectId}",
                  ).build(context),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.height * 0.8,
                          margin: const EdgeInsets.only(
                            top: 12.0,
                            left: 12.0,
                            bottom: 12.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: StatefulBuilder(
                            builder: (BuildContext context,
                                void Function(void Function()) innerSetState) {
                              return BlocBuilder(
                                cubit: _questionFetchCubit
                                  ..getQuestionsToAnAssessment(
                                    widget._assessmentId,
                                  ),
                                builder: (BuildContext context, state) {
                                  if (state is QuestionsToAnAssessmentFetched) {
                                    state.assessmentQuestionsEntity.data
                                        .forEach(
                                      (element) {
                                        questions.add(
                                          element.id,
                                        );
                                      },
                                    );

                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          void Function(void Function())
                                              innerSetState2) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: state
                                              .assessmentQuestionsEntity
                                              .data
                                              .length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 4.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              child: ListTile(
                                                tileColor: Colors.grey[200],
                                                onTap: () {
                                                  _currentQuestionId = state
                                                      .assessmentQuestionsEntity
                                                      .data[index]
                                                      .id;
                                                  _questionController.text = state
                                                      .assessmentQuestionsEntity
                                                      .data[index]
                                                      .name;
                                                  _option1Controller.text = state
                                                      .assessmentQuestionsEntity
                                                      .data[index]
                                                      .questions_options[0]
                                                      .name;
                                                  _option2Controller.text = state
                                                      .assessmentQuestionsEntity
                                                      .data[index]
                                                      .questions_options[1]
                                                      .name;
                                                  _option3Controller.text = state
                                                      .assessmentQuestionsEntity
                                                      .data[index]
                                                      .questions_options[2]
                                                      .name;
                                                  _option4Controller.text = state
                                                      .assessmentQuestionsEntity
                                                      .data[index]
                                                      .questions_options[3]
                                                      .name;
                                                  _hintController.text = state
                                                      .assessmentQuestionsEntity
                                                      .data[index]
                                                      .hint;
                                                  _solutionController.text = state
                                                      .assessmentQuestionsEntity
                                                      .data[index]
                                                      .solution;
                                                  setState(() {});
                                                },
                                                leading: Text(
                                                  'Q ${index + 1}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6,
                                                ),
                                                title: Text(
                                                  state
                                                      .assessmentQuestionsEntity
                                                      .data[index]
                                                      .name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .copyWith(fontSize: 14.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  if (state is QuestionsToAnAssessmentEmpty) {
                                    return Center(
                                      child: Text(
                                          'Add Questions to this Assessment'),
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            return Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 18.0,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32.0,
                                  vertical: height * 0.02,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(12),
                                        padding: const EdgeInsets.only(
                                            top: 14.0, bottom: 14.0),
                                        height: height * 0.17,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: TextField(
                                                maxLines: 4,
                                                controller: _questionController,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 24.0,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "Click to start typing your question",
                                                  hintStyle: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey,
                                                  ),
                                                  border: InputBorder.none,
                                                  fillColor: Colors.grey[200],
                                                  filled: true,
                                                ),
                                              ),
                                            ),
                                            _questionImage == null
                                                ? Center(
                                                    child: Container(
                                                      height: height * 0.15,
                                                      width: width * 0.15,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                        color: Colors.grey[100],
                                                      ),
                                                      margin:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: FlatButton(
                                                        onPressed: () =>
                                                            getImage(setState),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      18.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/icons/upload_image.png',
                                                                  height:
                                                                      height *
                                                                          0.03,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Upload Image',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Center(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.memory(
                                                          base64Decode(
                                                              _question),
                                                          height: height * 0.15,
                                                          width: height * 0.15,
                                                          fit: BoxFit.contain,
                                                        ),
                                                        SizedBox(
                                                          width: 18.0,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            FlatButton.icon(
                                                              color: Colors
                                                                  .grey[200],
                                                              onPressed: () =>
                                                                  getImage(
                                                                      setState),
                                                              icon: Icon(
                                                                Icons.edit,
                                                              ),
                                                              label:
                                                                  Text('Edit'),
                                                            ),
                                                            FlatButton.icon(
                                                              color: Colors
                                                                  .grey[200],
                                                              onPressed: () =>
                                                                  setState(() {
                                                                _questionImage =
                                                                    null;
                                                                _question = '';
                                                              }),
                                                              icon: Icon(
                                                                Icons.delete,
                                                              ),
                                                              label: Text(
                                                                  'Delete'),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text('Bloom'),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                DropdownButton(
                                                    value: widget._bloomValue,
                                                    items: [
                                                      DropdownMenuItem(
                                                        child: Text('Remember'),
                                                        value: 1,
                                                      ),
                                                      DropdownMenuItem(
                                                        child:
                                                            Text('Understand'),
                                                        value: 2,
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Apply'),
                                                        value: 3,
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Analyze'),
                                                        value: 4,
                                                      ),
                                                    ],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        widget._bloomValue =
                                                            value;
                                                      });
                                                    }),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Difficulty'),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                DropdownButton(
                                                    value: difficultylevel,
                                                    items: [
                                                      DropdownMenuItem(
                                                        child: Text('Level 1'),
                                                        value: 1,
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Level 2'),
                                                        value: 2,
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Level 3'),
                                                        value: 3,
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Level 4'),
                                                        value: 4,
                                                      ),
                                                      DropdownMenuItem(
                                                        child: Text('Level 5'),
                                                        value: 5,
                                                      ),
                                                    ],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        difficultylevel = value;
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: height * 0.02),
                                      StatefulBuilder(
                                          builder: (context, setState) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: height * 0.12,
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: Container(
                                                      child: OptionField(
                                                        myValue: 0,
                                                        groupValue:
                                                            _correctAnswer,
                                                        myFocusNode:
                                                            _option1Node,
                                                        onChanged: (int
                                                                value) =>
                                                            setState(() =>
                                                                _correctAnswer =
                                                                    value),
                                                        // onTap: (String value) => setState(() => _option1Controller.text = value),
                                                        onTap: (String value) =>
                                                            _option1Controller
                                                                .text = value,
                                                        optionImagePicker: () =>
                                                            getOptionImage(1),
                                                        deletePickedImage: () =>
                                                            setState(() {
                                                          _option1Image = null;
                                                          _option1 = '';
                                                        }),
                                                        image: _option1,
                                                        color:
                                                            Color(0xFFC04DD8),
                                                        label: 'Enter Option',
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: Container(
                                                      child: OptionField(
                                                        myValue: 1,
                                                        groupValue:
                                                            _correctAnswer,
                                                        myFocusNode:
                                                            _option2Node,
                                                        onChanged: (int
                                                                value) =>
                                                            setState(() =>
                                                                _correctAnswer =
                                                                    value),
                                                        // onTap: (String value) => setState(() => _option2Controller.text = value),
                                                        onTap: (String value) =>
                                                            _option2Controller
                                                                .text = value,
                                                        optionImagePicker: () =>
                                                            getOptionImage(2),
                                                        deletePickedImage: () =>
                                                            setState(() {
                                                          _option2Image = null;
                                                          _option2 = '';
                                                        }),
                                                        image: _option2,
                                                        color:
                                                            Color(0xFF4FB277),
                                                        label: 'Enter Option',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.12,
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: Container(
                                                      child: OptionField(
                                                        myValue: 2,
                                                        groupValue:
                                                            _correctAnswer,
                                                        myFocusNode:
                                                            _option3Node,
                                                        onChanged: (int
                                                                value) =>
                                                            setState(() =>
                                                                _correctAnswer =
                                                                    value),
                                                        // onTap: (String value) => setState(() => _option3Controller.text = value),
                                                        onTap: (String value) =>
                                                            _option3Controller
                                                                .text = value,
                                                        optionImagePicker: () =>
                                                            getOptionImage(3),
                                                        image: _option3,
                                                        deletePickedImage: () =>
                                                            setState(() {
                                                          _option3Image = null;
                                                          _option3 = '';
                                                        }),
                                                        color:
                                                            Color(0xFF508AE0),
                                                        label:
                                                            'Enter Option(Optional)',
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: Container(
                                                      child: OptionField(
                                                        myValue: 3,
                                                        groupValue:
                                                            _correctAnswer,
                                                        myFocusNode:
                                                            _option4Node,
                                                        onChanged: (int
                                                                value) =>
                                                            setState(() =>
                                                                _correctAnswer =
                                                                    value),
                                                        // onTap: (String value) => setState(() => _option4Controller.text = value),
                                                        onTap: (String value) =>
                                                            _option4Controller
                                                                .text = value,
                                                        optionImagePicker: () =>
                                                            getOptionImage(4),
                                                        image: _option4,
                                                        deletePickedImage: () =>
                                                            setState(() {
                                                          _option4Image = null;
                                                          _option4 = '';
                                                        }),
                                                        color:
                                                            Color(0xFF4ED8DA),
                                                        label:
                                                            'Enter Option(Optional)',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            widget.option5Selected
                                                ? Container(
                                                    height: height * 0.118,
                                                    width: width * 0.292,
                                                    child: OptionField(
                                                      myValue: 4,
                                                      groupValue:
                                                          _correctAnswer,
                                                      myFocusNode: _option5Node,
                                                      onChanged: (int value) =>
                                                          setState(() =>
                                                              _correctAnswer =
                                                                  value),
                                                      // onTap: (String value) => setState(() => _option3Controller.text = value),
                                                      onTap: (String value) =>
                                                          _option5Controller
                                                              .text = value,
                                                      optionImagePicker: () =>
                                                          getOptionImage(5),
                                                      image: _option5,
                                                      deletePickedImage: () =>
                                                          setState(() {
                                                        _option5Image = null;
                                                        _option5 = '';
                                                      }),
                                                      color: Color(0xFFff6b6b),
                                                      label:
                                                          'Enter Option(Optional)',
                                                    ),
                                                  )
                                                : InkWell(
                                                    onTap: () => setState(() =>
                                                        widget.option5Selected =
                                                            true),
                                                    child: Container(
                                                      // height: height * 0.118,
                                                      width: width * 0.12,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 14.0,
                                                          vertical: 4.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        color:
                                                            Color(0xFFff6b6b),
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 12.0,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Add Option',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        );
                                      }),
                                      _showHint
                                          ? Container(
                                              margin: EdgeInsets.all(12),
                                              padding: const EdgeInsets.only(
                                                  top: 14.0, bottom: 14.0),
                                              height: height * 0.17,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: TextField(
                                                      maxLines: 4,
                                                      controller:
                                                          _hintController,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 24.0,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Give your hint here",
                                                        hintStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.grey,
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        fillColor:
                                                            Colors.grey[200],
                                                        filled: true,
                                                      ),
                                                    ),
                                                  ),
                                                  _hintImage == null
                                                      ? Center(
                                                          child: Container(
                                                            height:
                                                                height * 0.15,
                                                            width: width * 0.15,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              color: Colors
                                                                  .grey[100],
                                                            ),
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: FlatButton(
                                                              onPressed: () =>
                                                                  getHintImage(
                                                                      setState),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        18.0),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/icons/upload_image.png',
                                                                        height: height *
                                                                            0.03,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'Upload Image',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Center(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.memory(
                                                                base64Decode(
                                                                    _hint),
                                                                height: height *
                                                                    0.15,
                                                                width: height *
                                                                    0.15,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                              SizedBox(
                                                                width: 18.0,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  FlatButton
                                                                      .icon(
                                                                    color: Colors
                                                                            .grey[
                                                                        200],
                                                                    onPressed: () =>
                                                                        getHintImage(
                                                                            setState),
                                                                    icon: Icon(
                                                                      Icons
                                                                          .edit,
                                                                    ),
                                                                    label: Text(
                                                                        'Edit'),
                                                                  ),
                                                                  FlatButton
                                                                      .icon(
                                                                    color: Colors
                                                                            .grey[
                                                                        200],
                                                                    onPressed: () =>
                                                                        setState(
                                                                            () {
                                                                      _hintImage =
                                                                          null;
                                                                      _hint =
                                                                          '';
                                                                    }),
                                                                    icon: Icon(
                                                                      Icons
                                                                          .delete,
                                                                    ),
                                                                    label: Text(
                                                                        'Delete'),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                      // _showHint
                                      //     ? Padding(
                                      //         padding: const EdgeInsets.symmetric(
                                      //           vertical: 12.0,
                                      //           horizontal: 14.0,
                                      //         ),
                                      //         child: ClipRRect(
                                      //           borderRadius: BorderRadius.circular(12.0),
                                      //           child: TextField(
                                      //             maxLines: 2,
                                      //             controller: _hintController,
                                      //             textAlign: TextAlign.center,
                                      //             decoration: InputDecoration(
                                      //               hintText: "Hint",
                                      //               border: InputBorder.none,
                                      //               fillColor: Colors.grey[200],
                                      //               filled: true,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       )
                                      //     : SizedBox.shrink(),
                                      _showSolution
                                          ? Container(
                                              margin: EdgeInsets.all(12),
                                              padding: const EdgeInsets.only(
                                                  top: 14.0, bottom: 14.0),
                                              height: height * 0.17,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: TextField(
                                                      maxLines: 4,
                                                      controller:
                                                          _solutionController,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 24.0,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Give your solution here",
                                                        hintStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.grey,
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        fillColor:
                                                            Colors.grey[200],
                                                        filled: true,
                                                      ),
                                                    ),
                                                  ),
                                                  _solutionImage == null
                                                      ? Center(
                                                          child: Container(
                                                            height:
                                                                height * 0.15,
                                                            width: width * 0.15,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              color: Colors
                                                                  .grey[100],
                                                            ),
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: FlatButton(
                                                              onPressed: () =>
                                                                  getSolutionImage(
                                                                      setState),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        18.0),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/icons/upload_image.png',
                                                                        height: height *
                                                                            0.03,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'Upload Image',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Center(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.memory(
                                                                base64Decode(
                                                                    _solution),
                                                                height: height *
                                                                    0.15,
                                                                width: height *
                                                                    0.15,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                              SizedBox(
                                                                width: 18.0,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  FlatButton
                                                                      .icon(
                                                                    color: Colors
                                                                            .grey[
                                                                        200],
                                                                    onPressed: () =>
                                                                        getSolutionImage(
                                                                            setState),
                                                                    icon: Icon(
                                                                      Icons
                                                                          .edit,
                                                                    ),
                                                                    label: Text(
                                                                        'Edit'),
                                                                  ),
                                                                  FlatButton
                                                                      .icon(
                                                                    color: Colors
                                                                            .grey[
                                                                        200],
                                                                    onPressed: () =>
                                                                        setState(
                                                                            () {
                                                                      _solutionImage =
                                                                          null;
                                                                      _solution =
                                                                          '';
                                                                    }),
                                                                    icon: Icon(
                                                                      Icons
                                                                          .delete,
                                                                    ),
                                                                    label: Text(
                                                                        'Delete'),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                      // _showSolution
                                      //     ? Padding(
                                      //         padding: const EdgeInsets.symmetric(
                                      //           vertical: 12.0,
                                      //           horizontal: 14.0,
                                      //         ),
                                      //         child: ClipRRect(
                                      //           borderRadius: BorderRadius.circular(12.0),
                                      //           child: TextField(
                                      //             maxLines: 2,
                                      //             controller: _solutionController,
                                      //             textAlign: TextAlign.center,
                                      //             decoration: InputDecoration(
                                      //               hintText: "Solution",
                                      //               border: InputBorder.none,
                                      //               fillColor: Colors.grey[200],
                                      //               filled: true,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       )
                                      //     : SizedBox.shrink(),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 14.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: TextField(
                                          maxLines: 1,
                                          controller: _sourceController,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            hintText: "Source(if any)",
                                            border: InputBorder.none,
                                            fillColor: Colors.grey[200],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: width * 0.13,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, right: 22.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Text('Public'),
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                    Switch(
                                      value: isPublic,
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      onChanged: (flag) {
                                        setState(
                                          () {
                                            isPublic = flag;
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) setState) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: height * 0.02,
                                        horizontal: 12.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Tag Topics"),
                                          BlocBuilder(
                                            cubit: context.bloc<TopicCubit>()
                                              ..getTopics(45),
                                            builder:
                                                (BuildContext context, state) {
                                              if (state is TopicFetched) {
                                                return StatefulBuilder(
                                                  builder: (BuildContext
                                                          context,
                                                      void Function(
                                                              void Function())
                                                          setState) {
                                                    return SmartSelect.multiple(
                                                      title: 'Topics',
                                                      placeholder:
                                                          'Select a Topic',
                                                      value: topics,
                                                      choiceItems:
                                                          S2Choice.listFrom(
                                                        source: state
                                                            .topicEntity.data,
                                                        value: (i, Data v) => {
                                                          'id': v.id,
                                                          'type': v.type
                                                        },
                                                        title: (i, Data v) =>
                                                            v.name,
                                                        group: (index,
                                                                Data item) =>
                                                            '',
                                                      ),
                                                      modalTitle: 'Tag Topics',
                                                      modalType: S2ModalType
                                                          .popupDialog,
                                                      choiceType:
                                                          S2ChoiceType.chips,
                                                      choiceStyle:
                                                          S2ChoiceStyle(
                                                        showCheckmark: true,
                                                      ),
                                                      modalConfirm: true,
                                                      choiceLayout:
                                                          S2ChoiceLayout.wrap,
                                                      onChange: (state) =>
                                                          setState(() {
                                                        print(state.value);
                                                        topics = state.value;
                                                      }),
                                                      tileBuilder:
                                                          (context, state) =>
                                                              S2Tile.fromState(
                                                        state,
                                                        isTwoLine: true,
                                                        leading: Container(
                                                          width: 40,
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Icon(
                                                              Icons.subject),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                              if (state is TopicEmpty) {
                                                return Text('No topics to Tag');
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                RaisedButton(
                                  onPressed: () =>
                                      setState(() => _showHint = true),
                                  child: Text(
                                    'Add Hint',
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                RaisedButton(
                                  onPressed: () =>
                                      setState(() => _showSolution = true),
                                  child: Text(
                                    'Add Solution',
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Visibility(
                                  visible: _currentQuestionId != null,
                                  child: RaisedButton(
                                    onPressed: () {
                                      questions.removeWhere((element) =>
                                          element == _currentQuestionId);
                                      _questionController.text = "";
                                      _option1Controller.text = "";
                                      _option2Controller.text = "";
                                      _option3Controller.text = "";
                                      _option4Controller.text = "";
                                      _hintController.text = "";
                                      _solutionController.text = "";
                                      context
                                          .bloc<QuestionAddCubit>()
                                          .deleteQuestion(
                                              widget._assessmentId, questions);
                                      context
                                          .bloc<QuestionsCubit>()
                                          .getQuestionsToAnAssessment(
                                              widget._assessmentId);
                                      _currentQuestionId = null;
                                      setState(() {});
                                    },
                                    child: Text(
                                      'Delete',
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    if (widget._questionType ==
                                        QuestionType.Objective) {
                                      context
                                          .bloc<AddQuestionCubit>()
                                          .addQuestion(
                                              _questionController.text,
                                              topics,
                                              [
                                                _option1Controller.text,
                                                _option2Controller.text,
                                                _option3Controller.text,
                                                _option4Controller.text,
                                                _option5Controller.text,
                                              ],
                                              widget._bloomValue,
                                              difficultylevel,
                                              _sourceController.text,
                                              isPublic ? 'public' : 'private',
                                              1,
                                              _correctAnswer,
                                              _option1Image,
                                              _option2Image,
                                              _option3Image,
                                              _option4Image,
                                              _option5Image,
                                              _questionImage,
                                              widget._assessmentId,
                                              questions,
                                              _hintController.text,
                                              _solutionController.text,
                                              false);

                                      Future.delayed(
                                          Duration(seconds: 1),
                                          () => _questionFetchCubit
                                              .getQuestionsToAnAssessment(
                                                  widget._assessmentId));
                                    } else {}
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
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
            ),
          ],
        ),
      ),
    );
  }
}

class OptionField extends StatelessWidget {
  final int myValue;
  final int groupValue;
  final String image;
  final FocusNode myFocusNode;
  final Function onTap;
  final Function onChanged;
  final Function optionImagePicker;
  final Function deletePickedImage;
  final Color color;
  final String label;

  const OptionField({
    @required this.myValue,
    @required this.groupValue,
    @required this.image,
    @required this.myFocusNode,
    @required this.onChanged,
    @required this.onTap,
    @required this.optionImagePicker,
    @required this.deletePickedImage,
    @required this.color,
    @required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.5,
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 85.0,
            margin: const EdgeInsets.only(right: 12.0),
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: MyCheckbox(
              value: myValue == groupValue,
              onChanged: () => onChanged(myValue),
            ),
          ),
          Flexible(
            child: TextField(
              focusNode: myFocusNode,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
                hintStyle: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black54),
              ),
              onChanged: onTap,
            ),
          ),
          image.length == 0
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: 55.0,
                  child: FlatButton(
                    color: color,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                    ),
                    onPressed: optionImagePicker,
                    child: Icon(
                      Icons.image,
                      size: 22.0,
                      color: Colors.white,
                    ),
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.memory(
                      base64Decode(image),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: 55.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            color: color,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                            ),
                            onPressed: optionImagePicker,
                            child: Icon(
                              Icons.edit,
                              size: 22.0,
                              color: Colors.white,
                            ),
                          ),
                          FlatButton(
                            color: color,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                            ),
                            onPressed: deletePickedImage,
                            child: Icon(
                              Icons.delete,
                              size: 22.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}

class LeftPane extends StatelessWidget {
  const LeftPane({
    Key key,
    @required this.width,
    @required this.quesCount,
  }) : super(key: key);

  final double width;
  final int quesCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.2,
      color: Colors.grey.withOpacity(.5),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
                itemCount: quesCount,
                itemBuilder: (context, index) => _buildlist(index)),
          ),
          FlatButton(
            onPressed: null,
            child: Text("Type Question"),
          ),
          FlatButton(
            onPressed: null,
            child: Text("Upload Question"),
          ),
          FlatButton(
            onPressed: null,
            child: Text("Choose"),
          ),
        ],
      ),
    );
  }
}

_buildlist(index) {
  return ListTile(
    title: Text("Question${index + 1}"),
  );
}
