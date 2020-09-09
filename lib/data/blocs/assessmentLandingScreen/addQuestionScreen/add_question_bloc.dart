import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:meta/meta.dart';

part 'add_question_event.dart';
part 'add_question_state.dart';

class AddQuestionBloc extends Bloc<AddQuestionEvent, AddQuestionState> {
  AddQuestionBloc() : super(AddQuestionInitial());

  @override
  Stream<AddQuestionState> mapEventToState(
    AddQuestionEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
