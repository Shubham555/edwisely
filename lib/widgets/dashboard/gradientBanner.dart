// Gradient Banner is the header that contains the course details on the Dashboard Screen

import 'package:edwisely/swatches/gradients.dart';
import 'package:flutter/material.dart';

class GradientBanner extends StatelessWidget {
  final String title;
  final String subject;
  final String content;

  GradientBanner({
    @required this.title,
    @required this.subject,
    @required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        gradient: Gradients.peacock, // Custom gradient - refer swatches folder
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              subject,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            content,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
