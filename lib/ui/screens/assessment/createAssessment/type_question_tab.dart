import 'package:flutter/material.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar_add_questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:edwisely/data/model/add_question/typed_objective_questions.dart';

class TypeQuestionTab extends StatefulWidget {
  final String _title;
  final String _description;
  final int _subjectId;
  final QuestionType _questionType;
  final int _assessmentId;
  TypedObjectiveQuestionProvider newQues;
  final List<DropdownMenuItem> bloomList = [
    DropdownMenuItem(
      child: Text("Level 1"),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text("Level 2"),
      value: 2,
    ),
    DropdownMenuItem(
      child: Text("Level 3"),
      value: 3,
    ),
    DropdownMenuItem(
      child: Text("Level 4"),
      value: 4,
    ),
    DropdownMenuItem(
      child: Text("Level 5"),
      value: 5,
    ),
  ];
  int _value = 1;
  int _bloomValue = 1;
  int quesCounter = 0;
  bool option1Selected = false;
  bool option2Selected = false;
  bool option3Selected = false;
  bool option4Selected = false;
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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
          LeftPane(
            width: width,
            quesCount: widget.quesCounter,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.08, vertical: height * 0.02),
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
                        value: widget._value,
                        items: [
                          DropdownMenuItem(
                            child: Text("MCQ"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Fill In The Blanks"),
                            value: 2,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            widget._value = value;
                          });
                        }),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  width: 700,
                  height: 4 * 24.0,
                  child: TextField(
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Enter Question",
                      border: InputBorder.none,
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
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
                        items: widget.bloomList,
                        onChanged: (value) {
                          setState(() {
                            widget._bloomValue = value;
                          });
                        }),
                  ],
                ),
                SizedBox(height: height * 0.02),
                widget._value == 1
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              widget.option1Selected
                                  ? OptionField(() {})
                                  : FlatButton(
                                      color: Colors.grey[200],
                                      onPressed: () {
                                        setState(() {
                                          widget.option1Selected = true;
                                        });
                                      },
                                      child: Text(
                                        "+",
                                        style: TextStyle(fontSize: 30),
                                      )),
                              SizedBox(
                                width: 30,
                              ),
                              widget.option2Selected
                                  ? OptionField(() {})
                                  : FlatButton(
                                      color: Colors.grey[200],
                                      onPressed: () {
                                        setState(() {
                                          widget.option2Selected = true;
                                        });
                                      },
                                      child: Text(
                                        "+",
                                        style: TextStyle(fontSize: 30),
                                      )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              widget.option3Selected
                                  ? OptionField(() {})
                                  : FlatButton(
                                      color: Colors.grey[200],
                                      onPressed: () {
                                        setState(() {
                                          widget.option3Selected = true;
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
                                  ? OptionField(() {})
                                  : FlatButton(
                                      color: Colors.grey[200],
                                      onPressed: () {
                                        setState(() {
                                          widget.option4Selected = true;
                                        });
                                      },
                                      child: Text(
                                        "+",
                                        style: TextStyle(fontSize: 30),
                                      )),
                            ],
                          ),
                        ],
                      )
                    : Container(
                        height: height * 0.1,
                        width: width * 0.3,
                        child: Row(children: [
                          Text("Type correct answer: "),
                          Container(
                              height: 20,
                              width: 100,
                              child: TextField(
                                decoration: InputDecoration(hintText: "..."),
                              ))
                        ]),
                      ),
                SizedBox(
                  height: height * 0.02,
                ),
                RaisedButton(
                  color: Color(0xFF1D2B64),
                  onPressed: () {
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            child: Column(
              children: [
                Text("Tag Topics"),
                Container(
                  height: height * 0.15,
                  width: width * 0.16,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(border: Border.all()),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OptionField extends StatelessWidget {
  const OptionField(this.onTap);
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 250,
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter option",
          hintStyle: TextStyle(fontSize: 20),
          fillColor: Colors.grey[200],
          filled: true,
        ),
        onChanged: onTap,
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
      width: width * 0.1,
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
