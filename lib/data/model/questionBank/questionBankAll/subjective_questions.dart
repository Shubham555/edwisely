
class Subjective_questions {

  var id;
  var blooms_level;
  var marks;
  var outcome;
  var bookmarked;
  var college_account_id;
  var question_type;
  List<dynamic> evaluation_schema_url;
  List<dynamic> question_img;
  var type;
  var type_id;
  var type_name;
  var type_code;

	Subjective_questions.fromJsonMap(Map<dynamic, dynamic> map):
		id = map["id"],
		blooms_level = map["blooms_level"],
		marks = map["marks"],
		outcome = map["outcome"],
		bookmarked = map["bookmarked"],
		college_account_id = map["college_account_id"],
		question_type = map["question_type"],
		evaluation_schema_url = List<dynamic>.from(map["evaluation_schema_url"]),
		question_img = List<dynamic>.from(map["question_img"]),
		type = map["type"],
		type_id = map["type_id"],
		type_name = map["type_name"],
		type_code = map["type_code"];

	Map<dynamic, dynamic> toJson() {
		final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
		data['id'] = id;
		data['blooms_level'] = blooms_level;
		data['marks'] = marks;
		data['outcome'] = outcome;
		data['bookmarked'] = bookmarked;
		data['college_account_id'] = college_account_id;
		data['question_type'] = question_type;
		data['evaluation_schema_url'] = evaluation_schema_url;
		data['question_img'] = question_img;
		data['type'] = type;
		data['type_id'] = type_id;
		data['type_name'] = type_name;
		data['type_code'] = type_code;
		return data;
	}
}
