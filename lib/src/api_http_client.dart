import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:iv_project_api_core/iv_project_api_core.dart';
import 'package:iv_project_core/iv_project_core.dart';

class ApiHttpClient {
  static final http.Client _inner = http.Client();

  static final Map<String, String> _headers = {'Accept': 'application/json', 'Accept-Language': 'id'};
  static void setAcceptLanguageHeader(String langCode) => _headers['Accept-Language'] = langCode;

  static http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) return response;

    String message = '';
    try {
      final body = jsonDecode(response.body);
      message = body['message'] ?? 'Terjadi kesalahan sistem.';
    } catch (_) {
      message = 'Terjadi kesalahan dengan kode: ${response.statusCode}';
    }

    throw message;
  }

  static Future<http.Response> _safeRequest(Future<http.Response> Function(String? bearerToken) request) async {
    try {
      final token = AccessTokenStorage.getToken();
      final bearerToken = token != null ? 'Bearer $token' : null;
      final response = await request(bearerToken);
      return _handleResponse(response);
    } on SocketException {
      throw 'Tidak ada koneksi internet. Silakan periksa jaringan Anda.';
    } on HttpException {
      throw 'Tidak dapat menemukan layanan. Silakan coba lagi nanti.';
    } on FormatException {
      throw 'Format respon tidak sesuai. Silakan coba lagi nanti.';
    } catch (e) {
      // Jika yang dilempar adalah string dari _handleResponse, throw kembali
      if (e is String) rethrow;
      throw 'Terjadi kesalahan sistem: $e';
    }
  }

  static Future<http.Response> _handleMultipart(String method, String endpoint, FormData data, String? bearerToken) async {
    final request = http.MultipartRequest(method, Uri.parse('${ApiUrl.value}$endpoint'));
    request.headers.addAll({if (bearerToken != null) 'Authorization': bearerToken, ..._headers});

    for (var entry in data.fields.entries) {
      final value = entry.value;
      if (value is List || value is Map) {
        request.fields[entry.key] = jsonEncode(value);
      } else {
        request.fields[entry.key] = value.toString();
      }
    }
    request.files.addAll(data.files);

    final streamedResponse = await _inner.send(request);
    return await http.Response.fromStream(streamedResponse);
  }

  static Future<http.Response> get(String endpoint, {Map<String, dynamic>? data}) async {
    return _safeRequest((bearerToken) async {
      final request = http.Request('GET', Uri.parse('${ApiUrl.value}$endpoint'));
      request.headers.addAll({if (bearerToken != null) 'Authorization': bearerToken, ..._headers});

      if (data != null) {
        request.headers['Content-Type'] = 'application/json';
        request.body = jsonEncode(data);
      }

      final streamedResponse = await _inner.send(request);
      return await http.Response.fromStream(streamedResponse);
    });
  }

  static Future<http.Response> postByJson(String endpoint, {required Map<String, dynamic> data}) async {
    return _safeRequest((bearerToken) async {
      return await _inner.post(
        Uri.parse('${ApiUrl.value}$endpoint'),
        headers: {if (bearerToken != null) 'Authorization': bearerToken, ..._headers, 'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
    });
  }

  static Future<http.Response> postByFormData(String endpoint, {required FormData data}) async {
    return _safeRequest((bearerToken) async => await _handleMultipart('POST', endpoint, data, bearerToken));
  }

  static Future<http.Response> patchByJson(String endpoint, {Map<String, dynamic>? data}) async {
    return _safeRequest((bearerToken) async {
      return await _inner.patch(
        Uri.parse('${ApiUrl.value}$endpoint'),
        headers: {if (bearerToken != null) 'Authorization': bearerToken, ..._headers, 'Content-Type': 'application/json'},
        body: data != null ? jsonEncode(data) : null,
      );
    });
  }

  static Future<http.Response> patchByFormData(String endpoint, {required FormData data}) async {
    return _safeRequest((bearerToken) async => await _handleMultipart('PATCH', endpoint, data, bearerToken));
  }

  static Future<http.Response> delete(String endpoint) async {
    return _safeRequest(
      (bearerToken) async => await _inner.delete(
        Uri.parse('${ApiUrl.value}$endpoint'),
        headers: {if (bearerToken != null) 'Authorization': bearerToken, ..._headers},
      ),
    );
  }
}

class FormData {
  const FormData._({required this.fields, required this.files});

  final Map<String, dynamic> fields;
  final List<http.MultipartFile> files;

  static FormData fromMap(Map<String, dynamic> map) {
    final fields = <String, dynamic>{};
    final files = <http.MultipartFile>[];

    for (var entry in map.entries) {
      final value = entry.value;
      if (value == null) continue;

      if (value is http.MultipartFile) {
        files.add(value);
      } else if (value is List<http.MultipartFile>) {
        files.addAll(value);
      } else {
        fields[entry.key] = value;
      }
    }

    return FormData._(fields: fields, files: files);
  }
}
