import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:intl/intl.dart';

class SendAssessmentScreen extends StatefulWidget {
  final int assessmentId;
  final String title;
  final String noOfQuestions;

  SendAssessmentScreen(this.assessmentId, this.title, this.noOfQuestions);

  @override
  _SendAssessmentScreenState createState() => _SendAssessmentScreenState();
}

class _SendAssessmentScreenState extends State<SendAssessmentScreen> {
  DateTime _testStart;

  DateTime _testExpiry;

  Duration _testDuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigAppBar(
        actions: null,
        titleText: 'Send Assessment',
        bottomTab: null,
        appBarSize: MediaQuery.of(context).size.height / 3.5,
        appBarTitle: Text(
          'Edwisely',
          style: TextStyle(color: Colors.black),
        ),
        flatButton: FlatButton.icon(
          onPressed: null,
          icon: Icon(Icons.send),
          label: Text('Send Assessment'),
        ),
      ).build(context),
      body: Column(
        children: [
          Row(
            children: [
              Text('Test Start Date : '),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () async {
                  _testStart = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      Duration(days: 100),
                    ),
                    lastDate: DateTime.now().add(
                      Duration(days: 100),
                    ),
                  );
                  setState(() {});
                  print(_testStart.toString());
                },
              ),
              Text(
                _testStart == null
                    ? ''
                    : DateFormat('EEE d MMM yyyy').format(_testStart),
              )
            ],
          ),
          Row(
            children: [
              Text('Test Expiry Date : '),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () async {
                  _testExpiry = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      Duration(days: 100),
                    ),
                    lastDate: DateTime.now().add(
                      Duration(days: 100),
                    ),
                  );
                  setState(() {});
                  print(_testExpiry.toString());
                },
              ),
              Text(
                _testExpiry == null
                    ? ''
                    : DateFormat('EEE d MMM yyyy').format(_testExpiry),
              )
            ],
          ),
          Row(
            children: [
              Text('Test Duration Time :   '),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () async {
                  _testDuration = await showDurationPicker(
                    context: context,
                    initialTime: Duration(minutes: 30),
                  );
                  setState(() {});
                  print(_testDuration);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
//todo add sections api when complete
// Api endpoint: getCollegeDepartmentSectionStudents
// Post method
// Body: form-data
// college_department_section_id : [554]
