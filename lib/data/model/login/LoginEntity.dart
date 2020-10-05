
class LoginEntity {

  int college_id;
  int college_university_degree_department_id;
  int department_id;
  var email;
  int force_password_change;
  var message;
  var name;
  bool success;
  var token;
  var university_code;
  int university_degree_department_id;
  int user_id;

	LoginEntity.fromJsonMap(Map<String, dynamic> map): 
		college_id = map["college_id"],
		college_university_degree_department_id = map["college_university_degree_department_id"],
		department_id = map["department_id"],
		email = map["email"],
		force_password_change = map["force_password_change"],
		message = map["message"],
		name = map["name"],
		success = map["success"],
		token = map["token"],
		university_code = map["university_code"],
		university_degree_department_id = map["university_degree_department_id"],
		user_id = map["user_id"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['college_id'] = college_id;
		data['college_university_degree_department_id'] = college_university_degree_department_id;
		data['department_id'] = department_id;
		data['email'] = email;
		data['force_password_change'] = force_password_change;
		data['message'] = message;
		data['name'] = name;
		data['success'] = success;
		data['token'] = token;
		data['university_code'] = university_code;
		data['university_degree_department_id'] = university_degree_department_id;
		data['user_id'] = user_id;
		return data;
	}
}
