import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
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

  signIn(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await EdwiselyApi.dio.post(
      'auth/loginUser',
      data: FormData.fromMap(
        {
          'username': email,
          'password': password,
        },
      ),
    );
    if (response.statusCode == 200) {
      if (response.data['message'] == 'Log in success!') {
        if (response.data['force_password_change'] == 1) {
          emit(
            ForcePasswordChange(),
          );
        } else {
          prefs.setString(
            'login_key',
            response.data['token'],
          );
          emit(
            LoginSuccess(),
          );
        }
      } else {
        emit(
          LoginError(
            response.data['message'],
          ),
        );
      }
    }
  }
}

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginRequired extends LoginState {}

class LoginNotRequired extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}

class ForcePasswordChange extends LoginState {}
