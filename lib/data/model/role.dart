
class Role {

  final int id;
  final String role_name;

	Role.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		role_name = map["role_name"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['role_name'] = role_name;
		return data;
	}
}
