class Data {
  int id;
  String name;
  String code;
  String color_code;
  String image;
  int order;
  int unit_id;
  int bookmarked;
  String type;

  Data.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        code = map["code"],
        color_code = map["color_code"],
        image = map["image"],
        order = map["order"],
        unit_id = map["unit_id"],
        bookmarked = map["bookmarked"],
        type = map["type"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['color_code'] = color_code;
    data['image'] = image;
    data['order'] = order;
    data['unit_id'] = unit_id;
    data['bookmarked'] = bookmarked;
    data['type'] = type;
    return data;
  }
}
