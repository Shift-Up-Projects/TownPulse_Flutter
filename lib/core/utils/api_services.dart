import 'dart:developer';
import 'package:dio/dio.dart';

class Api {
  final Dio _dio;
  String? _token; // توكن المستخدم محفوظ بالذاكرة

  Api._(this._dio);

  static Api? _instance;

  static void init() {
    if (_instance == null) {
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://townpulse-backend-fehi.onrender.com/api/v1.0.0/',
          receiveDataWhenStatusError: true,
          followRedirects: false,

          validateStatus: (status) => status != null,

          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      _instance = Api._(dio);
      log("✅ Api Provider has been initialized successfully.");
    }
  }

  static Api get instance => _instance!;

  // دالة لحفظ التوكن بعد تسجيل الدخول
  void setToken(String token) {
    _token = token;
    log("🟢 Token set in Api Singleton: $_token");
  }

  Future<Response> get({
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) async {
    try {
      log('➡️ GET Request to: $url');
      final response = await _dio.get(
        url,
        queryParameters: query,
        options: Options(
          headers: {if (token != null) 'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      log('❌ DioError on GET: ${e.message}');
      rethrow;
    }
  }

  Future<Response> post({
    required String url,
    required dynamic body,
    String? token,

    int retryCount = 1,
  }) async {
    try {
      log('➡️ POST Request to: $url');
      log('   Body: $body');
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {if (_token != null) 'Authorization': 'Bearer $_token'},
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        log('✅ POST Success: ${response.data}');
        return response;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Request failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      log('❌ DioError on POST: ${e.message}');
      log('❌ Error Response Body: ${e.response?.data}');

      rethrow;
    }
  }

  Future<Response> delete({required String url, String? token}) async {
    try {
      log('➡️ DELETE Request to: $url');
      final response = await _dio.delete(
        url,
        options: Options(
          headers: {if (token != null) 'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        log('✅ DELETE Success Response');
        return response;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      log('❌ DioError on DELETE: ${e.message}');
      rethrow;
    }
  }

  Future<Response> put({
    required String url,
    required dynamic body,
    String? token,
  }) async {
    try {
      log('➡️ PUT Request to: $url');
      log('   Body: $body');
      final response = await _dio.patch(
        url,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        log('✅ PUT Success Response');
        return response;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } on DioException catch (e) {
      log('❌ DioError on PUT: ${e.message}');
      log('   Type: ${e.type}');
      log('   Status Code: ${e.response?.statusCode}');
      log('   Data: ${e.response?.data}');
      rethrow;
    }
  }
}
