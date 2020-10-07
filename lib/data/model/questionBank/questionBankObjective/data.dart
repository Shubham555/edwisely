import 'questions_options.dart';

class Data {
  int id;
  String name;
  var media;
  var bookmarked;
  var college_account_id;
  var question_type;
  var question_img;
  var math_type;
  var blooms_level;
  var solution;
  var solution_image;
  var type;
  var type_id;
  var type_name;
  var type_code;
  List<Questions_options> questions_options;

  Data.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        media = map["media"],
        bookmarked = map["bookmarked"],
        college_account_id = map["college_account_id"],
        question_type = map["question_type"],
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
    data['bookmarked'] = bookmarked;
    data['college_account_id'] = college_account_id;
    data['question_type'] = question_type;
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
