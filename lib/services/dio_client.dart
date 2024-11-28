import 'package:dio/dio.dart';

class DioClient {
  static Dio? _dio;

  static Dio get instance {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: 'https://swapi.dev/api',
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return _dio!;
  }

  // Método los tests
  static void setInstance(Dio dio) {
    _dio = dio;
  }
}
