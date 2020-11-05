import 'package:edwisely/data/model/course/coursesEntity/sections.dart';

class Data {
  int id;
  String name;
  String description;
  String course_image;
  int subject_semester_id;
  List<Sections> sections;

  Data.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        description = map["description"],
        course_image = map["course_image"],
        subject_semester_id = map["subject_semester_id"],
        sections = List<Sections>.from(
            map["sections"].map((it) => Sections.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['course_image'] = course_image;
    data['subject_semester_id'] = subject_semester_id;
    data['sections'] =
        sections != null ? this.sections.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
