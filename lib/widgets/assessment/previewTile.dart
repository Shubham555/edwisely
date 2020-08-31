//Widget that is used on Assessment Page on the sidebar to offer Powerpoint like previews of the Question

import 'package:edwisely/models/questionType.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PreviewTile extends StatelessWidget {
  final int index;
  final String question;
  final QuestionType type;
  final Function delete;
  final Function duplicate;
  final Function invoker;

  PreviewTile({
    @required this.index,
    @required this.question,
    @required this.type,
    @required this.delete,
    @required this.duplicate,
    @required this.invoker,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Text(
                          (index + 1).toString() +
                              '.  ' +
                              ((type == QuestionType.Objective)
                                  ? 'Objective'
                                  : 'Subjective'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        (question != null) ? question : 'Your Question',
                        style: TextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => invoker(index),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                child: Container(
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                onTap: () => delete(index),
              ),
              GestureDetector(
                child: Container(
                  child: Text(
                    'Duplicate',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                onTap: () => duplicate(index),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
