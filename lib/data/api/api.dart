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
            'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMTMwLCJlbWFpbCI6InByYWthc2hAZWR3aXNlbHkuY29tIiwiaW5pIjoiMTU5OTczMDk4MyIsImV4cCI6IjE2MDEwMjY5ODMifQ.R_DEuq-7UmeRF1Mmc7VLRz2Mi63iIz3Kb1JMYkcnMUo',
          }),
    );
  }
}
