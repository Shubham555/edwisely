import 'data.dart';

class QuestionBankAllEntity {

  var status;
  var message;
  Data data;

	QuestionBankAllEntity.fromJsonMap(Map<String, dynamic> map): 
		status = map["status"],
		message = map["message"],
		data = Data.fromJsonMap(map["data"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status;
		data['message'] = message;
		data['data'] = data == null ? null : this.data.toJson();
		return data;
	}
}
