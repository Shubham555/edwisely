
class Departments {

  int id;
  String name;
  int subject_semester_id;
  String fullname;
  int university_degree_department_id;

	Departments.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		subject_semester_id = map["subject_semester_id"],
		fullname = map["fullname"],
		university_degree_department_id = map["university_degree_department_id"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['subject_semester_id'] = subject_semester_id;
		data['fullname'] = fullname;
		data['university_degree_department_id'] = university_degree_department_id;
		return data;
	}
}
