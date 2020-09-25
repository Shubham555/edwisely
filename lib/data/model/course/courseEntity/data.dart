import 'sections.dart';

class Data {

  int subject_id;
  String subject_name;
  String description;
  String image;
  List<String> objectives;
  List<String> outcomes;
  List<Sections> sections;

	Data.fromJsonMap(Map<String, dynamic> map): 
		subject_id = map["subject_id"],
		subject_name = map["subject_name"],
		description = map["description"],
		image = map["image"],
		objectives = List<String>.from(map["objectives"]),
		outcomes = List<String>.from(map["outcomes"]),
		sections = List<Sections>.from(map["sections"].map((it) => Sections.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['subject_id'] = subject_id;
		data['subject_name'] = subject_name;
		data['description'] = description;
		data['image'] = image;
		data['objectives'] = objectives;
		data['outcomes'] = outcomes;
		data['sections'] = sections != null ? 
			this.sections.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
