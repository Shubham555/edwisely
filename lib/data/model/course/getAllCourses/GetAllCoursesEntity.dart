import 'package:edwisely/data/model/course/getAllCourses/data.dart';

class GetAllCoursesEntity {

  int status;
  String message;
  List<Data> data;

	GetAllCoursesEntity.fromJsonMap(Map<String, dynamic> map): 
		status = map["status"],
		message = map["message"],
		data = List<Data>.from(map["data"].map((it) => Data.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status;
		data['message'] = message;
		data['data'] = data != null ? 
			this.data.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
