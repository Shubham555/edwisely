
class Data {

  int id;
  int blooms_level;
  int marks;
  String outcome;
  int bookmarked;
  String college_account_id;
  String question_type;
  List<String> evaluation_schema_url;
  List<String> question_img;
  String type;
  int type_id;
  String type_name;
  String type_code;

	Data.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		blooms_level = map["blooms_level"],
		marks = map["marks"],
		outcome = map["outcome"],
		bookmarked = map["bookmarked"],
		college_account_id = map["college_account_id"],
		question_type = map["question_type"],
		evaluation_schema_url = List<String>.from(map["evaluation_schema_url"]),
		question_img = List<String>.from(map["question_img"]),
		type = map["type"],
		type_id = map["type_id"],
		type_name = map["type_name"],
		type_code = map["type_code"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
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
