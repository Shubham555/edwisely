// Assessment Data Model Class

import 'package:edwisely/models/question.dart';
import 'package:edwisely/models/questionType.dart';
// import 'package:edwisely/models/student.dart';

import 'package:flutter/foundation.dart'; //Import needed for the @required parameters

class Assessment {
  final String title;
  final String description;
  final DateTime deadline;
  final int duration; //Duration of the test In minutes
  final List<Question> questions;
  final QuestionType type;
  // final List<Student>
  //     students; //List of all the students who will receive the test
  // List<Student> answered; //List of the students who have attempted the test
  // List<Student> pending; //List of the students yet to take the test

  Assessment({
    @required this.title,
    @required this.description,
    @required this.deadline,
    @required this.duration,
    @required this.questions,
    @required this.type,
    // @required this.students,
  });
}
