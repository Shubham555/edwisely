import 'package:edwisely/data/model/department/data.dart';

class DepartmentEntity {

  List<Data> data;
  bool message;
  int status;

	DepartmentEntity.fromJsonMap(Map<String, dynamic> map): 
		data = List<Data>.from(map["data"].map((it) => Data.fromJsonMap(it))),
		message = map["message"],
		status = map["status"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['data'] = data != null ? 
			this.data.map((v) => v.toJson()).toList()
			: null;
		data['message'] = message;
		data['status'] = status;
		return data;
	}
}
