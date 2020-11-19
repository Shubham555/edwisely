import 'package:edwisely/data/model/college_account_details.dart';
import 'package:edwisely/data/model/role.dart';
import 'package:edwisely/data/model/followers.dart';

class College_notifications {

  final int id;
  final String title;
  final String description;
  final String starttime;
  final Object timelimit;
  final String type;
  final String created_at;
  final College_account_details college_account_details;
  final Role role;
  final List<Followers> followers;
  final int sent_to;
  final int subject_id;
  final String results_release_time;
  final int evaluation_started;
  final String evaluation_started_time;
  final String evaluation_end_time;
  final List<int> question_ids;
  final int answered;
  final int release_results;

	College_notifications.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		title = map["title"],
		description = map["description"],
		starttime = map["starttime"],
		timelimit = map["timelimit"],
		type = map["type"],
		created_at = map["created_at"],
		college_account_details = College_account_details.fromJsonMap(map["college_account_details"]),
		role = Role.fromJsonMap(map["role"]),
		followers = List<Followers>.from(map["followers"].map((it) => Followers.fromJsonMap(it))),
		sent_to = map["sent_to"],
		subject_id = map["subject_id"],
		results_release_time = map["results_release_time"],
		evaluation_started = map["evaluation_started"],
		evaluation_started_time = map["evaluation_started_time"],
		evaluation_end_time = map["evaluation_end_time"],
		question_ids = List<int>.from(map["question_ids"]),
		answered = map["answered"],
		release_results = map["release_results"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['title'] = title;
		data['description'] = description;
		data['starttime'] = starttime;
		data['timelimit'] = timelimit;
		data['type'] = type;
		data['created_at'] = created_at;
		data['college_account_details'] = college_account_details == null ? null : college_account_details.toJson();
		data['role'] = role == null ? null : role.toJson();
		data['followers'] = followers != null ? 
			this.followers.map((v) => v.toJson()).toList()
			: null;
		data['sent_to'] = sent_to;
		data['subject_id'] = subject_id;
		data['results_release_time'] = results_release_time;
		data['evaluation_started'] = evaluation_started;
		data['evaluation_started_time'] = evaluation_started_time;
		data['evaluation_end_time'] = evaluation_end_time;
		data['question_ids'] = question_ids;
		data['answered'] = answered;
		data['release_results'] = release_results;
		return data;
	}
}
