import 'package:catex/catex.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:edwisely/data/cubits/add_question_cubit.dart';
import 'package:edwisely/data/cubits/objective_questions_cubit.dart';
import 'package:edwisely/data/cubits/topic_cubit.dart';
import 'package:edwisely/data/model/add_question/typed_objective_questions.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar_add_questions.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/questionBank/topicEntity/data.dart';

class TypeQuestionTab extends StatefulWidget {
  final String _title;
  final String _description;
  final int _subjectId;
  QuestionType _questionType;
  final int _assessmentId;

  TypedObjectiveQuestionProvider newQues;

  int _bloomValue = 1;
  int quesCounter = 0;
  bool option1Selected = false;
  bool option2Selected = false;
  bool option3Selected = false;
  bool option4Selected = false;
  bool option5Selected = false;

  TypeQuestionTab(
    this._title,
    this._description,
    this._subjectId,
    this._questionType,
    this._assessmentId,
  );

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
  FilePickerCross _option1Image;
  FilePickerCross _option2Image;
  FilePickerCross _option3Image;
  FilePickerCross _option4Image;
  FilePickerCross _option5Image;

  Future getImage() async {
    print('Picking Image');
    final pickedFile =
        await FilePickerCross.importFromStorage(type: FileTypeCross.any);

    setState(() {
      _questionImage = pickedFile;
    });
  }

