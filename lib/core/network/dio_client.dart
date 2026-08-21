import 'package:dio/dio.dart';

class DioClient {
  late final Dio dio;
  DioClient() {
    dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 2),
        receiveTimeout: Duration(seconds: 2),
        sendTimeout: Duration(seconds: 2),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }
}
