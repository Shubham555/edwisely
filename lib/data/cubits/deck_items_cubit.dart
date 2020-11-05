import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/course/courseDeckItems/DeckItemsEntity.dart';
import 'package:meta/meta.dart';

import '../../main.dart';

class DeckItemsCubit extends Cubit<DeckItemsState> {
  DeckItemsCubit() : super(DeckItemsInitial());

  getDeckItems(int deckId) async {
    final response = await EdwiselyApi.dio.get('deckItems?deck_id=$deckId',
        options: Options(headers: {
          'Authorization': 'Bearer $loginToken',
        }));

    if (response.data['message'] == 'Successfully fetched the data') {
      emit(
        DeckItemsFetched(
          DeckItemsEntity.fromJsonMap(
            response.data,
          ),
        ),
      );
    } else {
      emit(
        DeckItemsFetchFailed(),
      );
    }
  }
}

@immutable
abstract class DeckItemsState {}

class DeckItemsInitial extends DeckItemsState {}

class DeckItemsFetched extends DeckItemsState {
  final DeckItemsEntity deckItemsEntity;

  DeckItemsFetched(this.deckItemsEntity);
}

class DeckItemsFetchFailed extends DeckItemsState {}
