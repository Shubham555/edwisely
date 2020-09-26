import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api.dart';

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
    print('sign in ');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await EdwiselyApi.dio.post(
          'auth/loginUser',
          data: FormData.fromMap(
            {
              'username': email,
              'password': password,
            },
        ));
    if (response.statusCode == 200) {
      if (response.data['message'] == 'Log in success!') {
        prefs.setString('login_key', response.data['token']);
        prefs.setString(
          'department_id',
          response.data['department_id'],
        );
        prefs.setString(
          'college_id',
          response.data['college_id'],
        );
        log('Values Saved');
        if (response.data['force_password_change'] == 1) {
          emit(
            ForcePasswordChange(response.data['name'], response.data['email']),
          );
        } else {
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

  changePassword(String email, String password) async {
    final response = await EdwiselyApi.dio.post(
          'user/updatePassword',
          data: FormData.fromMap(
            {'user_id': email, 'new_password': password},
          ),
        );

    if (response.statusCode == 200) {
      if (response.data['message'] == 'Successfully updated password') {
        emit(LoginSuccess());
      } else {
        emit(LoginError(response.data['message']));
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

class ForcePasswordChange extends LoginState {
  final String name;
  final String email;

  ForcePasswordChange(this.name, this.email);
}
