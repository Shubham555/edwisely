import 'package:edwisely/data/model/course/getAllCourses/departments.dart';

class Data {

  int id;
  String name;
  String description;
  String course_image;
  List<Departments> departments;

	Data.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		description = map["description"],
		course_image = map["course_image"],
		departments = List<Departments>.from(map["departments"].map((it) => Departments.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['description'] = description;
		data['course_image'] = course_image;
		data['departments'] = departments != null ? 
			this.departments.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
