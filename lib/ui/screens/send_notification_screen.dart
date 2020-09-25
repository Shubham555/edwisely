import 'package:edwisely/data/cubits/notification_cubit.dart';
import 'package:edwisely/data/cubits/select_students_cubit.dart';
import 'package:edwisely/data/cubits/send_assessment_cubit.dart';
import 'package:edwisely/data/provider/selected_page.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../widgets_util/navigation_drawer.dart';

class SendNotificationScreen extends StatefulWidget {
  @override
  _SendNotificationScreenState createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  bool _isPriority = false;
  bool _isCommentAnonymous = false;
  FilePickerCross file;
  Size screenSize;
  List<int> students = [];
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          NavigationDrawer(
            isCollapsed: false,
            key: context.watch<SelectedPageProvider>().navigatorKey,
          ),
          BlocListener(
            cubit: context.bloc<NotificationCubit>(),
            listener: (BuildContext context, state) {
              if (state is NotificationSent) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Notification Sent'),
                  ),
                );
              }
              if (state is NotificationSentFailed) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Notification Sending Failed'),
                  ),
                );
              }
            },
            child: Expanded(
              child: Column(
                children: [
                  BigAppBar(
                    actions: null,
                    titleText: 'Send Notification',
                    appBarSize: MediaQuery.of(context).size.height / 3,
                    bottomTab: null,
                    appBarTitle: Text(
                      'Edwisely',
                      style: TextStyle(color: Colors.black),
                    ),
                    flatButton: null,
                  ).build(context),
                  Row(
                    children: [
                      // Form(
                      //   key: _formKey,
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(
                      //       vertical: 12.0,
                      //       horizontal: screenSize.width * 0.17,
                      //     ),
                      //     child: SizedBox(
                      //       width: screenSize.width * 0.2,
                      //       child: Column(
                      //         children: [
                      //           //spacing
                      //           SizedBox(
                      //             height: screenSize.height * 0.05,
                      //           ),
                      //           //title
                      //           TextInput(
                      //             label: 'Title',
                      //             hint: 'Enter your title here',
                      //             inputType: TextInputType.text,
                      //             autofocus: true,
                      //             onSaved: (String value) =>
                      //                 _title = value.trim(),
                      //             validator: (String value) {
                      //               if (value.trim().length == 0) {
                      //                 return 'This field cannot be empty!';
                      //               }
                      //               return null;
                      //             },
                      //           ),
                      //           //spacing
                      //           SizedBox(
                      //             height: screenSize.height * 0.05,
                      //           ),
                      //           //description
                      //           TextInput(
                      //             label: 'Description',
                      //             hint: 'Enter the description here',
                      //             inputType: TextInputType.multiline,
                      //             maxLines: 4,
                      //             onSaved: (String value) =>
                      //                 _description = value.trim(),
                      //             validator: (String value) {
                      //               if (value.trim().length == 0) {
                      //                 return 'This field cannot be empty!';
                      //               }
                      //               return null;
                      //             },
                      //           ),
                      //           //spacing
                      //           SizedBox(
                      //             height: screenSize.height * 0.05,
                      //           ),
                      //           //priority toggle button
                      //           //is comment anonymous checkbox
                      //           Row(
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               //priority widget
                      //               Text('Priority'),
                      //               Switch(
                      //                 onChanged: (bool value) => setState(
                      //                   () => _isPriority = value,
                      //                 ),
                      //                 value: _isPriority,
                      //               ),
                      //               Spacer(),
                      //               Text('Comments Anonymous'),
                      //               Switch(
                      //                 onChanged: (bool value) => setState(
                      //                   () => _isCommentAnonymous = value,
                      //                 ),
                      //                 value: _isCommentAnonymous,
                      //               ),
                      //               //is comment anonymouse wiget
                      //             ],
                      //           ),
                      //           //spacing
                      //           SizedBox(
                      //             height: screenSize.height * 0.05,
                      //           ),
                      //
                      //           Row(
                      //             children: [
                      //               Text('Select Attachment'),
                      //               IconButton(
                      //                 icon: Icon(Icons.add),
                      //                 onPressed: () async {
                      //                   file = await FilePickerCross
                      //                       .importFromStorage(
                      //                     type: FileTypeCross.any,
                      //                   );
                      //                 },
                      //               )
                      //             ],
                      //           ),
                      //           //spacing
                      //           SizedBox(
                      //             height: screenSize.height * 0.05,
                      //           ),
                      //           //send notification button
                      //           Center(
                      //             child: RaisedButton(
                      //               onPressed: () {
                      //                 final form = _formKey.currentState;
                      //
                      //                 if (form.validate()) {
                      //                   form.save();
                      //                   context
                      //                       .bloc<NotificationCubit>()
                      //                       .sendNotification(
                      //                         _title,
                      //                         _description,
                      //                         _isPriority ? 1 : 0,
                      //                         _isCommentAnonymous ? 1 : 0,
                      //                         students,
                      //                         file,
                      //                       );
                      //                 }
                      //               },
                      //               child: Text(
                      //                 'Send Notification',
                      //                 style: Theme.of(context).textTheme.button,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.17,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 7,
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
                                                        .width *
                                                    0.25,
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
                                ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
