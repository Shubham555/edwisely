import 'package:edwisely/data/model/questionBank/questionBankAll/objective_questions.dart';
import 'package:edwisely/data/model/questionBank/questionBankAll/subjective_questions.dart';

class Data {

  List<Objective_questions> objective_questions;
  List<Subjective_questions> subjective_questions;

	Data.fromJsonMap(Map<String, dynamic> map): 
		objective_questions = List<Objective_questions>.from(map["objective_questions"].map((it) => Objective_questions.fromJsonMap(it))),
		subjective_questions = List<Subjective_questions>.from(map["subjective_questions"].map((it) => Subjective_questions.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['objective_questions'] = objective_questions != null ? 
			this.objective_questions.map((v) => v.toJson()).toList()
			: null;
		data['subjective_questions'] = subjective_questions != null ? 
			this.subjective_questions.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
