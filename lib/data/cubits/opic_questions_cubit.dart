import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/assessment/topicQuestionsEntity/TopicQuestionEntity.dart';
import 'package:edwisely/data/model/assessment/topicQuestionsEntity/data.dart';
import 'package:meta/meta.dart';

import '../../main.dart';

class TopicQuestionsCubit extends Cubit<TopicQuestionsState> {
  TopicQuestionsCubit() : super(TopicQuestionsInitial());

  getTopicQuestions(
    List<int> topics,
    List<int> subTopics,
  ) async {
    emit(
      TopicQuestionsInitial(),
    );
    final response = await EdwiselyApi.dio.get(
      'questionnaire/getTopicsQuestions',
      queryParameters: {'topic_ids': topics.map((e) => "$e").join(','), 'sub_topic_ids': subTopics.map((e) => "$e").join(','), 'grand_topic_ids': ''}, options: Options(
        headers: {
          'Authorization': 'Bearer $loginToken',
        })
    );
    print(response.data);
    if (response.data['message'] == 'Successfully fetched the data') {
      emit(
        TopicQuestionsFetched(
          TopicQuestionEntity.fromJsonMap(
            response.data,
          ).data,
        ),
      );
    } else {
      emit(
        TopicQuestionsFailed(response.data['message']),
      );
    }
  }

  getBloomsQuestions(
    int bloomLevel,
    List<Data> data,
  ) {
    if (bloomLevel == 0) {
      emit(TopicQuestionsFetched(data));
    } else {
      List<Data> ddata = List.from(data);
      ddata.retainWhere((element) => element.blooms_level == bloomLevel);
      if (ddata.isNotEmpty) {
        emit(TopicQuestionsFetched(ddata));
      } else {
        emit(TopicQuestionsFailed('No Data'));
      }
    }
  }
}

@immutable
abstract class TopicQuestionsState {}

class TopicQuestionsInitial extends TopicQuestionsState {}

class TopicQuestionsFetched extends TopicQuestionsState {
  final List<Data> data;

  TopicQuestionsFetched(this.data);
}

class TopicQuestionsFailed extends TopicQuestionsState {
  final String error;

  TopicQuestionsFailed(this.error);
}
