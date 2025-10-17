import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        // TODO: Handle this case.
        return ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        // TODO: Handle this case.
        return ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
        return ServerFailure('badCertificate  with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode ?? 405,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request From ApiServer was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure('Connection Error with Api');
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        } else {
          return ServerFailure('UnExpected Error , Please try later');
        }

      default:
        return ServerFailure('Oops , there was an error , try later');
    }
  }  factory ServerFailure.fromResponse(int statusCode, dynamic response){
    if(statusCode ==400||statusCode==401 ||statusCode==402){
      return ServerFailure(response['message']);
    }else if(statusCode ==404){

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 402) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {

      return ServerFailure('Your Request not found , Please try later');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server Error , Please try later');
    } else {
      return ServerFailure('Oops , there was an error , Please try again');
    }
  }
}
