
class Data {

  int id;
  String name;
  String description;
  int subject_id;
  String start_time;
  String test_img;
  int timelimit;
  String created_at;
  int college_account_id;
  int questions_count;
  int students_count;
  int sent;

	Data.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		description = map["description"],
		subject_id = map["subject_id"],
		start_time = map["start_time"],
		test_img = map["test_img"],
		timelimit = map["timelimit"],
		created_at = map["created_at"],
		college_account_id = map["college_account_id"],
		questions_count = map["questions_count"],
		students_count = map["students_count"],
		sent = map["sent"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['description'] = description;
		data['subject_id'] = subject_id;
		data['start_time'] = start_time;
		data['test_img'] = test_img;
		data['timelimit'] = timelimit;
		data['created_at'] = created_at;
		data['college_account_id'] = college_account_id;
		data['questions_count'] = questions_count;
		data['students_count'] = students_count;
		data['sent'] = sent;
		return data;
	}
}
