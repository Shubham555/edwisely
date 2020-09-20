import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideDrawerItem extends StatelessWidget {
  final bool isCollapsed;
  final String title;
  final IconData icon;

  SideDrawerItem({
    @required this.isCollapsed,
    @required this.title,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutBack,
      width: isCollapsed ? screenSize.width * 0.1 : screenSize.width * 0.3,
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //icon
          Icon(
            icon,
            size: screenSize.width * 0.02,
            color: Colors.black,
          ),
          //spacing
          SizedBox(width: 12.0),
          //title
          isCollapsed
              ? SizedBox.shrink()
              : Text(
                title,
                overflow: TextOverflow.ellipsis,
              ),
        ],
      ),
    );
  }
}
