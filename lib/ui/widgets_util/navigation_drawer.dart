import 'package:flutter/material.dart';

import './side_drawer_item.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool _isSideDrawerCollapsed = true;

  Size screenSize;
  TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutBack,
      width: _isSideDrawerCollapsed
          ? screenSize.width * 0.1
          : screenSize.width * 0.3,
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
      color: Colors.white,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SideDrawerItem(
              isCollapsed: _isSideDrawerCollapsed,
              title: 'Send Notification',
              icon: Icons.notifications_active,
            ),
            SideDrawerItem(
              isCollapsed: _isSideDrawerCollapsed,
              title: 'Get Feedback',
              icon: Icons.feedback,
            ),
            SideDrawerItem(
              isCollapsed: _isSideDrawerCollapsed,
              title: 'Live Class',
              icon: Icons.live_tv,
            ),
            SideDrawerItem(
                isCollapsed: _isSideDrawerCollapsed,
                title: 'Live Assesment',
                icon: Icons.assessment),
            SideDrawerItem(
              isCollapsed: _isSideDrawerCollapsed,
              title: 'Send Assignment',
              icon: Icons.assignment,
            ),
            SideDrawerItem(
              isCollapsed: _isSideDrawerCollapsed,
              title: 'Schedule Event',
              icon: Icons.calendar_today,
            ),
            SideDrawerItem(
              isCollapsed: _isSideDrawerCollapsed,
              title: 'My Assesment',
              icon: Icons.assignment_ind,
            ),
            SideDrawerItem(
              isCollapsed: _isSideDrawerCollapsed,
              title: 'Add Course Material',
              icon: Icons.add,
            ),
            SideDrawerItem(
              isCollapsed: _isSideDrawerCollapsed,
              title: 'Upcoming Events',
              icon: Icons.event,
            ),
            SideDrawerItem(
              isCollapsed: _isSideDrawerCollapsed,
              title: 'Recently Viewed',
              icon: Icons.schedule,
            ),
            //collapse controller
            IconButton(
              padding: const EdgeInsets.all(0),
              icon: Icon(
                _isSideDrawerCollapsed
                    ? Icons.arrow_forward_ios
                    : Icons.arrow_back_ios,
                size: screenSize.width * 0.02,
                color: Colors.black,
              ),
              onPressed: () => setState(
                  () => _isSideDrawerCollapsed = !_isSideDrawerCollapsed),
            ),
          ],
        ),
      ),
    );
  }
}
