import 'package:edwisely/data/blocs/addQuestionScreen/add_question_bloc.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/upload_excel_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ColumnLeft extends StatelessWidget {
  const ColumnLeft(this.height, this.width, this.quesCount);
  final double width;
  final double height;
  final int quesCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.1,
      color: Color(0xffE5E5E5),
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
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BlocProvider(
                  create: (BuildContext context) => AddQuestionBloc(),
                  child: UploadExcelTab(),
                ),
              ),
            ),
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
