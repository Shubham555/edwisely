import 'package:flutter/material.dart';

class SideDrawerItem extends StatelessWidget {
  final bool isCollapsed;
  final String title;
  final IconData icon;
  final Function function;

  SideDrawerItem({
    @required this.isCollapsed,
    @required this.title,
    @required this.icon, this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: GestureDetector(
        onTap: function,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            isCollapsed
                ? SizedBox.shrink()
                : SizedBox(
                    width: 22.0,
                  ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              width: isCollapsed ? 0 : null,
              child: isCollapsed
                  ? SizedBox.shrink()
                  : Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
