
class Topics {

  String code;
  String type;

	Topics.fromJsonMap(Map<String, dynamic> map): 
		code = map["code"],
		type = map["type"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = code;
		data['type'] = type;
		return data;
	}
}
