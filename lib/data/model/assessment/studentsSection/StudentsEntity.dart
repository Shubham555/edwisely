import 'data.dart';

class StudentsEntity {
  List<Data> data;
  bool message;
  int status;

  StudentsEntity.fromJsonMap(Map<String, dynamic> map)
      : data = List<Data>.from(map["data"].map((it) => Data.fromJsonMap(it))),
        message = map["message"],
        status = map["status"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] =
        data != null ? this.data.map((v) => v.toJson()).toList() : null;
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