  Future getOptionImage(int opt) async {
    print('Picking Image');
    final pickedFile =
        await FilePickerCross.importFromStorage(type: FileTypeCross.any);

    setState(() {
      switch (opt) {
        case 1:
          _option1Image = pickedFile;
          break;
        case 2:
          _option2Image = pickedFile;
          break;
        case 3:
          _option3Image = pickedFile;
          break;
        case 4:
          _option4Image = pickedFile;
          break;
        case 5:
          _option5Image = pickedFile;
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: BigAppBarAddQuestionScreen(
          actions: [],
          appBarSize: MediaQuery.of(context).size.height / 5.2,
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
          titleText: 'Type Questions to ${widget._title} Assessment',
          description: "${widget._description}",
          subject: "Subject: ${widget._subjectId}",
        ).build(context),
        body: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 6,
              height: MediaQuery.of(context).size.height,
              color: Colors.grey.shade500,
              child: BlocBuilder(
                cubit: _questionFetchCubit
                  ..getQuestionsToAnAssessment(
                    widget._assessmentId,
                  ),
                builder: (BuildContext context, state) {
                  if (state is QuestionsToAnAssessmentFetched) {
                    state.assessmentQuestionsEntity.data.forEach(
                      (element) {
                        questions.add(
                          element.id,
                        );
                      },
                    );
                    return ListView.builder(
                      itemCount: state.assessmentQuestionsEntity.data.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ListTile(
                        title: CaTeX(
                          state.assessmentQuestionsEntity.data[index].name,
                        ),
                      ),
                    );
                  }
                  if (state is QuestionsToAnAssessmentEmpty) {
                    return Center(
                      child: Text('Add Questions to this Assessment'),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: height * 0.02,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: SizedBox(
                  width: width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text('Question Type '),
                          SizedBox(
                            width: 20,
                          ),
                          DropdownButton(
                              value: widget._questionType,
                              items: [
                                DropdownMenuItem(
                                  child: Text("MCQ"),
                                  value: QuestionType.Objective,
                                ),
                                DropdownMenuItem(
                                  child: Text("Fill In The Blanks"),
                                  value: QuestionType.Subjective,
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  widget._questionType = value;
                                });
                              }),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(12),
                        width: width * 0.5,
                        height: height * 0.23,
                        color: Colors.grey[200],
                        child: Column(
                          children: [
                            TextField(
                              maxLines: 4,
                              controller: _questionController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Enter Question",
                                border: InputBorder.none,
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                            _questionImage == null
                                ? FlatButton(
                                    color: Colors.grey[200],
                                    onPressed: getImage,
                                    child: Text(
                                      "+",
                                      style: TextStyle(fontSize: 30),
                                    ))
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        _questionImage.path,
                                        height: height * 0.1,
                                        width: height * 0.1,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(
                                        width: 18.0,
                                      ),
                                      FlatButton(
                                          color: Colors.grey[200],
                                          onPressed: getImage,
                                          child: Icon(
                                            Icons.edit,
                                          ))
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Bloom'),
                          SizedBox(
                            width: 20,
                          ),
                          DropdownButton(
                              value: widget._bloomValue,
                              items: [
                                DropdownMenuItem(
                                  child: Text('All'),
                                  value: -1,
                                ),
                                DropdownMenuItem(
                                  child: Text('Remember'),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text('Understand'),
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
                                  widget._bloomValue = value;
                                });
                              }),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      widget._questionType == QuestionType.Objective
                          ? Column(
                              children: [
                                widget.option1Selected
                                    ? OptionField(
                                        myValue: 0,
                                        groupValue: _correctAnswer,
                                        myFocusNode: _option1Node,
                                        onChanged: (int value) => setState(
                                            () => _correctAnswer = value),
                                        onTap: (String value) => setState(() =>
                                            _option1Controller.text = value),
                                        optionImagePicker: () =>
                                            getOptionImage(1),
                                        image: _option1Image,
                                      )
                                    : FlatButton(
                                        color: Colors.grey[200],
                                        onPressed: () {
                                          setState(() {
                                            widget.option1Selected = true;
                                          });
                                          _option1Node.requestFocus();
                                        },
                                        child: Text(
                                          "+",
                                          style: TextStyle(fontSize: 30),
                                        )),
                                SizedBox(
                                  width: 30,
                                ),
                                widget.option2Selected
                                    ? OptionField(
                                        myValue: 1,
                                        groupValue: _correctAnswer,
                                        myFocusNode: _option2Node,
                                        onChanged: (int value) => setState(
                                            () => _correctAnswer = value),
                                        onTap: (String value) => setState(() =>
                                            _option2Controller.text = value),
                                        optionImagePicker: () =>
                                            getOptionImage(2),
                                        image: _option2Image,
                                      )
                                    : FlatButton(
                                        color: Colors.grey[200],
                                        onPressed: () {
                                          setState(() {
                                            widget.option2Selected = true;
                                            _option2Node.requestFocus();
                                          });
                                        },
                                        child: Text(
                                          "+",
                                          style: TextStyle(fontSize: 30),
                                        )),
                                widget.option3Selected
                                    ? OptionField(
                                        myValue: 2,
                                        groupValue: _correctAnswer,
                                        myFocusNode: _option3Node,
                                        onChanged: (int value) => setState(
                                            () => _correctAnswer = value),
                                        onTap: (String value) => setState(() =>
                                            _option3Controller.text = value),
                                        optionImagePicker: () =>
                                            getOptionImage(3),
                                        image: _option3Image,
                                      )
                                    : FlatButton(
                                        color: Colors.grey[200],
                                        onPressed: () {
                                          setState(() {
                                            widget.option3Selected = true;
                                            _option3Node.requestFocus();
                                          });
                                        },
                                        child: Text(
                                          "+",
                                          style: TextStyle(fontSize: 30),
                                        )),
                                SizedBox(
                                  width: 30,
                                ),
                                widget.option4Selected
                                    ? OptionField(
                                        myValue: 3,
                                        groupValue: _correctAnswer,
                                        myFocusNode: _option4Node,
                                        onChanged: (int value) => setState(
                                            () => _correctAnswer = value),
                                        onTap: (String value) => setState(() =>
                                            _option4Controller.text = value),
                                        optionImagePicker: () =>
                                            getOptionImage(4),
                                        image: _option4Image,
                                      )
                                    : FlatButton(
                                        color: Colors.grey[200],
                                        onPressed: () {
                                          setState(() {
                                            widget.option4Selected = true;
                                            _option4Node.requestFocus();
                                          });
                                        },
                                        child: Text(
                                          "+",
                                          style: TextStyle(fontSize: 30),
                                        )),
                                SizedBox(
                                  width: 30,
                                ),
                                widget.option5Selected
                                    ? OptionField(
                                        myValue: 4,
                                        groupValue: _correctAnswer,
                                        myFocusNode: _option5Node,
                                        onChanged: (int value) => setState(
                                            () => _correctAnswer = value),
                                        onTap: (String value) => setState(() =>
                                            _option5Controller.text = value),
                                        optionImagePicker: () =>
                                            getOptionImage(5),
                                        image: _option5Image,
                                      )
                                    : FlatButton(
                                        color: Colors.grey[200],
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          setState(() {
                                            widget.option5Selected = true;
                                            _option5Node.requestFocus();
                                          });
                                        },
                                        child: Text(
                                          "+",
                                          style: TextStyle(fontSize: 30),
                                        )),
                              ],
                            )
                          : Container(
                              height: height * 0.1,
                              width: width * 0.3,
                              child: Row(
                                children: [
                                  Text("Type correct answer: "),
                                  Container(
                                    height: 20,
                                    width: 100,
                                    child: TextField(
                                      controller: _fillInTheBlanksController,
                                      decoration:
                                          InputDecoration(hintText: "..."),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        maxLines: 4,
                        controller: _hintController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Hint",
                          border: InputBorder.none,
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        maxLines: 4,
                        controller: _solutionController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Solution",
                          border: InputBorder.none,
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        maxLines: 4,
                        controller: _sourceController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Source(if any)",
                          border: InputBorder.none,
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text('Public'),
                          SizedBox(
                            width: 30,
                          ),
                          Switch(
                              value: isPublic,
                              onChanged: (flag) {
                                setState(
                                  () {
                                    isPublic = flag;
                                  },
                                );
                              }),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      RaisedButton(
                        color: Color(0xFF1D2B64),
                        onPressed: () {
                          print(_option1Image.path);
                          print(_questionController.text);
                          if (widget._questionType == QuestionType.Objective) {
                            AddQuestionCubit().addQuestion(
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
                              widget._bloomValue,
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
                            );

                            print('Objective');
                            // print('Topics : ${widge}');
                            print('Difficulty Level : ${widget._bloomValue}');
                            print(
                                'Options : [${_option1Controller.text}, ${_option2Controller.text}, ${_option3Controller.text}, ${_option4Controller.text}]');
                            print('Source : faculty');
                            print('Type : Public');
                            print('Answer : $_correctAnswer');
                            //images are stored in files _option1Image,_option2Image.... and _questionImage
                            //field type is question type 1 : MCQ 2: FIB
                            //2 options are mandatory and 5 is maximum
                            //indexing starts from 1
                          } else {
                            print('Subjective');
                          }
                          setState(() {
                            widget.quesCounter += 1;
                          });
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              child: Column(
                children: [
                  Text("Tag Topics"),
                  //todo change
                  BlocBuilder(
                    cubit: context.bloc<TopicCubit>()
                      //todo fix
                      ..getTopics(45, 71),
                    builder: (BuildContext context, state) {
                      if (state is TopicFetched) {
                        return Container(
                          width: 200,
                          child: ChipsChoice<Map<String, dynamic>>.multiple(
                            value: topics,
                            isWrapped: true,
                            options: ChipsChoiceOption.listFrom(
                              source: state.topicEntity.data,
                              value: (i, Data v) =>
                                  {'id': v.id, 'type': v.type},
                              label: (i, Data v) => v.name,
                            ),
                            onChanged: (val) {
                              setState(
                                () => topics = val,
                              );
                            },
                          ),
                        );
                      }
                      if (state is TopicEmpty) {
                        return Text('No topcis to Tag');
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OptionField extends StatelessWidget {
  final int myValue;
  final int groupValue;
  final FilePickerCross image;
  final FocusNode myFocusNode;
  final Function onTap;
  final Function onChanged;
  final Function optionImagePicker;

  const OptionField({
    @required this.myValue,
    @required this.groupValue,
    @required this.image,
    @required this.myFocusNode,
    @required this.onChanged,
    @required this.onTap,
    @required this.optionImagePicker,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      child: RadioListTile(
        value: myValue,
        groupValue: groupValue,
        onChanged: onChanged,
        title: TextField(
          focusNode: myFocusNode,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter option",
            hintStyle: TextStyle(fontSize: 20),
            fillColor: Colors.grey[200],
            filled: true,
          ),
          onChanged: onTap,
        ),
        secondary: image == null
            ? FlatButton(
                color: Colors.grey[200],
                onPressed: optionImagePicker,
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 30),
                ))
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    image.path,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.height * 0.1,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 18.0,
                  ),
                  FlatButton(
                      color: Colors.grey[200],
                      onPressed: optionImagePicker,
                      child: Icon(
                        Icons.edit,
                      ))
                ],
              ),
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
