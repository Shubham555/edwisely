class Topic {
  int topic_id;
  String topic_name;
  String topic_code;
  String type;

  Topic.fromJsonMap(Map<String, dynamic> map)
      : topic_id = map["topic_id"],
        topic_name = map["topic_name"],
        topic_code = map["topic_code"],
        type = map["type"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic_id'] = topic_id;
    data['topic_name'] = topic_name;
    data['topic_code'] = topic_code;
    data['type'] = type;
    return data;
  }
}
