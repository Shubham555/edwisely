import 'package:flutter/foundation.dart'; //Import needed for the @required parameters

class Student {
  final String name;
  final String rollNumber;

  Student({
    @required this.name,
    @required this.rollNumber,
  });
}
