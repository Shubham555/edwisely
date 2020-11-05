class Data {
  int id;
  String name;
  String description;
  int subject_semester;

  Data.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        description = map["description"],
        subject_semester = map["subject_semester"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['subject_semester'] = subject_semester;
    return data;
  }
}
