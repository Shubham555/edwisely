
class Data {

  int material_id;
  String type;
  String file_url;
  String thumb_url;
  String title;
  String source;
  int faculty_content;
  int faculty_id;
  String faculty_name;
  String display_type;
  String topic_id;
  String topic_code;

	Data.fromJsonMap(Map<String, dynamic> map): 
		material_id = map["material_id"],
		type = map["type"],
		file_url = map["file_url"],
		thumb_url = map["thumb_url"],
		title = map["title"],
		source = map["source"],
		faculty_content = map["faculty_content"],
		faculty_id = map["faculty_id"],
		faculty_name = map["faculty_name"],
		display_type = map["display_type"],
		topic_id = map["topic_id"],
		topic_code = map["topic_code"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['material_id'] = material_id;
		data['type'] = type;
		data['file_url'] = file_url;
		data['thumb_url'] = thumb_url;
		data['title'] = title;
		data['source'] = source;
		data['faculty_content'] = faculty_content;
		data['faculty_id'] = faculty_id;
		data['faculty_name'] = faculty_name;
		data['display_type'] = display_type;
		data['topic_id'] = topic_id;
		data['topic_code'] = topic_code;
		return data;
	}
}
