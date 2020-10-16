import 'package:edwisely/data/model/assessment/studentsSection/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../../data/cubits/select_students_cubit.dart';
import '../../../../data/cubits/send_assessment_cubit.dart';
import '../../../../data/provider/selected_page.dart';
import '../../../widgets_util/big_app_bar.dart';
import '../../../widgets_util/navigation_drawer.dart';
import '../assessmentLandingScreen/assessment_landing_screen.dart';

class SendAssessmentScreen extends StatefulWidget {
  final int assessmentId;
  final String title;
  final String description;

  SendAssessmentScreen(this.assessmentId, this.title, this.description);

  @override
  _SendAssessmentScreenState createState() => _SendAssessmentScreenState();
}

class _SendAssessmentScreenState extends State<SendAssessmentScreen> {
  final ScrollController _scrollController = ScrollController();

  List<int> students = [];
  DateTime _testStart;
  TimeOfDay _testStartTime;

  DateTime _testExpiry;
  TimeOfDay _testExpiryTime;

  Duration _testDuration;
  List<int> questions;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

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
      child: WillPopScope(
        onWillPop: () async {
          Provider.of<SelectedPageProvider>(context, listen: false)
              .setPreviousIndex();
          return true;
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
                      route: 'Home > Send Assessment',
                      flatButton: RaisedButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        onPressed: () {
                          // TODO: 10/4/2020 add validations
                          context.bloc<SendAssessmentCubit>().sendAssessment(
                                widget.title,
                                widget.description,
                                _testExpiry.toString(),
                                _testDuration.toString(),
                                students,
                                widget.assessmentId,
                                _testStart.toString(),
                              );
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/send.png',
                              color: Colors.white,
                              height: 24.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Send',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ],
                        ),
                      ),
                      appBarSize: MediaQuery.of(context).size.height / 3.0,
                    ).build(context),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: MediaQuery.of(context).size.width * 0.17,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Test Details',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 12.0,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 0.5,
                                      )),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      StatefulBuilder(
                                        builder: (BuildContext context,
                                            void Function(void Function())
                                                setState) {
                                          return Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Start Date :     ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () async {
                                                  _testStart =
                                                      await showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  DateTime.now(),
                                                              firstDate:
                                                                  DateTime.now()
                                                                      .subtract(
                                                                Duration(
                                                                    days: 100),
                                                              ),
                                                              lastDate:
                                                                  DateTime.now()
                                                                      .add(
                                                                Duration(
                                                                    days: 100),
                                                              ))
                                                          .whenComplete(
                                                              () async {
                                                    _testStartTime =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                TimeOfDay
                                                                    .now());
                                                  }).catchError(() {
                                                    _testStart = null;
                                                    _testStartTime = null;
                                                  });
                                                  setState(() {});
                                                },
                                                child: Text(
                                                  _testStart == null
                                                      ? 'Pick Start Date  '
                                                      : DateFormat(
                                                              'EEE d MMM yyyy')
                                                          .format(_testStart),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 18.0,
                                                child: VerticalDivider(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  thickness: 2.0,
                                                ),
                                              ),
                                              Text(
                                                _testStartTime == null
                                                    ? 'Pick Start Time'
                                                    : 'at ${_testStartTime.format(context).toString()}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      StatefulBuilder(
                                        builder: (BuildContext context,
                                            void Function(void Function())
                                                setState) {
                                          return Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Expiry Date :   ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () async {
                                                  if (_testStart == null ||
                                                      _testStartTime == null) {
                                                    Scaffold.of(context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Select Starting Date and time first',
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    _testExpiry =
                                                        await showDatePicker(
                                                                context: context,
                                                                initialDate:
                                                                    _testStart,
                                                                firstDate:
                                                                    _testStart,
                                                                lastDate:
                                                                    DateTime.now()
                                                                        .add(
                                                                  Duration(
                                                                      days:
                                                                          100),
                                                                ))
                                                            .whenComplete(
                                                                () async {
                                                      _testExpiryTime =
                                                          await showTimePicker(
                                                              context: context,
                                                              initialTime:
                                                                  _testStartTime);
                                                    }).catchError(() {
                                                      _testExpiry = null;
                                                      _testExpiryTime = null;
                                                    });
                                                  }

                                                  setState(() {});
                                                },
                                                child: Text(
                                                  _testExpiry == null
                                                      ? 'Pick Expiry Date'
                                                      : DateFormat(
                                                              'EEE d MMM yyyy')
                                                          .format(_testExpiry),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 18.0,
                                                child: VerticalDivider(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  thickness: 2.0,
                                                ),
                                              ),
                                              Text(
                                                _testExpiryTime == null
                                                    ? 'Pick Expiry Time'
                                                    : 'at ${_testExpiryTime.format(context).toString()}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      StatefulBuilder(
                                        builder: (BuildContext context,
                                            void Function(void Function())
                                                setState) {
                                          return Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Duration:         ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () async {
                                                  _testDuration =
                                                      await showDurationPicker(
                                                    context: context,
                                                    initialTime:
                                                        Duration(minutes: 30),
                                                  );
                                                  setState(() {});
                                                },
                                                child: Text(
                                                  _testDuration == null
                                                      ? 'Pick Duration'
                                                      : '${_testDuration.inMinutes.toString()} Minutes',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12.0),
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
                                  cubit: context.bloc<SendAssessmentCubit>()
                                    ..getSections(71),
                                  builder: (BuildContext context, state) {
                                    if (state
                                        is SendAssessmentSectionsFetched) {
                                      context
                                          .bloc<SelectStudentsCubit>()
                                          .getStudentsInASection(
                                            state.sectionEntity.data[0].id,
                                            1,
                                          );
                                      int enabledSectionId =
                                          state.sectionEntity.data[0].id;
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 12.0,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: StatefulBuilder(
                                          builder: (
                                            BuildContext context,
                                            void Function(void Function())
                                                setState,
                                          ) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: state
                                                  .sectionEntity.data.length,
                                              itemBuilder: (
                                                BuildContext context,
                                                int index,
                                              ) =>
                                                  Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 12.0,
                                                  horizontal: 22.0,
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    enabledSectionId = state
                                                        .sectionEntity
                                                        .data[index]
                                                        .id;
                                                    context
                                                        .bloc<
                                                            SelectStudentsCubit>()
                                                        .getStudentsInASection(
                                                            state.sectionEntity
                                                                .data[index].id,
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
                                                            milliseconds: 300),
                                                        style: enabledSectionId ==
                                                                state
                                                                    .sectionEntity
                                                                    .data[index]
                                                                    .id
                                                            ? TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 22.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )
                                                            : TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        child: Text(
                                                          state.sectionEntity
                                                              .data[index].name,
                                                        ),
                                                      ),
                                                      SizedBox(height: 2.0),
                                                      AnimatedContainer(
                                                        duration: Duration(
                                                          milliseconds: 300,
                                                        ),
                                                        width: enabledSectionId ==
                                                                state
                                                                    .sectionEntity
                                                                    .data[index]
                                                                    .id
                                                            ? 80.0
                                                            : 40.0,
                                                        height: 3.0,
                                                        color: Theme.of(context)
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
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                                Text(
                                  'Total Students Selected',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 12.0,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 0.5,
                                      )),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BlocBuilder(
                                        builder: (BuildContext context, state) {
                                          if (state is StudentsCountUpdated) {
                                            return Text(
                                              state.students.length.toString(),
                                              style: TextStyle(
                                                fontSize: 30,
                                              ),
                                            );
                                          }
                                          if (state is StudentsCountInitial) {
                                            return Text(
                                              '0',
                                              style: TextStyle(
                                                fontSize: 30,
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                        cubit:
                                            context.bloc<StudentsCountCubit>(),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: BlocBuilder(
                              cubit: context.bloc<SelectStudentsCubit>(),
                              builder: (BuildContext context, state) {
                                if (state is SelectStudentsStudentsFetched) {
                                  bool selectAll = false;
                                  return StatefulBuilder(
                                    builder: (BuildContext context, setState) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 32.0,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.73,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 0.5,
                                            )),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.07,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 16.0,
                                                horizontal: 22.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(12.0),
                                                  topRight:
                                                      Radius.circular(12.0),
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 8.0),
                                                  Text(
                                                    'Students',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
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
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    value: selectAll,
                                                    onChanged: (flag) {
                                                      flag
                                                          ? context
                                                              .bloc<
                                                                  StudentsCountCubit>()
                                                              .addAllStudents(
                                                                  state
                                                                      .studentsEntity
                                                                      .data,
                                                                  students)
                                                          : context
                                                              .bloc<
                                                                  StudentsCountCubit>()
                                                              .removeAllStudents(
                                                                  state
                                                                      .studentsEntity
                                                                      .data,
                                                                  students);
                                                      setState(() {
                                                        selectAll = flag;
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.65,
                                              child: Scrollbar(
                                                controller: _scrollController,
                                                isAlwaysShown: true,
                                                child: ListView.builder(
                                                  controller: _scrollController,
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 22.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: index % 2 == 0
                                                          ? Colors.white
                                                          : Theme.of(context)
                                                              .primaryColor
                                                              .withOpacity(0.1),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        width: 0.2,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          child: Text(
                                                            state
                                                                .studentsEntity
                                                                .data[index]
                                                                .name
                                                                .substring(0, 1)
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child:
                                                              CheckboxListTile(
                                                            activeColor: Theme
                                                                    .of(context)
                                                                .primaryColor,
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
                                                                  ? context.bloc<StudentsCountCubit>().addStudent(
                                                                      state
                                                                          .studentsEntity
                                                                          .data[
                                                                              index]
                                                                          .id,
                                                                      students)
                                                                  : context
                                                                      .bloc<
                                                                          StudentsCountCubit>()
                                                                      .removeStudent(
                                                                          state
                                                                              .studentsEntity
                                                                              .data[index]
                                                                              .id,
                                                                          students);
                                                              setState(() {});
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
                          ),
                        ],
                      ),
                    ),
                    // BlocBuilder(
                    //   cubit: context.bloc<SendAssessmentCubit>()..getSections(71),
                    //   builder: (BuildContext context, state) {
                    //     if (state is SendAssessmentSectionsFetched) {
                    //       context
                    //           .bloc<SelectStudentsCubit>()
                    //           .getStudentsInASection(
                    //               state.sectionEntity.data[0].id, 1);
                    //       int enabledSectionId = state.sectionEntity.data[0].id;
                    //       return Padding(
                    //         padding: EdgeInsets.symmetric(
                    //           horizontal:
                    //               MediaQuery.of(context).size.width * 0.17,
                    //         ),
                    //         child: Row(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Container(
                    //               width: MediaQuery.of(context).size.width / 7,
                    //               child: StatefulBuilder(
                    //                 builder: (BuildContext context,
                    //                     void Function(void Function()) setState) {
                    //                   return ListView.builder(
                    //                     shrinkWrap: true,
                    //                     itemCount:
                    //                         state.sectionEntity.data.length,
                    //                     itemBuilder:
                    //                         (BuildContext context, int index) =>
                    //                             ListTile(
                    //                       hoverColor: Colors.white,
                    //                       selected: enabledSectionId ==
                    //                           state.sectionEntity.data[index].id,
                    //                       title: Container(
                    //                         padding: const EdgeInsets.symmetric(
                    //                           vertical: 8.0,
                    //                           horizontal: 16.0,
                    //                         ),
                    //                         alignment: Alignment.center,
                    //                         child: Text(
                    //                           state
                    //                               .sectionEntity.data[index].name,
                    //                           style: enabledSectionId ==
                    //                                   state.sectionEntity
                    //                                       .data[index].id
                    //                               ? TextStyle(
                    //                                   color: Colors.black,
                    //                                   fontSize: 22.0,
                    //                                   fontWeight: FontWeight.bold,
                    //                                 )
                    //                               : TextStyle(
                    //                                   color: Colors.grey,
                    //                                   fontSize: 20.0,
                    //                                   fontWeight:
                    //                                       FontWeight.normal,
                    //                                 ),
                    //                         ),
                    //                       ),
                    //                       onTap: () {
                    //                         enabledSectionId = state
                    //                             .sectionEntity.data[index].id;
                    //                         context
                    //                             .bloc<SelectStudentsCubit>()
                    //                             .getStudentsInASection(
                    //                                 state.sectionEntity
                    //                                     .data[index].id,
                    //                                 1);
                    //                         setState(
                    //                           () {},
                    //                         );
                    //                       },
                    //                     ),
                    //                   );
                    //                 },
                    //               ),
                    //             ),
                    //             BlocBuilder(
                    //               cubit: context.bloc<SelectStudentsCubit>(),
                    //               builder: (BuildContext context, state) {
                    //                 if (state is SelectStudentsStudentsFetched) {
                    //                   bool selectAll = false;
                    //                   return StatefulBuilder(
                    //                     builder:
                    //                         (BuildContext context, setState) {
                    //                       return SizedBox(
                    //                         height: MediaQuery.of(context)
                    //                                 .size
                    //                                 .height *
                    //                             0.7,
                    //                         width: MediaQuery.of(context)
                    //                                 .size
                    //                                 .width *
                    //                             0.25,
                    //                         child: Column(
                    //                           children: [
                    //                             SizedBox(
                    //                               height: MediaQuery.of(context)
                    //                                       .size
                    //                                       .height *
                    //                                   0.05,
                    //                               child: Row(
                    //                                 children: [
                    //                                   Text('Select All'),
                    //                                   Checkbox(
                    //                                     value: selectAll,
                    //                                     onChanged: (flag) {
                    //                                       flag
                    //                                           ? state
                    //                                               .studentsEntity
                    //                                               .data
                    //                                               .forEach(
                    //                                               (element) {
                    //                                                 students.add(
                    //                                                   element.id,
                    //                                                 );
                    //                                               },
                    //                                             )
                    //                                           : state
                    //                                               .studentsEntity
                    //                                               .data
                    //                                               .forEach(
                    //                                               (element) {
                    //                                                 students
                    //                                                     .remove(
                    //                                                   element.id,
                    //                                                 );
                    //                                               },
                    //                                             );
                    //                                       setState(() {
                    //                                         selectAll = flag;
                    //                                       });
                    //                                     },
                    //                                   )
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                             SizedBox(
                    //                               height: MediaQuery.of(context)
                    //                                       .size
                    //                                       .height *
                    //                                   0.65,
                    //                               child: Scrollbar(
                    //                                 controller: _scrollController,
                    //                                 isAlwaysShown: true,
                    //                                 child: ListView.builder(
                    //                                   controller:
                    //                                       _scrollController,
                    //                                   shrinkWrap: true,
                    //                                   itemCount: state
                    //                                       .studentsEntity
                    //                                       .data
                    //                                       .length,
                    //                                   itemBuilder:
                    //                                       (BuildContext context,
                    //                                               int index) =>
                    //                                           CheckboxListTile(
                    //                                     title: Text(
                    //                                       state.studentsEntity
                    //                                           .data[index].name,
                    //                                     ),
                    //                                     subtitle: Text(
                    //                                       state
                    //                                           .studentsEntity
                    //                                           .data[index]
                    //                                           .roll_number,
                    //                                     ),
                    //                                     value: students.contains(
                    //                                       state.studentsEntity
                    //                                           .data[index].id,
                    //                                     ),
                    //                                     onChanged: (flag) {
                    //                                       flag
                    //                                           ? students.add(
                    //                                               state
                    //                                                   .studentsEntity
                    //                                                   .data[index]
                    //                                                   .id,
                    //                                             )
                    //                                           : students.remove(
                    //                                               state
                    //                                                   .studentsEntity
                    //                                                   .data[index]
                    //                                                   .id,
                    //                                             );
                    //                                       setState(() {});
                    //                                     },
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       );
                    //                     },
                    //                   );
                    //                 } else {
                    //                   return Center(
                    //                     child: CircularProgressIndicator(),
                    //                   );
                    //                 }
                    //               },
                    //             )
                    //           ],
                    //         ),
                    //       );
                    //     } else {
                    //       return Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     }
                    //   },
                    // )
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

// cubit for students

class StudentsCountCubit extends Cubit<StudentsCountState> {
  StudentsCountCubit() : super(StudentsCountInitial());

  addStudent(int id, List<int> students) {
    students.add(id);
    emit(
      StudentsCountUpdated(
        students,
      ),
    );
  }

  removeStudent(int id, List<int> students) {
    students.remove(id);
    emit(
      StudentsCountUpdated(
        students,
      ),
    );
  }

  removeAllStudents(List<Data> data, List<int> students) {
    data.forEach((element) {
      students.remove(element.id);
    });
    emit(
      StudentsCountUpdated(
        students,
      ),
    );
  }

  addAllStudents(List<Data> data, List<int> students) {
    data.forEach((element) {
      students.add(element.id);
    });
    emit(
      StudentsCountUpdated(
        students,
      ),
    );
  }
}

@immutable
abstract class StudentsCountState {}

class StudentsCountInitial extends StudentsCountState {}

class StudentsCountUpdated extends StudentsCountState {
  final List<int> students;

  StudentsCountUpdated(this.students);
}
