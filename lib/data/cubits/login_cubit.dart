import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('login_key') == null) {
      emit(
        LoginRequired(),
      );
    } else {
      emit(
        LoginNotRequired(),
      );
    }
  }
}

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginRequired extends LoginState {}

class LoginNotRequired extends LoginState {}
