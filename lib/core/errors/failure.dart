import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioException(DioException dioException) {
    if (dioException.response == null) {
      final message = dioException.message;
      if (message != null && message.contains('SocketException')) {
        return ServerFailure('لا يوجد اتصال بالإنترنت');
      }
      return ServerFailure('خطأ في الاتصال بالسيرفر. تحقق من الشبكة.');
    }

    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('انتهت مهلة الاتصال بالسيرفر');
      case DioExceptionType.sendTimeout:
        return ServerFailure('انتهت مهلة الإرسال للسيرفر');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('انتهت مهلة استلام الرد من السيرفر');
      case DioExceptionType.badCertificate:
        return ServerFailure('شهادة اتصال غير موثوقة');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode ?? 500,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('تم إلغاء الطلب');
      case DioExceptionType.connectionError:
        return ServerFailure('فشل الاتصال بالسيرفر');
      case DioExceptionType.unknown:
        final message = dioException.message;
        if (message != null && message.contains('SocketException')) {
          return ServerFailure('لا يوجد اتصال بالإنترنت');
        } else {
          return ServerFailure('حدث خطأ غير متوقع، حاول لاحقاً');
        }
      default:
        return ServerFailure('حدث خطأ غير متوقع، حاول لاحقاً');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 402) {
      if (response != null && response is Map<String, dynamic>) {
        if (response['message'] != null) {
          return ServerFailure(response['message'].toString());
        }
        if (response['error'] != null &&
            response['error'] is Map &&
            response['error']['message'] != null) {
          return ServerFailure(response['error']['message'].toString());
        }
      }
      return ServerFailure('فشل في المصادقة أو التحقق من البيانات.');
    } else if (statusCode == 404) {
      return ServerFailure('العنصر المطلوب غير موجود.');
    } else if (statusCode == 500) {
      return ServerFailure('خطأ داخلي في السيرفر.');
    } else {
      return ServerFailure('حدث خطأ غير متوقع، يرجى المحاولة لاحقاً.');
    }
  }
}
