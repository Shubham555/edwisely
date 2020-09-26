import 'package:edwisely/main.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../data/cubits/live_class_cubit.dart';
import '../../data/cubits/select_students_cubit.dart';
import '../../data/cubits/send_assessment_cubit.dart';
import '../../data/provider/selected_page.dart';
import '../widgets_util/big_app_bar.dart';
import '../widgets_util/navigation_drawer.dart';
import '../widgets_util/text_input.dart';

class CreateVCScreen extends StatefulWidget {
  @override
  _CreateVCScreenState createState() => _CreateVCScreenState();
}

class _CreateVCScreenState extends State<CreateVCScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  DateTime _vcStart;
  TimeOfDay _vcStartTime;

  DateTime _vcEnd;
  TimeOfDay _vcEndTime;
  FilePickerCross file;
  Size screenSize;
  List<int> students = [];
  ScrollController _scrollController = ScrollController();

  Future<DateTime> _pickStartDate() async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        Duration(days: 100),
      ),
      lastDate: DateTime.now().add(
        Duration(days: 100),
      ),
    ).catchError(() {
      _vcStart = null;
    });
  }

  Future<TimeOfDay> _pickStartTime() async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).catchError(() {
      _vcStartTime = null;
    });
  }

  Future<DateTime> _pickEndDate() async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        Duration(days: 100),
      ),
      lastDate: DateTime.now().add(
        Duration(days: 100),
      ),
    ).catchError(() {
      _vcEnd = null;
    });
  }

  Future<TimeOfDay> _pickEndTime() async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).catchError(() {
      _vcEndTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('departmentId == $departmentId');
    screenSize = MediaQuery.of(context).size;
    print(Provider.of<SelectedPageProvider>(context).selectedPage);
    return Scaffold(
      body: BlocListener(
        cubit: context.bloc<LiveClassCubit>(),
        listener: (BuildContext context, state) {
          if (state is LiveClassSent) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Live Class Sent'),
              ),
            );
          }
          if (state is LiveClassSendFailed) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Live Class Sending Failed'),
              ),
            );
          }
        },
        child: Row(
          children: [
            NavigationDrawer(
              isCollapsed: false,
              key: context.watch<SelectedPageProvider>().navigatorKey,
            ),
            Expanded(
              child: Column(
                children: [
                  BigAppBar(
                    actions: null,
                    titleText: 'Create Virtual Class',
                    appBarSize: MediaQuery.of(context).size.height / 3,
                    bottomTab: null,
                    appBarTitle: Text(
                      'Edwisely',
                      style: TextStyle(color: Colors.black),
                    ),
                    flatButton: null,
                  ).build(context),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: screenSize.width * 0.17,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.18,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                //spacing
                                SizedBox(
                                  height: screenSize.height * 0.05,
                                ),
                                //title
                                TextInput(
                                  label: 'Title',
                                  hint: 'Enter your title here',
                                  inputType: TextInputType.text,
                                  autofocus: true,
                                  onSaved: (String value) =>
                                      _title = value.trim(),
                                  validator: (String value) {
                                    if (value.trim().length == 0) {
                                      return 'This field cannot be empty!';
                                    }
                                    return null;
                                  },
                                ),
                                //spacing
                                SizedBox(
                                  height: screenSize.height * 0.05,
                                ),
                                //description
                                TextInput(
                                  label: 'Description',
                                  hint: 'Enter the description here',
                                  inputType: TextInputType.multiline,
                                  maxLines: 4,
                                  onSaved: (String value) =>
                                      _description = value.trim(),
                                  validator: (String value) {
                                    if (value.trim().length == 0) {
                                      return 'This field cannot be empty!';
                                    }
                                    return null;
                                  },
                                ),
                                //spacing
                                SizedBox(
                                  height: screenSize.height * 0.05,
                                ),
                                //start and end time
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //start date picker
                                    IconButton(
                                      icon: Icon(Icons.calendar_today),
                                      onPressed: () async {
                                        _vcStart = await _pickStartDate();
                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _vcStart == null
                                          ? 'Pick Start Date'
                                          : DateFormat('EEE d MMM yyyy')
                                              .format(_vcStart),
                                    ),
                                    Spacer(),
                                    //start time picker
                                    IconButton(
                                      icon: Icon(Icons.lock_clock),
                                      onPressed: () async {
                                        _vcStartTime = await _pickStartTime();
                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _vcStartTime == null
                                          ? 'Pick Start Time'
                                          : 'at ${_vcStartTime.format(context).toString()}',
                                    ),
                                  ],
                                ),
                                //spacing
                                SizedBox(
                                  height: screenSize.height * 0.05,
                                ),
                                //start and end time
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //end date picker
                                    IconButton(
                                      icon: Icon(Icons.calendar_today),
                                      onPressed: () async {
                                        _vcEnd = await _pickEndDate();
                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _vcEnd == null
                                          ? 'Pick Expiry Date'
                                          : DateFormat('EEE d MMM yyyy')
                                              .format(_vcStart),
                                    ),
                                    Spacer(),
                                    //end time picker
                                    IconButton(
                                      icon: Icon(Icons.lock_clock),
                                      onPressed: () async {
                                        _vcEndTime = await _pickEndTime();
                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _vcEndTime == null
                                          ? 'Pick Expiry Time'
                                          : 'at ${_vcEndTime.format(context).toString()}',
                                    ),
                                  ],
                                ),
                                //spacing
                                SizedBox(
                                  height: screenSize.height * 0.05,
                                ),
                                //send notification button
                                Center(
                                  child: RaisedButton(
                                    onPressed: () {
                                      final form = _formKey.currentState;

                                      if (form.validate()) {
                                        form.save();
                                        if (_vcStart != null &&
                                            _vcStartTime != null &&
                                            _vcEnd != null &&
                                            _vcEndTime != null) {
                                          context
                                              .bloc<LiveClassCubit>()
                                              .sendLiveClass(
                                                  _title,
                                                  _description,
                                                  _vcStart
                                                      .add(Duration(
                                                          hours:
                                                              _vcStartTime.hour,
                                                          minutes: _vcStartTime
                                                              .hour))
                                                      .toString(),
                                                  students,
                                                  _vcEnd
                                                      .add(Duration(
                                                          hours:
                                                              _vcEndTime.hour,
                                                          minutes:
                                                              _vcEndTime.hour))
                                                      .toString());
                                        } else {
                                          Toast.show(
                                              'Please Double Check the Entries ',
                                              context);
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Create',
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: BlocBuilder(
                            //todo change
                            cubit: context.bloc<SendAssessmentCubit>()
                              ..getSections(71),
                            builder: (BuildContext context, state) {
                              if (state is SendAssessmentSectionsFetched) {
                                context
                                    .bloc<SelectStudentsCubit>()
                                    .getStudentsInASection(
                                        state.sectionEntity.data[0].id, 1);
                                int enabledSectionId =
                                    state.sectionEntity.data[0].id;
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: screenSize.width * 0.1,
                                      child: StatefulBuilder(
                                        builder: (BuildContext context,
                                            void Function(void Function())
                                                setState) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                state.sectionEntity.data.length,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                ListTile(
                                              hoverColor: Colors.white,
                                              selected: enabledSectionId ==
                                                  state.sectionEntity
                                                      .data[index].id,
                                              title: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                  horizontal: 16.0,
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  state.sectionEntity
                                                      .data[index].name,
                                                  style: enabledSectionId ==
                                                          state.sectionEntity
                                                              .data[index].id
                                                      ? TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 22.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )
                                                      : TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                ),
                                              ),
                                              onTap: () {
                                                enabledSectionId = state
                                                    .sectionEntity
                                                    .data[index]
                                                    .id;
                                                context
                                                    .bloc<SelectStudentsCubit>()
                                                    .getStudentsInASection(
                                                        state.sectionEntity
                                                            .data[index].id,
                                                        1);
                                                setState(
                                                  () {},
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    BlocBuilder(
                                      cubit:
                                          context.bloc<SelectStudentsCubit>(),
                                      builder: (BuildContext context, state) {
                                        if (state
                                            is SelectStudentsStudentsFetched) {
                                          bool selectAll = false;
                                          return StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              return SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    8,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                      child: Row(
                                                        children: [
                                                          Text('Select All'),
                                                          Checkbox(
                                                            value: selectAll,
                                                            onChanged: (flag) {
                                                              flag
                                                                  ? state
                                                                      .studentsEntity
                                                                      .data
                                                                      .forEach(
                                                                      (element) {
                                                                        students
                                                                            .add(
                                                                          element
                                                                              .id,
                                                                        );
                                                                      },
                                                                    )
                                                                  : state
                                                                      .studentsEntity
                                                                      .data
                                                                      .forEach(
                                                                      (element) {
                                                                        students
                                                                            .remove(
                                                                          element
                                                                              .id,
                                                                        );
                                                                      },
                                                                    );
                                                              setState(() {
                                                                selectAll =
                                                                    flag;
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.65,
                                                      child: Scrollbar(
                                                        controller:
                                                            _scrollController,
                                                        isAlwaysShown: true,
                                                        child: ListView.builder(
                                                          controller:
                                                              _scrollController,
                                                          shrinkWrap: true,
                                                          itemCount: state
                                                              .studentsEntity
                                                              .data
                                                              .length,
                                                          itemBuilder: (BuildContext
                                                                      context,
                                                                  int index) =>
                                                              CheckboxListTile(
                                                            title: Text(
                                                              state
                                                                  .studentsEntity
                                                                  .data[index]
                                                                  .name,
                                                            ),
                                                            subtitle: Text(
                                                              state
                                                                  .studentsEntity
                                                                  .data[index]
                                                                  .roll_number,
                                                            ),
                                                            value: students
                                                                .contains(
                                                              state
                                                                  .studentsEntity
                                                                  .data[index]
                                                                  .id,
                                                            ),
                                                            onChanged: (flag) {
                                                              flag
                                                                  ? students
                                                                      .add(
                                                                      state
                                                                          .studentsEntity
                                                                          .data[
                                                                              index]
                                                                          .id,
                                                                    )
                                                                  : students
                                                                      .remove(
                                                                      state
                                                                          .studentsEntity
                                                                          .data[
                                                                              index]
                                                                          .id,
                                                                    );
                                                              setState(() {});
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        )
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
