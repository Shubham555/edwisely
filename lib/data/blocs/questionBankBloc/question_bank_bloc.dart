import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'question_bank_event.dart';
part 'question_bank_state.dart';

class QuestionBankBloc extends Bloc<QuestionBankEvent, QuestionBankState> {
  QuestionBankBloc() : super(QuestionBankInitial());

  @override
  Stream<QuestionBankState> mapEventToState(
    QuestionBankEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
