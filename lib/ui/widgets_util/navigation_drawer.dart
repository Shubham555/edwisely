import 'package:edwisely/ui/screens/authorization/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './side_drawer_item.dart';
import '../../data/provider/selected_page.dart';
import '../../util/router.dart';
import '../../util/theme.dart';

class NavigationDrawer extends StatefulWidget {
  final isCollapsed;
  final bool isHome;

  NavigationDrawer({
    this.isCollapsed = true,
    this.isHome = false,
    Key key,
  });

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool _isNavigationDrawerCollapsed = false;
  int _selectedPage = 0;
  double _sidebarWidth;

  Color _selectedItemColor;

  Size screenSize;
  TextTheme textTheme;

  @override
  void initState() {
    super.initState();

    _isNavigationDrawerCollapsed = widget.isCollapsed;
    if (widget.isHome) {
      _selectedItemColor = EdwiselyTheme.PRIMARY_COLOR;
    }

    Future.delayed(Duration(milliseconds: 100)).then((value) {
      final size = MediaQuery.of(context).size;
      if (size.width < 1366) {
        _isNavigationDrawerCollapsed = true;
      }
    });
  }

  @override
  void didUpdateWidget(covariant NavigationDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);

    final size = MediaQuery.of(context).size;
    if (size.width < 1366) {
      _isNavigationDrawerCollapsed = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;
    _selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;

    if (screenSize.width < 1366) {
      _sidebarWidth = _isNavigationDrawerCollapsed
          ? screenSize.width * 0.1
          : screenSize.width * 0.28;
    } else {
      _sidebarWidth = _isNavigationDrawerCollapsed
          ? screenSize.width * 0.06
          : screenSize.width * 0.15;
    }

    return AnimatedContainer(
      alignment: Alignment.center,
      duration: Duration(milliseconds: 500),
      curve: Curves.linear,
      width: _sidebarWidth,
      height: screenSize.height,
      padding: const EdgeInsets.symmetric(
        vertical: 18.0,
        horizontal: 18.0,
      ),
      decoration: BoxDecoration(
        color: widget.isHome
            ? EdwiselyTheme.BACKGROUND_COLOR
            : EdwiselyTheme.NAV_BAR_COLOR,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //logo here
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            // child: Image.asset(
            //   _isNavigationDrawerCollapsed
            //       ? 'assets/logo/small_logo.png'
            //       : widget.isHome
            //           ? 'assets/logo/big_logo_black.png'
            //           : 'assets/logo/big_logo.png',
            //   fit: BoxFit.contain,
            // ),
            child: Image.asset(
              _isNavigationDrawerCollapsed
                  ? 'assets/logo/small_logo.png'
                  : widget.isHome
                      ? 'assets/logo/big_logo_black.png'
                      : 'assets/logo/big_logo.png',
              fit: BoxFit.scaleDown,
            ),
          ),
          //seperator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(),
          ),
          //list of options
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    final pageProvider = Provider.of<SelectedPageProvider>(
                        context,
                        listen: false);
                    pageProvider.changePage(0);
                    MyRouter().navigateTo(pageProvider.navigatorKey, '/');
                  },
                  child: SideDrawerItem(
                    isCollapsed: _isNavigationDrawerCollapsed,
                    title: 'Home',
                    icon: Icons.home,
                    myIndex: 0,
                    currentIndex: _selectedPage,
                    selectedColor: _selectedItemColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    final pageProvider = Provider.of<SelectedPageProvider>(
                        context,
                        listen: false);
                    pageProvider.changePage(1);
                    MyRouter()
                        .navigateTo(pageProvider.navigatorKey, '/all-courses');
                  },
                  child: SideDrawerItem(
                    isCollapsed: _isNavigationDrawerCollapsed,
                    title: 'All Courses',
                    icon: Icons.import_contacts,
                    myIndex: 1,
                    currentIndex: _selectedPage,
                    selectedColor: _selectedItemColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<SelectedPageProvider>(context, listen: false)
                        .changePage(2);
                    Navigator.of(context).pushNamed('/add-course');
                  },
                  child: SideDrawerItem(
                    isCollapsed: _isNavigationDrawerCollapsed,
                    title: 'Add Course',
                    icon: Icons.book,
                    myIndex: 2,
                    currentIndex: _selectedPage,
                    selectedColor: _selectedItemColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<SelectedPageProvider>(context, listen: false)
                        .changePage(3);
                    Navigator.of(context).pushNamed('/send-assesment');
                  },
                  child: SideDrawerItem(
                    isCollapsed: _isNavigationDrawerCollapsed,
                    title: 'Assessments',
                    icon: Icons.assessment,
                    myIndex: 3,
                    currentIndex: _selectedPage,
                    selectedColor: _selectedItemColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<SelectedPageProvider>(context, listen: false)
                        .changePage(4);
                    Navigator.of(context).pushNamed('/create-live-class');
                  },
                  child: SideDrawerItem(
                    isCollapsed: _isNavigationDrawerCollapsed,
                    title: 'Live Class',
                    icon: Icons.live_tv,
                    myIndex: 4,
                    currentIndex: _selectedPage,
                    selectedColor: _selectedItemColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<SelectedPageProvider>(context, listen: false)
                        .changePage(5);
                    Navigator.of(context).pushNamed('/send-notification');
                  },
                  child: SideDrawerItem(
                    isCollapsed: _isNavigationDrawerCollapsed,
                    title: 'Notify',
                    icon: Icons.send_and_archive,
                    myIndex: 5,
                    currentIndex: _selectedPage,
                    selectedColor: _selectedItemColor,
                  ),
                ),
              ],
            ),
          ),
          Container(height: screenSize.height * 0.12),
          // Spacer(),
          widget.isHome
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: InkWell(
                    onTap: () => setState(() => _isNavigationDrawerCollapsed =
                        !_isNavigationDrawerCollapsed),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn,
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
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 0.0,
              ),
              child: RaisedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  prefs.clear();

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => LoginScreen()));
                },
                child: _isNavigationDrawerCollapsed
                    ? Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: screenSize.height * 0.0225,
                      )
                    : Text(
                        'Logout',
                        style: textTheme.button,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
