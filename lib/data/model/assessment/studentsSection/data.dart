class Data {
  int id;
  String name;
  String roll_number;

  Data.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        roll_number = map["roll_number"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['roll_number'] = roll_number;
    return data;
  }
}
