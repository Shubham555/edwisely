
class Questions_options {

  int id;
  String name;
  int is_answer;
  int media;
  String option_img;
  int question_id;

	Questions_options.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		is_answer = map["is_answer"],
		media = map["media"],
		option_img = map["option_img"],
		question_id = map["question_id"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['is_answer'] = is_answer;
		data['media'] = media;
		data['option_img'] = option_img;
		data['question_id'] = question_id;
		return data;
	}
}
