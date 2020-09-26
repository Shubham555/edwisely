import 'package:dio/dio.dart';

class EdwiselyApi {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://stagingfacultypython.edwisely.com/',
      headers: {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMTMwLCJlbWFpbCI6InByYWthc2hAZWR3aXNlbHkuY29tIiwiaW5pIjoiMTYwMTAzMDg5MCIsImV4cCI6IjE2MDIzMjY4OTAifQ.WcZHUYuPyARYKQ2F7jSSZVF8-zQBKIaDXBZWqQsilbs',
      },
    ),
  );
}
