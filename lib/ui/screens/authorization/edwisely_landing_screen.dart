import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubits/login_cubit.dart';
import '../course/courses_landing_screen.dart';
import 'login_screen.dart';

class EdwiselyLandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: context.bloc<LoginCubit>()..checkLogin(),
      listener: (BuildContext context, state) {
        if (state is LoginRequired) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(),
            ),
          );
        }
        if (state is LoginNotRequired) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CoursesLandingScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Text(
                'Loading Edwisely...',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
