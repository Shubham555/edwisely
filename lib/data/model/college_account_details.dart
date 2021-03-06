
class College_account_details {

  final int id;
  final String faculty_name;
  final String profile_pic;

	College_account_details.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		faculty_name = map["faculty_name"],
		profile_pic = map["profile_pic"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['faculty_name'] = faculty_name;
		data['profile_pic'] = profile_pic;
		return data;
	}
}
