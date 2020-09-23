import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/cubits/login_cubit.dart';
import 'package:edwisely/ui/screens/course/courses_landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets_util/text_input.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener(
        cubit: context.bloc<LoginCubit>(),
        listener: (BuildContext context, state) {
          if (state is LoginError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          if (state is ForcePasswordChange) {
            showDialog(
                context: context,
                builder: (context) {
                  TextEditingController newPasswordController = TextEditingController();
                  return Card(
                    margin: EdgeInsets.all(250),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hello ${state.name} before continuing lets set a Password',
                            style: TextStyle(fontSize: 28),
                          ),
                          TextInput(
                            label: 'Password',
                            hint: 'Enter new password',
                            inputType: TextInputType.visiblePassword,
                            suffix: Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                            ),
                            controller: newPasswordController,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.4,
                            child: RaisedButton(
                              onPressed: () {
                                context.bloc<LoginCubit>().changePassword(state.email, newPasswordController.text);
                              },
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Set Password',
                                style: textTheme.headline6.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CoursesLandingScreen(),
              ),
            );
          }
        },
        child: SafeArea(
          child: Row(
            children: [
              //left part
              _buildLeftPart(screenSize, textTheme, context),
              _buildRightPart(screenSize, textTheme, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRightPart(
    Size screenSize,
    TextTheme textTheme,
    BuildContext context,
  ) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Container(
      width: screenSize.width * 0.4,
      height: screenSize.height,
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 42.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //app logo
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Edwisely',
              style: textTheme.headline3,
            ),
          ),
          //spacing
          SizedBox(height: screenSize.height * 0.1),
          //heading text
          Text(
            'Login',
            style: textTheme.headline4.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          //spacing
          SizedBox(height: screenSize.height * 0.05),
          //email id text input
          TextInput(
            label: 'Email',
            hint: 'Enter your username',
            inputType: TextInputType.emailAddress,
            controller: emailController,
          ),
          //spacing
          SizedBox(
            height: screenSize.height * 0.03,
          ),
          //password text input
          TextInput(
            label: 'Password',
            hint: 'Enter your password',
            inputType: TextInputType.visiblePassword,
            suffix: Icon(
              Icons.remove_red_eye,
              color: Colors.black,
            ),
            controller: passwordController,
          ),
          //forget password
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController forgotController = TextEditingController();
                      return Card(
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height / 3.5, horizontal: MediaQuery.of(context).size.width / 5),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Enter your Email Id ',
                                style: TextStyle(fontSize: 28),
                              ),
                              TextInput(
                                label: 'Email',
                                hint: 'Enter Email',
                                inputType: TextInputType.visiblePassword,
                                suffix: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.black,
                                ),
                                controller: forgotController,
                              ),
                              SizedBox(
                                width: screenSize.width * 0.4,
                                child: RaisedButton(
                                  onPressed: () async {
                                    final response = await EdwiselyApi().dio().then(
                                          (value) => value.post(
                                            'user/forgotPassword',
                                            data: FormData.fromMap(
                                              {'email': forgotController.text},
                                            ),
                                          ),
                                        );
                                    print(response.data);
                                    if (response.data['message'] == 'Successfully updated password') {
                                      Navigator.pop(context);
                                    }
                                  },
                                  color: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Text(
                                    'Send Password',
                                    style: textTheme.headline6.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Text(
                'Forgot Password ?',
                style: textTheme.button.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          //divider
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Divider(
              color: Colors.black.withOpacity(0.4),
              thickness: 0.2,
            ),
          ),
          //login button
          SizedBox(
            width: screenSize.width * 0.4,
            child: RaisedButton(
              onPressed: () {
                context.bloc<LoginCubit>().signIn(
                      emailController.text,
                      passwordController.text,
                    );
              },
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Login',
                style: textTheme.headline6.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          //spacing
        ],
      ),
    );
  }

  Widget _buildLeftPart(Size screenSize, TextTheme textTheme, BuildContext context) {
    return Container(
      width: screenSize.width * 0.6,
      height: screenSize.height,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(22.0),
          bottomRight: Radius.circular(22.0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //image
          Image.asset(
            'assets/images/login_screen.png',
            width: screenSize.width * 0.4,
            height: screenSize.height * 0.7,
          ),
          //text
          Text(
            'The best online learning solution',
            style: textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
