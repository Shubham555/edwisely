import 'learning_content.dart';

class CourseContentEntity {
  int status;
  String message;
  List<Learning_content> academic_materials;
  List<Learning_content> learning_content;

  CourseContentEntity.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        academic_materials = List<Learning_content>.from(
            map["academic_materials"]
                .map((it) => Learning_content.fromJsonMap(it))),
        learning_content = List<Learning_content>.from(map["learning_content"]
            .map((it) => Learning_content.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['academic_materials'] = academic_materials != null
        ? this.academic_materials.map((v) => v.toJson()).toList()
        : null;
    data['learning_content'] = learning_content != null
        ? this.learning_content.map((v) => v.toJson()).toList()
        : null;
    return data;
  }
}
