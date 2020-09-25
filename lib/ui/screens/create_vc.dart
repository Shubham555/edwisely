import 'package:edwisely/data/provider/selected_page.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:edwisely/ui/widgets_util/text_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets_util/navigation_drawer.dart';

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

  DateTime _vcExpiry;
  TimeOfDay _vcExpiryTime;

  Size screenSize;

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
      _vcExpiry = null;
    });
  }

  Future<TimeOfDay> _pickEndTime() async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).catchError(() {
      _vcExpiryTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    print(Provider.of<SelectedPageProvider>(context).selectedPage);
    return Scaffold(
      body: Row(
        children: [
          NavigationDrawer(
            isCollapsed: false,
            key: context.watch<SelectedPageProvider>().navigatorKey,
          ),
          Expanded(
            child: Form(
              key: _formKey,
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
                          width: screenSize.width * 0.2,
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
                                      _vcExpiry = await _pickEndDate();
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    _vcExpiry == null
                                        ? 'Pick Expiry Date'
                                        : DateFormat('EEE d MMM yyyy')
                                            .format(_vcStart),
                                  ),
                                  Spacer(),
                                  //end time picker
                                  IconButton(
                                    icon: Icon(Icons.lock_clock),
                                    onPressed: () async {
                                      _vcExpiryTime = await _pickEndTime();
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    _vcExpiryTime == null
                                        ? 'Pick Expiry Time'
                                        : 'at ${_vcExpiryTime.format(context).toString()}',
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
                                      //TODO, Sarthak bhejde notification
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
                        //TODO, select students
                        Expanded(
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
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
