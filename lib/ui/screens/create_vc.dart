import 'package:edwisely/main.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
import './this_way_up.dart';

class CreateVCScreen extends StatefulWidget {
  @override
  _CreateVCScreenState createState() => _CreateVCScreenState();
}

class _CreateVCScreenState extends State<CreateVCScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      firstDate: DateTime.now(),
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
            firstDate: _vcStart,
            lastDate: _vcStart)
        .catchError(() {
      _vcEnd = null;
    });
  }

  Future<TimeOfDay> _pickEndTime() async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).catchError(() {
      _vcEndTime = null;
    // ignore: missing_return
    }).then((value) {
      if (value.hour - _vcStartTime.hour > 3) {
        Get.defaultDialog(
            title: 'Select time less than 3 hours',
            onConfirm: () => Get.back(),
            middleText: '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return oneWay(context)
        ? ThisWayUp()
        : WillPopScope(
            onWillPop: () async {
              Provider.of<SelectedPageProvider>(context, listen: false)
                  .setPreviousIndex();
              return true;
            },
            child: Scaffold(
              key: _scaffoldKey,
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
                      isCollapsed: screenSize.width <= 1366 ? true : false,
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
                            flatButton: RaisedButton(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
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
                                                    hours: _vcStartTime.hour,
                                                    minutes: _vcStartTime.hour))
                                                .toString(),
                                            students,
                                            _vcEnd
                                                .add(Duration(
                                                    hours: _vcEndTime.hour,
                                                    minutes: _vcEndTime.hour))
                                                .toString());
                                  } else {
                                    Toast.show(
                                        'Please Double Check the Entries ',
                                        context);
                                  }
                                }
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/create_vc.png',
                                    color: Colors.white,
                                    height: 24.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      'Create',
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            route: 'Home > Create Virtual Class',
                          ).build(context),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: screenSize.width * 0.155,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: screenSize.width * 0.3,
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                          height: screenSize.height * 0.01,
                                        ),
                                        //description
                                        TextInput(
                                          label: 'Description',
                                          hint: 'Enter the description here',
                                          inputType: TextInputType.multiline,
                                          maxLines: 3,
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
                                          height: screenSize.height * 0.01,
                                        ),
                                        //start and end time
                                        Text(
                                          'Class Details',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                color: Colors.black,
                                              ),
                                        ),
                                        StatefulBuilder(
                                          builder: (BuildContext context,
                                              void Function(void Function())
                                                  setState) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 12.0,
                                                horizontal: 12.0,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      //start date picker
                                                      Text(
                                                        'Start Date :',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () async {
                                                          _vcStart =
                                                              await _pickStartDate();
                                                          _vcStartTime =
                                                              await _pickStartTime();
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                          _vcStart == null
                                                              ? 'Pick Date'
                                                              : DateFormat(
                                                                      'EEE d MMM yyyy')
                                                                  .format(
                                                                      _vcStart),
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 18.0,
                                                        child: VerticalDivider(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          thickness: 2.0,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          _vcStartTime =
                                                              await _pickStartTime();
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                          _vcStartTime == null
                                                              ? 'Pick Time'
                                                              : 'at ${_vcStartTime.format(context).toString()}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  //end time
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      //expiry date
                                                      Text(
                                                        'Expiry Date :',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () async {
                                                          if (_vcStart ==
                                                              null) {
                                                            _scaffoldKey
                                                                .currentState
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text('Select Start Date First !')));
                                                          } else {
                                                            _vcEnd =
                                                                await _pickEndDate();
                                                            _vcEndTime =
                                                                await _pickEndTime();
                                                            setState(() {});
                                                          }
                                                        },
                                                        child: Text(
                                                          _vcEnd == null
                                                              ? 'Pick Date'
                                                              : DateFormat(
                                                                      'EEE d MMM yyyy')
                                                                  .format(
                                                                      _vcEnd),
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 18.0,
                                                        child: VerticalDivider(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          thickness: 2.0,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          _vcEndTime =
                                                              await _pickEndTime();
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                          _vcEndTime == null
                                                              ? 'Pick Time'
                                                              : 'at ${_vcEndTime.format(context).toString()}',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        //spacing
                                        SizedBox(
                                          height: screenSize.height * 0.01,
                                        ),
                                        //spacing
                                        Text(
                                          'Class Select',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                color: Colors.black,
                                              ),
                                        ),
                                        BlocBuilder(
                                          cubit: context
                                              .bloc<SendAssessmentCubit>()
                                                ..getSections(71),
                                          builder:
                                              (BuildContext context, state) {
                                            if (state
                                                is SendAssessmentSectionsFetched) {
                                              context
                                                  .bloc<SelectStudentsCubit>()
                                                  .getStudentsInASection(
                                                    state.sectionEntity.data[0]
                                                        .id,
                                                    1,
                                                  );
                                              int enabledSectionId = state
                                                  .sectionEntity.data[0].id;
                                              return Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 0.5,
                                                  ),
                                                ),
                                                child: StatefulBuilder(
                                                  builder: (
                                                    BuildContext context,
                                                    void Function(
                                                            void Function())
                                                        setState,
                                                  ) {
                                                    return ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: state
                                                          .sectionEntity
                                                          .data
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                                  int index) =>
                                                              Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8.0,
                                                                horizontal:
                                                                    16.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            enabledSectionId =
                                                                state
                                                                    .sectionEntity
                                                                    .data[index]
                                                                    .id;
                                                            context
                                                                .bloc<
                                                                    SelectStudentsCubit>()
                                                                .getStudentsInASection(
                                                                    state
                                                                        .sectionEntity
                                                                        .data[
                                                                            index]
                                                                        .id,
                                                                    1);
                                                            setState(() {});
                                                          },
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              AnimatedDefaultTextStyle(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        300),
                                                                style: enabledSectionId ==
                                                                        state
                                                                            .sectionEntity
                                                                            .data[index]
                                                                            .id
                                                                    ? TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      )
                                                                    : TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            14.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                child: Text(
                                                                  state
                                                                      .sectionEntity
                                                                      .data[
                                                                          index]
                                                                      .name,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 2.0),
                                                              AnimatedContainer(
                                                                duration:
                                                                    Duration(
                                                                  milliseconds:
                                                                      300,
                                                                ),
                                                                width: enabledSectionId ==
                                                                        state
                                                                            .sectionEntity
                                                                            .data[index]
                                                                            .id
                                                                    ? 80.0
                                                                    : 40.0,
                                                                height: 3.0,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: BlocBuilder(
                                    cubit: context.bloc<SelectStudentsCubit>(),
                                    builder: (BuildContext context, state) {
                                      if (state
                                          is SelectStudentsStudentsFetched) {
                                        bool selectAll = students
                                            .toSet()
                                            .containsAll(state
                                                .studentsEntity.data
                                                .map((e) => e.id));
                                        return StatefulBuilder(
                                          builder:
                                              (BuildContext context, setState) {
                                            return Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 32.0,
                                              ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.73,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 0.5,
                                                  )),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.07,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 16.0,
                                                      horizontal: 22.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                12.0),
                                                        topRight:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(width: 8.0),
                                                        Text(
                                                          'Students',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        VerticalDivider(
                                                          color: Colors.white,
                                                          thickness: 2.0,
                                                          indent: 8.0,
                                                          endIndent: 8.0,
                                                        ),
                                                        SizedBox(width: 8.0),
                                                        Text(
                                                          'Select All',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
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
                                                              selectAll = flag;
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
                                                        itemBuilder: (
                                                          BuildContext context,
                                                          int index,
                                                        ) =>
                                                            Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 22.0,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: index % 2 ==
                                                                    0
                                                                ? Colors.white
                                                                : Theme.of(
                                                                        context)
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        0.1),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 0.2,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                child: Text(
                                                                  state
                                                                      .studentsEntity
                                                                      .data[
                                                                          index]
                                                                      .name
                                                                      .substring(
                                                                          0, 1)
                                                                      .toUpperCase(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child:
                                                                    CheckboxListTile(
                                                                  title: Text(
                                                                    state
                                                                        .studentsEntity
                                                                        .data[
                                                                            index]
                                                                        .name,
                                                                  ),
                                                                  subtitle:
                                                                      Text(
                                                                    state
                                                                        .studentsEntity
                                                                        .data[
                                                                            index]
                                                                        .roll_number,
                                                                  ),
                                                                  value: students
                                                                      .contains(
                                                                    state
                                                                        .studentsEntity
                                                                        .data[
                                                                            index]
                                                                        .id,
                                                                  ),
                                                                  onChanged:
                                                                      (flag) {
                                                                    flag
                                                                        ? students
                                                                            .add(
                                                                            state.studentsEntity.data[index].id,
                                                                          )
                                                                        : students
                                                                            .remove(
                                                                            state.studentsEntity.data[index].id,
                                                                          );
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
            ),
          );
  }
}
