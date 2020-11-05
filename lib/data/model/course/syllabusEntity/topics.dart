class Topics {
  String code;
  String topic_name;
  String type;

  Topics.fromJsonMap(Map<String, dynamic> map)
      : code = map["code"],
        topic_name = map["topic_name"],
        type = map["type"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['topic_name'] = topic_name;
    data['type'] = type;
    return data;
  }
}
