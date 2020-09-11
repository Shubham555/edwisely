import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:flutter/material.dart';

class AddCourseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigAppBar(
              actions: null,
              titleText: 'Add Courses',
              bottomTab: null,
              appBarSize: MediaQuery.of(context).size.height / 3.5,
              appBarTitle: Text('Edwisely'),
              flatButton: null)
          .build(context),
      body: Column(
        children: [
          Text('Select Course That you Teach'),

        ],
      ),
    );
  }
}
