import 'package:edwisely/data/model/college_notifications.dart';

class PeersDataEntity {

  final int status;
  final String message;
  final List<College_notifications> college_notifications;
  final String date_lt;

	PeersDataEntity.fromJsonMap(Map<String, dynamic> map): 
		status = map["status"],
		message = map["message"],
		college_notifications = List<College_notifications>.from(map["college_notifications"].map((it) => College_notifications.fromJsonMap(it))),
		date_lt = map["date_lt"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status;
		data['message'] = message;
		data['college_notifications'] = college_notifications != null ? 
			this.college_notifications.map((v) => v.toJson()).toList()
			: null;
		data['date_lt'] = date_lt;
		return data;
	}
}
