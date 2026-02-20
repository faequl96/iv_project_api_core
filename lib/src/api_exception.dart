import 'package:dio/dio.dart';

class ApiException implements Exception {
  ApiException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() {
    return 'ApiException: $message (Status Code: $statusCode)';
  }

  static ApiException fromDioError(DioException error) {
    String message = 'Terjadi kesalahan';
    int? statusCode;

    if (error.response != null) {
      final data = error.response?.data;
      if (data is Map<String, dynamic>) {
        statusCode = data['status_code'];
        message = data['message'] ?? message;
      }
    } else if (error.type == .connectionTimeout) {
      message = 'Koneksi timeout';
    } else if (error.type == .receiveTimeout) {
      message = 'Timeout menerima data';
    } else if (error.type == .sendTimeout) {
      message = 'Timeout mengirim data';
    } else if (error.type == .badResponse) {
      message = 'Respon buruk dari server';
    } else if (error.type == .cancel) {
      message = 'Request dibatalkan';
    } else {
      message = error.message ?? message;
    }

    return ApiException(message: message, statusCode: statusCode);
  }
}
