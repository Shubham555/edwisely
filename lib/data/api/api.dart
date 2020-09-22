import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EdwiselyApi {
  static final Dio dio = Dio(
    BaseOptions(
        baseUrl: 'https://stagingfacultypython.edwisely.com/',
        headers: {
          'Authorization':
              'Bearer ${SharedPreferences.getInstance().then((value) => value.getString('login_key'))} ',
        }),
  );
}
