import 'package:flutter/material.dart';

class ChoiceTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: Offset.zero,
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      width: 1.8 * MediaQuery.of(context).size.width / 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Your answer here',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.check_box),
            onPressed: null,
          )
        ],
      ),
    );
  }
}
