import 'package:dio/dio.dart';
import 'package:edwisely/main.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class EdwiselyApi {

  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://stagingfacultypython.edwisely.com/',
      headers: {
        'Authorization': 'Bearer $loginToken',
      },
    ),

    // ..interceptors.add(PrettyDioLogger(),
    );
}
