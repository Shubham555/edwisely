import 'package:dio/dio.dart';
import 'package:edwisely/ui/screens/home_screen.dart';
import 'package:edwisely/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../data/api/api.dart';
import '../../../data/cubits/login_cubit.dart';
import '../../../main.dart';
import '../../widgets_util/text_input.dart';

class LoginScreen extends StatefulWidget {
  bool _obscure = true;

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            Get.defaultDialog(
              title: 'Error',
              middleText: state.error,
              onConfirm: () => Get.back(),
            );
          }
          if (state is ForcePasswordChange) {
            showDialog(
                context: context,
                builder: (context) {
                  TextEditingController newPasswordController =
                      TextEditingController();
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
                            obscureText: true,
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
                                context.bloc<LoginCubit>().changePassword(
                                    state.email, newPasswordController.text);
                              },
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
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
                builder: (BuildContext context) => HomeScreen(),
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
    if (isFuckingTestMode) {
      emailController.text = 'prakash@edwisely.com';
      passwordController.text = '12345';
    }
    return Container(
      width: screenSize.width * 0.3,
      height: screenSize.height,
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.03,
      ),
      color: EdwiselyTheme.NAV_BAR_COLOR,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //spacing
          SizedBox(
            height: screenSize.height * 0.1,
          ),
          //app logo
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/logo/big_logo.png',
              width: screenSize.width * 0.15,
            ),
          ),
          //spacing
          SizedBox(height: screenSize.height * 0.1),
          //heading text
          Text(
            'Login',
            style: textTheme.headline4.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            width: 88.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22.0),
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
            isWhite: true,
          ),
          //spacing
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          //password text input
          StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return TextInput(
                isWhite: true,
                obscureText: widget._obscure,
                label: 'Password',
                hint: 'Enter your password',
                inputType: TextInputType.visiblePassword,
                suffix: FlatButton(
                  onPressed: () {
                    setState(() {
                      // Function to toggle password visibility
                      widget._obscure = !widget._obscure;
                    });
                  },
                  child: Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                  ),
                ),
                controller: passwordController,
              );
            },
          ),
          //forget password
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController forgotController =
                          TextEditingController();
                      return Card(
                        margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 3.5,
                          horizontal: MediaQuery.of(context).size.width / 3,
                        ),
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
                                    final response = await EdwiselyApi.dio.post(
                                      'user/forgotPassword',
                                      data: FormData.fromMap(
                                        {'email': forgotController.text},
                                      ),
                                    );

                                    if (response.data['message'] ==
                                        'Successfully updated password') {
                                      Navigator.pop(context);
                                    }
                                  },
                                  color: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
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
                style: textTheme.button,
              ),
            ),
          ),
          //divider
          Padding(
            padding: const EdgeInsets.all(10.0),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
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

  Widget _buildLeftPart(
      Size screenSize, TextTheme textTheme, BuildContext context) {
    return Container(
      width: screenSize.width * 0.7,
      height: screenSize.height,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Stack(
        children: [
          //image
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Image.asset(
              'assets/images/login.png',
              fit: BoxFit.cover,
            ),
          ),
          //overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.6),
            ),
          ),
          //text
          Positioned(
            bottom: 48.0,
            left: 48.0,
            child: Container(
              width: screenSize.width * 0.6,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Transforming Indian\nEngineering Institutes into\nAI-Powered Learning Campuses',
                  style: textTheme.headline1.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
