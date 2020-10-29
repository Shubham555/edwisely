import 'package:edwisely/util/router.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../data/cubits/notification_cubit.dart';
import '../../data/cubits/select_students_cubit.dart';
import '../../data/cubits/send_assessment_cubit.dart';
import '../../data/provider/selected_page.dart';
import '../widgets_util/big_app_bar.dart';
import '../widgets_util/navigation_drawer.dart';
import '../widgets_util/text_input.dart';
import './this_way_up.dart';

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

    return oneWay(context)
        ? ThisWayUp()
        : WillPopScope(
            onWillPop: () async {
              Provider.of<SelectedPageProvider>(context, listen: false).setPreviousIndex();
              return true;
            },
            child: Scaffold(
              body: Row(
                children: [
                  NavigationDrawer(
                    isCollapsed: screenSize.width <= 1366 ? true : false,
                    key: context.watch<SelectedPageProvider>().navigatorKey,
                  ),
                  BlocListener(
                    cubit: context.bloc<NotificationCubit>(),
                    listener: (BuildContext context, state) {
                      if (state is NotificationSent) {
                        final form = _formKey.currentState;

                        form.reset();

                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(
                              'Edwisely',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            content: Text('Notification is been sent to all selected students !'),
                            actions: [
                              FlatButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Okay !'),
                              ),
                            ],
                          ),
                        ).then((value) {
                          final pageProvider = Provider.of<SelectedPageProvider>(context, listen: false);
                          pageProvider.changePage(0);
                          MyRouter().navigateTo(pageProvider.navigatorKey, '/');
                        });

                        // Scaffold.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text('Notification Sent'),
                        //   ),
                        // );

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
                            flatButton: RaisedButton(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              onPressed: () {
                                final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  context.bloc<NotificationCubit>().sendNotification(
                                        _title,
                                        _description,
                                        _isPriority ? 1 : 0,
                                        _isCommentAnonymous ? 1 : 0,
                                        students,
                                        file,
                                      );
                                }
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/send.png',
                                    color: Colors.white,
                                    height: 24.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Send',
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            route: 'Home > Send Notification',
                          ).build(context),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: screenSize.width * 0.155,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: screenSize.width * 0.3,
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //spacing
                                          SizedBox(
                                            height: screenSize.height * 0.02,
                                          ),
                                          //title
                                          TextInput(
                                            label: 'Title',
                                            hint: 'Enter your title here',
                                            inputType: TextInputType.text,
                                            autofocus: true,
                                            onSaved: (String value) => _title = value.trim(),
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
                                            onSaved: (String value) => _description = value.trim(),
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
                                          //priority toggle button
                                          //is comment anonymous checkbox
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              //priority widget
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  StatefulBuilder(builder: (context, setState) {
                                                    return Row(
                                                      children: [
                                                        Text(
                                                          'Priority',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        Switch(
                                                          onChanged: (bool value) => setState(
                                                            () => _isPriority = value,
                                                          ),
                                                          value: _isPriority,
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                                  //is comment anonymous widget
                                                  StatefulBuilder(builder: (context, setState) {
                                                    return Row(
                                                      children: [
                                                        Text(
                                                          'Anonymous comments',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        Switch(
                                                          onChanged: (bool value) => setState(
                                                            () => _isCommentAnonymous = value,
                                                          ),
                                                          value: _isCommentAnonymous,
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                                ],
                                              ),
                                              //spacing
                                              Spacer(),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 8.0),
                                                    child: Text('Select Attachment'),
                                                  ),
                                                  StatefulBuilder(
                                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                                      return InkWell(
                                                        onTap: () async {
                                                          file = await FilePickerCross.importFromStorage(
                                                            type: FileTypeCross.any,
                                                          );
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          width: screenSize.width * 0.08,
                                                          height: screenSize.height * 0.05,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            border: Border.all(
                                                              color: Colors.black,
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                          alignment: Alignment.center,
                                                          child: file != null
                                                              ? Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  children: [
                                                                    Text(
                                                                      file.fileName,
                                                                      overflow: TextOverflow.ellipsis,
                                                                    ),
                                                                    IconButton(
                                                                      icon: Icon(Icons.close),
                                                                      onPressed: () {
                                                                        setState(() => file = null);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              : Image.asset(
                                                                  'assets/icons/upload.png',
                                                                  width: 18.0,
                                                                  height: 24.0,
                                                                ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          //spacing
                                          SizedBox(
                                            height: screenSize.height * 0.01,
                                          ),
                                          Text('Class Select',
                                              style: Theme.of(context).textTheme.headline6.copyWith(
                                                    color: Colors.black,
                                                  )),
                                          BlocBuilder(
                                            cubit: context.bloc<SendAssessmentCubit>()..getSections(71),
                                            builder: (BuildContext context, state) {
                                              if (state is SendAssessmentSectionsFetched) {
                                                context.bloc<SelectStudentsCubit>().getStudentsInASection(
                                                      state.sectionEntity.data[0].id,
                                                      1,
                                                    );
                                                int enabledSectionId = state.sectionEntity.data[0].id;
                                                return Container(
                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(12.0),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 0.5,
                                                    ),
                                                  ),
                                                  child: StatefulBuilder(
                                                    builder: (
                                                      BuildContext context,
                                                      void Function(void Function()) setState,
                                                    ) {
                                                      return ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: state.sectionEntity.data.length,
                                                        itemBuilder: (
                                                          BuildContext context,
                                                          int index,
                                                        ) =>
                                                            Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              enabledSectionId = state.sectionEntity.data[index].id;
                                                              context
                                                                  .bloc<SelectStudentsCubit>()
                                                                  .getStudentsInASection(state.sectionEntity.data[index].id, 1);
                                                              setState(() {});
                                                            },
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                AnimatedDefaultTextStyle(
                                                                  duration: Duration(milliseconds: 300),
                                                                  style: enabledSectionId == state.sectionEntity.data[index].id
                                                                      ? TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 16.0,
                                                                          fontWeight: FontWeight.bold,
                                                                        )
                                                                      : TextStyle(
                                                                          color: Colors.grey,
                                                                          fontSize: 14.0,
                                                                          fontWeight: FontWeight.normal,
                                                                        ),
                                                                  child: Text(
                                                                    state.sectionEntity.data[index].name,
                                                                  ),
                                                                ),
                                                                SizedBox(height: 2.0),
                                                                AnimatedContainer(
                                                                  duration: Duration(
                                                                    milliseconds: 300,
                                                                  ),
                                                                  width: enabledSectionId == state.sectionEntity.data[index].id ? 80.0 : 40.0,
                                                                  height: 3.0,
                                                                  color: Theme.of(context).primaryColor,
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
                                        ],
                                      ),
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
                                                height: MediaQuery.of(context).size.height * 0.73,
                                                width: MediaQuery.of(context).size.width / 8,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12.0),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 0.5,
                                                    )),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: MediaQuery.of(context).size.height * 0.07,
                                                      padding: const EdgeInsets.symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 22.0,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context).primaryColor,
                                                        borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(12.0),
                                                          topRight: Radius.circular(12.0),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
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
                                                                  ? state.studentsEntity.data.forEach(
                                                                      (element) {
                                                                        students.add(
                                                                          element.id,
                                                                        );
                                                                      },
                                                                    )
                                                                  : state.studentsEntity.data.forEach(
                                                                      (element) {
                                                                        students.remove(
                                                                          element.id,
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
                                                      height: MediaQuery.of(context).size.height * 0.65,
                                                      child: Scrollbar(
                                                        controller: _scrollController,
                                                        isAlwaysShown: true,
                                                        child: ListView.builder(
                                                          controller: _scrollController,
                                                          shrinkWrap: true,
                                                          itemCount: state.studentsEntity.data.length,
                                                          itemBuilder: (
                                                            BuildContext context,
                                                            int index,
                                                          ) =>
                                                              Container(
                                                            padding: const EdgeInsets.symmetric(
                                                              horizontal: 22.0,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              color: index % 2 == 0 ? Colors.white : Theme.of(context).primaryColor.withOpacity(0.1),
                                                              border: Border.all(
                                                                color: Colors.black,
                                                                width: 0.2,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundColor: Theme.of(context).primaryColor,
                                                                  child: Text(
                                                                    state.studentsEntity.data[index].name.substring(0, 1).toUpperCase(),
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  child: CheckboxListTile(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
