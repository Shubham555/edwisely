import 'package:edwisely/data/model/course/courseEntity/data.dart';

class CourseEntity {
  int status;
  String message;
  Data data;

  CourseEntity.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        data = Data.fromJsonMap(map["data"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['data'] = data == null ? null : this.data.toJson();
    return data;
  }
}
