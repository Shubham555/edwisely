import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../api/api.dart';
import '../model/questionBank/topicEntity/TopicEntity.dart';

part 'topic_state.dart';

class TopicCubit extends Cubit<TopicState> {
  TopicCubit() : super(TopicInitial());

  getTopics(int subjectId, int universityDepartmentId) async {
    final response = await EdwiselyApi.dio.get(
      'questionnaireWeb/getSubjectTopics?subject_id=$subjectId&university_degree_department_id=$universityDepartmentId',
    );
    print(response.data['message']);
    if (response.statusCode == 200) {
      if (response.data['message'] != '') {
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
