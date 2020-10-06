class Student {
  int id;
  String name;
  String profile_pic;

  Student.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        profile_pic = map["profile_pic"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['profile_pic'] = profile_pic;
    return data;
  }
}

class College {
  int id;
  String name;
  String lastname;
  String profile_pic;

  College.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["first_name"],
        lastname = map["last_name"],
        profile_pic = map["profile_pic"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['profile_pic'] = profile_pic;
    return data;
  }
}
