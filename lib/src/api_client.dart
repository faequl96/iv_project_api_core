import 'package:dio/dio.dart';
import 'package:iv_project_api_core/src/api_interceptor.dart';

class ApiClient {
  const ApiClient._();

  static late final Dio dio;

  static void init({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        responseType: ResponseType.json,
      ),
    );

    dio.options.headers = {'Accept-Language': 'id'};

    dio.interceptors.add(ApiInterceptor());
  }

  static void setLang(String value) {
    dio.options.headers = {'Accept-Language': value};
  }
}
