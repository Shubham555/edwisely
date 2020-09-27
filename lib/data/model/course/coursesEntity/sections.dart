
class Sections {

  int id;
  String name;
  int faculty_section_id;
  String department_name;
  String department_fullname;

	Sections.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		faculty_section_id = map["faculty_section_id"],
		department_name = map["department_name"],
		department_fullname = map["department_fullname"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['faculty_section_id'] = faculty_section_id;
		data['department_name'] = department_name;
		data['department_fullname'] = department_fullname;
		return data;
	}
}
