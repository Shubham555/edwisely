import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/assessment/unitTopic/UnitTOpicEntity.dart';
import 'package:meta/meta.dart';

class UnitTopicCubit extends Cubit<UnitTopicState> {
  UnitTopicCubit() : super(UnitTopicInitial());

  getTopics(int unitId) async {
    emit(
      UnitTopicInitial(),
    );
    final response = await EdwiselyApi.dio.get(
      'questionnaire/getUnitTopics',
      queryParameters: {'unit_ids': unitId},
    );
    if (response.data['message'] == 'Successfully fetched the data') {
      emit(
        UnitTopicFetched(
          UnitTOpicEntity.fromJsonMap(
            response.data,
          ),
        ),
      );
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
  final UnitTOpicEntity unitTOpicEntity;

  UnitTopicFetched(this.unitTOpicEntity);
}

class UnitTopicFailed extends UnitTopicState {}
