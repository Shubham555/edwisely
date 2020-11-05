import 'topics.dart';

class Data {
  int id;
  String name;
  List<String> objectives;
  List<String> outcomes;
  List<Topics> topics;

  Data.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        objectives = List<String>.from(map["objectives"]),
        outcomes = List<String>.from(map["outcomes"]),
        topics = List<Topics>.from(
            map["topics"].map((it) => Topics.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['objectives'] = objectives;
    data['outcomes'] = outcomes;
    data['topics'] =
        topics != null ? this.topics.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
