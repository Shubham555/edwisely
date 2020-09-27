import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/assessment/topicQuestionsEntity/TopicQuestionEntity.dart';
import 'package:meta/meta.dart';

class TopicQuestionsCubit extends Cubit<TopicQuestionsState> {
  TopicQuestionsCubit() : super(TopicQuestionsInitial());

  getQuestionsToATopic(
    List<int> topics,
    List<int> subTopicIds,
  ) async {
    emit(
      TopicQuestionsInitial(),
    );
    final response = await EdwiselyApi.dio.get(
      'questionnaire/getTopicsQuestions',
      queryParameters: {
        'topic_ids': jsonEncode(
          topics,
        ),
        'sub_topic_ids': jsonEncode(
          subTopicIds,
        ),
        'grand_topic_ids': ''
      },
    );
    if (response.data['message'] == 'Successfully fetched the data') {
      emit(
        TopicQuestionsFetched(
          TopicQuestionEntity.fromJsonMap(
            response.data,
          ),
        ),
      );
    } else {
      emit(
        TopicQuestionsFailed(),
      );
    }
  }
}

@immutable
abstract class TopicQuestionsState {}

class TopicQuestionsInitial extends TopicQuestionsState {}

class TopicQuestionsFetched extends TopicQuestionsState {
  final TopicQuestionEntity topicQuestionsEntity;

  TopicQuestionsFetched(this.topicQuestionsEntity);
}

class TopicQuestionsFailed extends TopicQuestionsState {}
