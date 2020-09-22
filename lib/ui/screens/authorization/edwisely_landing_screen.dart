import 'package:edwisely/data/cubits/login_cubit.dart';
import 'package:edwisely/ui/screens/authorization/login_screen.dart';
import 'package:edwisely/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              builder: (BuildContext context) => HomeScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Text('Loading...'),
            ],
          ),
        ),
      ),
    );
  }
}
