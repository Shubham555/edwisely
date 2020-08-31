import 'package:edwisely/swatches/gradients.dart';
import 'package:edwisely/widgets/dashboard/gradientBanner.dart';
import 'package:edwisely/widgets/elements/borderButton.dart';
import 'package:edwisely/widgets/dashboard/whiteAppBar.dart';
import 'package:edwisely/widgets/elements/gradientChip.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors
              .black, //Setting the hamburger icon color to black from default black
        ),
        flexibleSpace: WhiteAppBar(
          title: 'Dashboard',
          flatbutton: FlatButton(
            child: Text('Button'),
            onPressed: () {},
          ),
          borderButton: BorderButton(
            label: 'Button',
            onPressed: null,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            GradientBanner(
              title: 'Database Management Systems',
              subject: 'Computer Science and Engineering',
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            ),
          ],
        ),
      ),
    );
  }
}
