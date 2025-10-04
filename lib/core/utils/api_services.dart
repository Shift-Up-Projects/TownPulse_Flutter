import 'dart:developer';
import 'package:dio/dio.dart';

class Api {
  // 1. المتغير الخاص الذي سيحمل نسخة Dio
  final Dio _dio;

  // 2. Constructor خاص لمنع إنشاء نسخ جديدة من الخارج
  Api._(this._dio);

  // 3. متغير Singleton ثابت ليحمل النسخة الوحيدة من الكلاس
  static Api? _instance;

  // 4. دالة التهيئة المركزية (يجب استدعاؤها في main.dart)
  static void init() {
    // تأكد من عدم تهيئة الكلاس أكثر من مرة
    if (_instance == null) {
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://townpulse-backend-fehi.onrender.com/api/v1.0.0/',
          receiveDataWhenStatusError: true,
          // تعطيل المتابعة التلقائية لنعالجها يدويًا
          followRedirects: false,
          // قبول أي status code حتى نتمكن من فحصه يدويًا
          validateStatus: (status ) => status != null,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      // إنشاء النسخة الوحيدة من الكلاس
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

  // --- دالة POST المحدثة بالكامل ---
  Future<Response> post({
    required String url,
    required dynamic body,
    String? token,
    int retryCount = 1, // عدد محاولات إعادة الطلب
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

  // --- دالة GET (مثال للتوافق مع النمط الجديد) ---
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

// يمكنك إضافة دوال PUT و DELETE بنفس الطريقة إذا احتجت إليها
}
