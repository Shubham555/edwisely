import 'package:dio/dio.dart';
import 'package:edwisely/main.dart';

class EdwiselyApi {

  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://stagingfacultypython.edwisely.com/',
      headers: {
        'Authorization': 'Bearer $loginToken',
      },
    ),
  );
}
