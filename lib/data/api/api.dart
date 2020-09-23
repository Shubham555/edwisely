import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EdwiselyApi {
  Future<Dio> dio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = prefs.getString('login_key');
    print('sharedprefs key $key');
    return Dio(
      BaseOptions(
          baseUrl: 'https://stagingfacultypython.edwisely.com/',
          headers: {
            'Authorization': 'Bearer $key',
          }),
    );
  }
}
