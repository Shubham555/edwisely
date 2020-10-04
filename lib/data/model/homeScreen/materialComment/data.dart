import 'package:edwisely/data/model/homeScreen/materialComment/student.dart';

class Data {

  Object college_account;
  Object college_account_id;
  String comment;
  String created_at;
  int id;
  Student student;
  int student_id;

	Data.fromJsonMap(Map<String, dynamic> map): 
		college_account = map["college_account"],
		college_account_id = map["college_account_id"],
		comment = map["comment"],
		created_at = map["created_at"],
		id = map["id"],
		student = Student.fromJsonMap(map["student"]),
		student_id = map["student_id"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['college_account'] = college_account;
		data['college_account_id'] = college_account_id;
		data['comment'] = comment;
		data['created_at'] = created_at;
		data['id'] = id;
		data['student'] = student == null ? null : student.toJson();
		data['student_id'] = student_id;
		return data;
	}
}
