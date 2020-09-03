import 'package:dio/dio.dart';

class EdwiselyApi {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://stagingfacultypython.edwisely.com/',
      headers: {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMTMwLCJlbWFpbCI6InByYWthc2hAZWR3aXNlbHkuY29tIiwiaW5pIjoiMTU5ODQyODA1MiIsImV4cCI6IjE1OTk3MjQwNTIifQ.MssiZUbQahudcrC7dVjafg-ax-NiwvJJJb2GWYLaJ5w'
      },
    ),
  );
}
