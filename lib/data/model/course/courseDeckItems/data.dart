class Data {
  int id;
  String code;
  Object source;
  Object source_link;
  String url;
  String type;

  Data.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        code = map["code"],
        source = map["source"],
        source_link = map["source_link"],
        url = map["url"],
        type = map["type"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['code'] = code;
    data['source'] = source;
    data['source_link'] = source_link;
    data['url'] = url;
    data['type'] = type;
    return data;
  }
}
