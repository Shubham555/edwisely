
class Followers {

  final int id;
  final String faculty_name;
  final String profile_pic;
  final int role_id;
  final String role_name;

	Followers.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		faculty_name = map["faculty_name"],
		profile_pic = map["profile_pic"],
		role_id = map["role_id"],
		role_name = map["role_name"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['faculty_name'] = faculty_name;
		data['profile_pic'] = profile_pic;
		data['role_id'] = role_id;
		data['role_name'] = role_name;
		return data;
	}
}
