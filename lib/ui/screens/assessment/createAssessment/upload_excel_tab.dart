import 'dart:developer';
import 'dart:html';

import 'package:edwisely/data/blocs/assessmentLandingScreen/addQuestionScreen/add_question_bloc.dart';
import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';

class UploadExcelTab extends StatefulWidget {
  @override
  _UploadExcelTabState createState() => _UploadExcelTabState();
}

class _UploadExcelTabState extends State<UploadExcelTab> {
  File _excelFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                onPressed: null,
                child: Text('Excel Template Download'),
              ),
              FlatButton(
                onPressed: () => _selectFile(context),
                child: Text('Upload Template'),
              ),
            ],
          ),
        ),
        _excelFile == null
            ? Container()
            : Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: FloatingActionButton.extended(
                    onPressed: () => context.bloc<AddQuestionBloc>(),
                    icon: Icon(Icons.upload_file),
                    label: Text('Upload'),
                  ),
                ),
              )
      ],
    );
  }

  _selectFile(BuildContext context) async {
    //todo get excel files extensions
    _excelFile = await FilePicker.getFile(
      allowedExtensions: ['xlsx', 'xls'],
    );
    if (_excelFile.name.contains('xlsx') || _excelFile.name.contains('xls')) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected ${_excelFile.name}'),
        ),
      );
    } else {
      _excelFile = null;
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Upload an Excel File'),
        ),
      );
    }
    setState(() {});
  }
}
