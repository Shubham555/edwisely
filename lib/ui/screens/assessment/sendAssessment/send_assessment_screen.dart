import 'package:edwisely/data/cubits/select_students_cubit.dart';
import 'package:edwisely/data/cubits/send_assessment_cubit.dart';
import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/assessment_landing_screen.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:edwisely/ui/widgets_util/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../../data/provider/selected_page.dart';

class SendAssessmentScreen extends StatefulWidget {
  final int assessmentId;
  final String title;
  final List<int> questions;

  SendAssessmentScreen(this.assessmentId, this.title, this.questions);

  @override
  _SendAssessmentScreenState createState() => _SendAssessmentScreenState();
}

class _SendAssessmentScreenState extends State<SendAssessmentScreen> {
  List<int> students = [];
  DateTime _testStart;
  TimeOfDay _testStartTime;

  DateTime _testExpiry;
  TimeOfDay _testExpiryTime;

  Duration _testDuration;
  List<int> questions;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: context.bloc<SendAssessmentCubit>(),
      listener: (BuildContext context, state) {
        if (state is TestSent) {
          Toast.show('Assessment Sent', context);
          Future.delayed(
            Duration(seconds: 2),
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AssessmentLandingScreen(),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NavigationDrawer(
              isCollapsed: true,
              key: context.watch<SelectedPageProvider>().navigatorKey,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BigAppBar(
                    actions: null,
                    titleText: 'Send Assessment',
                    bottomTab: null,
                    appBarTitle: Text(
                      'Edwisely',
                      style: TextStyle(color: Colors.black),
                    ),
                    flatButton: FlatButton.icon(
                      onPressed: () {
                        context.bloc<SendAssessmentCubit>().sendAssessment(
                              widget.title,
                              'description',
                              _testExpiry.toString(),
                              widget.questions,
                              _testDuration.toString(),
                              students,
                              widget.assessmentId,
                              _testStart.toString(),
                            );
                      },
                      icon: Icon(Icons.send),
                      label: Text('Send Assessment'),
                    ),
                    appBarSize: MediaQuery.of(context).size.height / 3.0,
                  ).build(context),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: MediaQuery.of(context).size.width * 0.17,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) setState) {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                          )).whenComplete(() async {
                                        _testStartTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                      }).catchError(() {
                                        _testStart = null;
                                        _testStartTime = null;
                                      });
                                      setState(() {});
                                    },
                                  ),
                                  Text(
                                    _testStart == null ? '' : DateFormat('EEE d MMM yyyy').format(_testStart),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    _testStartTime == null ? '' : 'at ${_testStartTime.format(context).toString()}',
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) setState) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Test Expiry Date : '),
                                IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () async {
                                    if (_testStart == null || _testStartTime == null) {
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Select Starting Date and time first'),
                                        ),
                                      );
                                    } else {
                                      _testExpiry = await showDatePicker(
                                          context: context,
                                          initialDate: _testStart,
                                          firstDate: _testStart,
                                          lastDate: DateTime.now().add(
                                            Duration(days: 100),
                                          )).whenComplete(() async {
                                        _testExpiryTime = await showTimePicker(context: context, initialTime: _testStartTime);
                                      }).catchError(() {
                                        _testExpiry = null;
                                        _testExpiryTime = null;
                                      });
                                    }

                                    setState(() {});
                                  },
                                ),
                                Text(
                                  _testExpiry == null ? '' : DateFormat('EEE d MMM yyyy').format(_testExpiry),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  _testExpiryTime == null ? '' : 'at ${_testExpiryTime.format(context).toString()}',
                                ),
                              ],
                            );
                          },
                        ),
                        StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) setState) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  },
                                ),
                                Text(
                                  _testDuration == null ? '' : '${_testDuration.inMinutes.toString()} Minutes',
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder(
                    //todo change
                    cubit: context.bloc<SendAssessmentCubit>()..getSections(71),
                    builder: (BuildContext context, state) {
                      if (state is SendAssessmentSectionsFetched) {
                        return Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: MediaQuery.of(context).size.width * 0.17,
                            ),
                            itemCount: state.sectionEntity.data.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              final efv = SelectStudentsCubit();
                              efv.getStudentsInASection(
                                state.sectionEntity.data[index].id,
                                1,
                              );

                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.height * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                                      child: Text(
                                        state.sectionEntity.data[index].name,
                                        style: Theme.of(context).textTheme.headline5,
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          BlocBuilder(
                                            cubit: efv,
                                            builder: (BuildContext context, state) {
                                              if (state is SelectStudentsStudentsFetched) {
                                                return StatefulBuilder(
                                                  builder: (BuildContext context, void Function(void Function()) setState) {
                                                    return Card(
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                          vertical: 8.0,
                                                          horizontal: 12.0,
                                                        ),
                                                        child: ListView.builder(
                                                          scrollDirection: Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount: state.studentsEntity.data.length,
                                                          itemBuilder: (BuildContext context, int index) => CheckboxListTile(
                                                            title: Text(
                                                              state.studentsEntity.data[index].name,
                                                            ),
                                                            subtitle: Text(
                                                              state.studentsEntity.data[index].roll_number,
                                                            ),
                                                            value: students.contains(
                                                              state.studentsEntity.data[index].id,
                                                            ),
                                                            onChanged: (flag) {
                                                              flag
                                                                  ? students.add(
                                                                      state.studentsEntity.data[index].id,
                                                                    )
                                                                  : students.remove(
                                                                      state.studentsEntity.data[index].id,
                                                                    );
                                                              setState(() {});
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                return Center(
                                                  child: CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
