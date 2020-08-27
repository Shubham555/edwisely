import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PreviewTile extends StatelessWidget {
  final String title;
  final String question;

  PreviewTile({
    @required this.title,
    @required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                question,
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                child: Container(
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: InkWell(
                  child: Container(
                    child: Text(
                      'Duplicate',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  hoverColor: Colors.grey,
                  splashColor: Colors.grey,
                  autofocus: true,
                  mouseCursor: MouseCursor.defer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
