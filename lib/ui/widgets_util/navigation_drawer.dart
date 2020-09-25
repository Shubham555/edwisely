import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/assessment_landing_screen.dart';
import 'package:edwisely/ui/screens/course/add_course_screen.dart';
import 'package:edwisely/ui/screens/course/courses_landing_screen.dart';
import 'package:edwisely/ui/screens/create_vc.dart';
import 'package:edwisely/ui/screens/send_notification_screen.dart';
import 'package:edwisely/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/provider/selected_page.dart';

import './side_drawer_item.dart';

class NavigationDrawer extends StatefulWidget {
  final isCollapsed;

  NavigationDrawer({
    this.isCollapsed = true,
    Key key,
  }) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool _isNavigationDrawerCollapsed = false;
  int _selectedPage = 0;
  double _sidebarWidth;

  Size screenSize;
  TextTheme textTheme;

  @override
  void initState() {
    super.initState();

    _isNavigationDrawerCollapsed = widget.isCollapsed;
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;
    _selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;

    if (screenSize.width < 1000) {
      _sidebarWidth = _isNavigationDrawerCollapsed
          ? screenSize.width * 0.1
          : screenSize.width * 0.28;
    } else {
      _sidebarWidth = _isNavigationDrawerCollapsed
          ? screenSize.width * 0.06
          : screenSize.width * 0.15;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutBack,
      width: _sidebarWidth,
      height: screenSize.height,
      padding: const EdgeInsets.symmetric(
        vertical: 18.0,
        horizontal: 18.0,
      ),
      decoration: BoxDecoration(
        color: EdwiselyTheme.NAV_BAR_COLOR,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //logo here
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0),
            child: Image.asset(
              _isNavigationDrawerCollapsed
                  ? 'assets/logo/small_logo.png'
                  : 'assets/logo/big_logo.png',
              fit: BoxFit.contain,
            ),
          ),
          //seperator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(),
          ),
          //list of options
          InkWell(
            onTap: () {
              Provider.of<SelectedPageProvider>(context, listen: false)
                  .changePage(0);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CoursesLandingScreen()),
              );
            },
            child: SideDrawerItem(
              isCollapsed: _isNavigationDrawerCollapsed,
              title: 'All Courses',
              icon: Icons.import_contacts,
              myIndex: 0,
              currentIndex: _selectedPage,
            ),
          ),
          InkWell(
            onTap: () {
              Provider.of<SelectedPageProvider>(context, listen: false)
                  .changePage(1);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddCourseScreen()),
              );
            },
            child: SideDrawerItem(
              isCollapsed: _isNavigationDrawerCollapsed,
              title: 'Add Course',
              icon: Icons.book,
              myIndex: 1,
              currentIndex: _selectedPage,
            ),
          ),
          InkWell(
            onTap: () {
              Provider.of<SelectedPageProvider>(context, listen: false)
                  .changePage(2);
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => AssessmentLandingScreen()),
              );
            },
            child: SideDrawerItem(
              isCollapsed: _isNavigationDrawerCollapsed,
              title: 'Assesments',
              icon: Icons.assessment,
              myIndex: 2,
              currentIndex: _selectedPage,
            ),
          ),
          InkWell(
            onTap: () {
              Provider.of<SelectedPageProvider>(context, listen: false)
                  .changePage(3);
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => CreateVCScreen()),
              );
            },
            child: SideDrawerItem(
              isCollapsed: _isNavigationDrawerCollapsed,
              title: 'Live Class',
              icon: Icons.live_tv,
              myIndex: 3,
              currentIndex: _selectedPage,
            ),
          ),
          InkWell(
            onTap: () {
              Provider.of<SelectedPageProvider>(context, listen: false)
                  .changePage(4);
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => SendNotificationScreen()),
              );
            },
            child: SideDrawerItem(
              isCollapsed: _isNavigationDrawerCollapsed,
              title: 'Send Notification',
              icon: Icons.send_and_archive,
              myIndex: 4,
              currentIndex: _selectedPage,
            ),
          ),
          // SideDrawerItem(
          //   isCollapsed: _isNavigationDrawerCollapsed,
          //   title: 'Schedule Event',
          //   icon: Icons.calendar_today,
          //   myIndex: 5,
          //   currentIndex: widget.selectedIndex,
          // ),
          // SideDrawerItem(
          //   isCollapsed: _isNavigationDrawerCollapsed,
          //   title: 'My Assesment',
          //   icon: Icons.assignment_ind,
          //   myIndex: 6,
          //   currentIndex: widget.selectedIndex,
          // ),
          // SideDrawerItem(
          //   isCollapsed: _isNavigationDrawerCollapsed,
          //   title: 'Upcoming Events',
          //   icon: Icons.event,
          //   myIndex: 7,
          //   currentIndex: widget.selectedIndex,
          // ),
          // SideDrawerItem(
          //   isCollapsed: _isNavigationDrawerCollapsed,
          //   title: 'Get Feedback',
          //   icon: Icons.feedback,
          //   myIndex: 8,
          //   currentIndex: widget.selectedIndex,
          // ),
          // SideDrawerItem(
          //   isCollapsed: _isNavigationDrawerCollapsed,
          //   title: 'Recently Viewed',
          //   icon: Icons.schedule,
          //   myIndex: 9,
          //   currentIndex: widget.selectedIndex,
          // ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: InkWell(
              onTap: () => setState(() =>
                  _isNavigationDrawerCollapsed = !_isNavigationDrawerCollapsed),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    width: _isNavigationDrawerCollapsed ? 0 : null,
                    child: _isNavigationDrawerCollapsed
                        ? SizedBox.shrink()
                        : Text(
                            _isNavigationDrawerCollapsed
                                ? 'Expand'
                                : 'Collapse',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Colors.white),
                          ),
                  ),
                  _isNavigationDrawerCollapsed
                      ? SizedBox.shrink()
                      : SizedBox(
                          width: 12.0,
                        ),
                  Icon(
                    _isNavigationDrawerCollapsed
                        ? Icons.arrow_forward_ios
                        : Icons.arrow_back_ios,
                    color: Colors.white,
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
