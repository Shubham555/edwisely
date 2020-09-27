import 'package:bloc/bloc.dart';
import 'package:edwisely/main.dart';
import 'package:meta/meta.dart';

import '../api/api.dart';
import '../model/questionBank/topicEntity/TopicEntity.dart';

class TopicCubit extends Cubit<TopicState> {
  TopicCubit() : super(TopicInitial());

  getTopics(int subjectId) async {
    final response = await EdwiselyApi.dio.get(
      'questionnaireWeb/getSubjectTopics?subject_id=$subjectId&university_degree_department_id=$departmentId',
    );
    if (response.statusCode == 200) {
      if (response.data['message'] != 'No topics to fetch') {
        emit(
          TopicFetched(
            TopicEntity.fromJsonMap(
              response.data,
            ),
          ),
        );
      } else {
        emit(
          TopicEmpty(),
        );
      }
    } else {
      emit(
        TopicFailed(),
      );
    }
  }
}

@immutable
abstract class TopicState {}

class TopicInitial extends TopicState {}

class TopicFetched extends TopicState {
  final TopicEntity topicEntity;

  TopicFetched(this.topicEntity);
}

class TopicFailed extends TopicState {}

class TopicEmpty extends TopicState {}
