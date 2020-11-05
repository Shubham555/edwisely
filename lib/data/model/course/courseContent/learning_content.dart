class Learning_content {
  int material_id;
  String type;
  String file_url;
  String thumb_url;
  String title;
  String source;
  String topic_id;
  int faculty_content;
  String faculty_name;
  int level;
  int readtime;
  int bookmarked;
  String display_type;
  String topic_code;

  Learning_content.fromJsonMap(Map<String, dynamic> map)
      : material_id = map["material_id"],
        type = map["type"],
        file_url = map["file_url"],
        thumb_url = map["thumb_url"],
        title = map["title"],
        source = map["source"],
        topic_id = map["topic_id"],
        faculty_content = map["faculty_content"],
        faculty_name = map["faculty_name"],
        level = map["level"],
        readtime = map["readtime"],
        display_type = map['display_type'],
        topic_code = map['topic_code'],
        bookmarked = map["bookmarked"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['material_id'] = material_id;
    data['type'] = type;
    data['file_url'] = file_url;
    data['thumb_url'] = thumb_url;
    data['title'] = title;
    data['source'] = source;
    data['topic_id'] = topic_id;
    data['faculty_content'] = faculty_content;
    data['faculty_name'] = faculty_name;
    data['level'] = level;
    data['readtime'] = readtime;
    data['bookmarked'] = bookmarked;
    data['display_type'] = display_type;
    return data;
  }
}
