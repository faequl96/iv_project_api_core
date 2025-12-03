import 'package:dio/dio.dart';
import 'package:iv_project_api_core/src/api_interceptor.dart';
import 'package:iv_project_core/iv_project_core.dart';

class ApiClient {
  const ApiClient._();

  static late final Dio dio;

  static void init({
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.url,
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
