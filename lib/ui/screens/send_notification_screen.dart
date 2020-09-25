import 'package:edwisely/data/provider/selected_page.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:edwisely/ui/widgets_util/text_input.dart';
import 'package:flutter/material.dart';
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

  Size screenSize;
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
          Expanded(
            child: Form(
              key: _formKey,
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
                              //priority toggle button
                              //is comment anonymous checkbox
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //priority widget
                                  Text('Priority'),
                                  Switch(
                                    onChanged: (bool value) => setState(
                                      () => _isPriority = value,
                                    ),
                                    value: _isPriority,
                                  ),
                                  Spacer(),
                                  Text('Comments Anonymous'),
                                  Switch(
                                    onChanged: (bool value) => setState(
                                      () => _isCommentAnonymous = value,
                                    ),
                                    value: _isCommentAnonymous,
                                  ),
                                  //is comment anonymouse wiget
                                ],
                              ),
                              //spacing
                              SizedBox(
                                height: screenSize.height * 0.05,
                              ),
                              //TODO, for  sarthak list of students
                              //TODO, for sarthak choose file
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
                                    'Send Notification',
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
