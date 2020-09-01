import 'dart:developer';

import 'package:flutter/material.dart';

class CreateAssessmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: //<editor-fold desc="White AppBar Need to Create a stless when confirmed for use// ">
          AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: Text(
          'Logo here',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            onPressed: () =>
                log('AssessmentLandingPage AppBar actions Clicked'),
            child: Text('Details Here'),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            onPressed: () =>
                log('AssessmentLandingPage AppBar actions Clicked'),
            child: Text('Details Here'),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            onPressed: () =>
                log('AssessmentLandingPage AppBar actions Clicked'),
            child: Text('Details Here'),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            onPressed: () =>
                log('AssessmentLandingPage AppBar actions Clicked'),
            child: Text('Details Here'),
          ),
        ],
      ),
      //</editor-fold>
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.width / 2,
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Create Assessment',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 40),
              ),
              _buildTextFieldWidget('Add Title', 80),
              _buildTextFieldWidget('Description', 200),
              Text(
                'Choose Subject',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 40),
              ),
              Wrap(
                spacing: 6,
                children: [
                  Chip(
                    label: Text('wevewv'),
                  ),
                  Chip(
                    label: Text('wevewv'),
                  ),
                  Chip(
                    label: Text('wevewv'),
                  ),
                  Chip(
                    label: Text('wevewv'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildTextFieldWidget(String title, int maxLength) => Column(
        children: [
          TextField(
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: title,
              border: OutlineInputBorder(),
            ),
            maxLength: maxLength,
          ),
        ],
      );
}
