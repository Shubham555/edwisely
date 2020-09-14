import 'dart:developer';

import 'package:edwisely/data/blocs/addQuestionScreen/add_question_bloc.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';

class UploadExcelTab extends StatefulWidget {
  @override
  _UploadExcelTabState createState() => _UploadExcelTabState();
}

class _UploadExcelTabState extends State<UploadExcelTab> {
  FilePickerCross _excelFile;
  final _bloc = AddQuestionBloc();

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
                    onPressed: () => _bloc.add(
                      UploadExcel(_excelFile),
                    ),
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
    _excelFile = await FilePickerCross.importFromStorage(
        type: FileTypeCross.any, fileExtension: '.xlsx, .xls');
    if (_excelFile.fileName.contains('xlsx') ||
        _excelFile.fileName.contains('xls')) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected ${_excelFile.fileName}'),
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
