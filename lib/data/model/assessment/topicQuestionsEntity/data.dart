import 'package:edwisely/data/model/assessment/topicQuestionsEntity/questions_options.dart';

class Data {
  int id;
  String name;
  int media;
  String question_img;
  int math_type;
  int blooms_level;
  String solution;
  String solution_image;
  String type;
  int type_id;
  String type_name;
  String type_code;
  List<Questions_options> questions_options;

  Data.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        media = map["media"],
        question_img = map["question_img"],
        math_type = map["math_type"],
        blooms_level = map["blooms_level"],
        solution = map["solution"],
        solution_image = map["solution_image"],
        type = map["type"],
        type_id = map["type_id"],
        type_name = map["type_name"],
        type_code = map["type_code"],
        questions_options = List<Questions_options>.from(
            map["questions_options"]
                .map((it) => Questions_options.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['media'] = media;
    data['question_img'] = question_img;
    data['math_type'] = math_type;
    data['blooms_level'] = blooms_level;
    data['solution'] = solution;
    data['solution_image'] = solution_image;
    data['type'] = type;
    data['type_id'] = type_id;
    data['type_name'] = type_name;
    data['type_code'] = type_code;
    data['questions_options'] = questions_options != null
        ? this.questions_options.map((v) => v.toJson()).toList()
        : null;
    return data;
  }
}
