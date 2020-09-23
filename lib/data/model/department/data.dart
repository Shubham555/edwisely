
class Data {

  int college_university_degree_department_id;
  String department;
  int department_id;

	Data.fromJsonMap(Map<String, dynamic> map): 
		college_university_degree_department_id = map["college_university_degree_department_id"],
		department = map["department"],
		department_id = map["department_id"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['college_university_degree_department_id'] = college_university_degree_department_id;
		data['department'] = department;
		data['department_id'] = department_id;
		return data;
	}
}
