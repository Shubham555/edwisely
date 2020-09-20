import 'package:edwisely/data/blocs/addQuestionScreen/add_question_bloc.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:edwisely/util/enums/question_type_enum.dart';

class ColumnRight extends StatelessWidget {
  ColumnRight(this.height, this.width);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: width * 0.17,
      padding: EdgeInsets.only(right: width * 0.03, top: height * 0.03),
      child: Column(
        children: [
          Container(
              height: height * 0.2,
              width: width * 0.10,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(height * 0.01),
                  height: 17,
                  child: OutlineButton(
                    color: Colors.purple,
                    onPressed: () {},
                    child: Text("Unit${index + 1}"),
                  ),
                ),
              )),
          SizedBox(
            height: height * 0.02,
          ),
          Text('Topics'),
          Container(
            height: height * 0.26,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) => _buildTopicsList(index)),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Add"),
          )
        ],
      ),
    );
  }
}

_buildTopicsList(int index) {
  return Container(
    height: 25,
    width: 50,
    child: CheckboxListTile(
      title: Text("Title ${index + 1}"),
      value: false,
      onChanged: (value) => {},
    ),
  );
}
