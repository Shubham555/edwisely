import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/assessment/unitTopic/UnitTOpicEntity.dart';
import 'package:edwisely/data/model/assessment/unitTopic/topic.dart';
import 'package:meta/meta.dart';

import '../../main.dart';

class UnitTopicCubit extends Cubit<UnitTopicState> {
  UnitTopicCubit() : super(UnitTopicInitial());

  getTopics(int unitId) async {
    emit(
      UnitTopicInitial(),
    );
    final response = await EdwiselyApi.dio.get(
      'questionnaire/getUnitTopics',
      queryParameters: {'unit_ids': unitId}, options: Options(
        headers: {
          'Authorization': 'Bearer $loginToken',
        })
    );
    if (response.data['message'] == 'Successfully fetched the data') {
      if (response.data['data'].toString() != '[]') {
        UnitTOpicEntity unitTOpicEntity = UnitTOpicEntity.fromJsonMap(response.data);
        List<Topic> topics = [];
        List<Topic> subTopics = [];
        unitTOpicEntity.data[0].topic.forEach((element) {
          if (element.type == 'GTopic') {
            topics.add(element);
          }
        });
        unitTOpicEntity.data[0].topic.forEach((element) {
          if (element.type == 'GSubtopic') {
            subTopics.add(element);
          }
        });
        emit(
          UnitTopicFetched(topics, subTopics),
        );
      } else {
        emit(UnitTopicEmpty());
      }
    } else {
      emit(
        UnitTopicFailed(),
      );
    }
  }
}

@immutable
abstract class UnitTopicState {}

class UnitTopicInitial extends UnitTopicState {}

class UnitTopicFetched extends UnitTopicState {
  final List<Topic> topics;
  final List<Topic> subTopics;

  UnitTopicFetched(this.topics, this.subTopics);
}

class UnitTopicFailed extends UnitTopicState {}

class UnitTopicEmpty extends UnitTopicState {}
