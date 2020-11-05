import 'package:edwisely/data/model/assessment/unitTopic/topic.dart';

class Data {
  int unit_id;
  String unit_name;
  String description;
  List<Topic> topic;

  Data.fromJsonMap(Map<String, dynamic> map)
      : unit_id = map["unit_id"],
        unit_name = map["unit_name"],
        description = map["description"],
        topic =
            List<Topic>.from(map["topic"].map((it) => Topic.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unit_id'] = unit_id;
    data['unit_name'] = unit_name;
    data['description'] = description;
    data['topic'] =
        topic != null ? this.topic.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
