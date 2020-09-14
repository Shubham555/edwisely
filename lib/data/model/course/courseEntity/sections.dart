
class Sections {

  int id;
  String name;
  int department_id;
  String department_name;
  String department_fullname;

	Sections.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		department_id = map["department_id"],
		department_name = map["department_name"],
		department_fullname = map["department_fullname"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['department_id'] = department_id;
		data['department_name'] = department_name;
		data['department_fullname'] = department_fullname;
		return data;
	}
}
