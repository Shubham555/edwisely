import 'package:edwisely/data/model/assessment/topicQuestionsEntity/data.dart';

class TopicQuestionEntity {
  int status;
  String message;
  List<Data> data;
  List<int> question_ids;

  TopicQuestionEntity.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        data = List<Data>.from(map["data"].map((it) => Data.fromJsonMap(it))),
        question_ids = List<int>.from(map["question_ids"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['data'] =
        data != null ? this.data.map((v) => v.toJson()).toList() : null;
    data['question_ids'] = question_ids;
    ;
    return data;
  }
}
