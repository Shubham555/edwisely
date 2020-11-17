import 'package:edwisely/data/model/college_account_details.dart';
import 'package:edwisely/data/model/role.dart';

class NotifiacationHomeScreenEntity {
  int id;
  String title;
  String description;
  String url;
  String start_time;
  String end_time;
  String type;
  String created_at;

  List<Object> followers;
  int sent_to;
  int is_comment_anonymous;
  int comments_count;

  NotifiacationHomeScreenEntity.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map["name"],
        description = map["description"],
        url = map["url"],
        start_time = map["start_time"],
        end_time = map["end_time"],
        type = map["type"],
        created_at = map["created_at"],
        followers = map["followers"],
        sent_to = map["sent_to"],
        is_comment_anonymous = map["is_comment_anonymous"],
        comments_count = map["comments_count"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['start_time'] = start_time;
    data['end_time'] = end_time;
    data['type'] = type;
    data['created_at'] = created_at;
    data['followers'] = followers;
    data['sent_to'] = sent_to;
    data['is_comment_anonymous'] = is_comment_anonymous;
    data['comments_count'] = comments_count;
    return data;
  }
}
