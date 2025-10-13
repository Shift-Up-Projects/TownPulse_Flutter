import 'dart:developer';
import 'package:dio/dio.dart';

class Api {
  final Dio _dio;

  Api._(this._dio);

  static Api? _instance;

  static void init() {
    if (_instance == null) {
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://townpulse-backend-fehi.onrender.com/api/v1.0.0/',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status ) => status != null,
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

  // 5. Getter للوصول إلى النسخة الوحيدة من الكلاس
  static Api get instance {
    if (_instance == null) {
      throw Exception("Api provider not initialized. Call Api.init() in your main.dart file.");
    }
    return _instance!;
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

      Response response = await _dio.post(
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
        log('✅ Success Response Data: ${response.data}');
        return response;
      } else {
        // إذا فشل الطلب، أطلق استثناءً
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Request failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      log('❌ DioError on POST: ${e.message}');
      if (e.response != null) {
        log('   Error Response Data: ${e.response?.data}');
      }
      rethrow; // أعد إلقاء الاستثناء ليتم التعامل معه في الـ Repo
    } catch (e) {
      log('❌ An unexpected error occurred in post: $e');
      rethrow;
    }
  }

  Future<Response> get({required String url, String? token}) async {
    try {
      log('➡️ GET Request to: $url');
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        log('✅ GET Success Response');
        return response;
      } else {
        throw DioException(requestOptions: response.requestOptions, response: response);
      }
    } on DioException catch (e) {
      log('❌ DioError on GET: ${e.message}');
      rethrow;
    }
  }

}
