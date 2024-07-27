import 'package:dio/dio.dart';

class DioErrorExp{
  String msg;
  int code;
  DioErrorExp({required this.msg, required this.code});
}

class DioExceptions implements Exception {

  static DioErrorExp fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return DioErrorExp(msg:"Request cancelled!", code: 499);
      case DioExceptionType.connectionTimeout:
        return DioErrorExp(msg:"Connection timeout!", code: 408);
      case DioExceptionType.receiveTimeout:
        return DioErrorExp(msg:"Receive timeout!", code: 408);
      case DioExceptionType.sendTimeout:
        return DioErrorExp(msg:"Send timeout!", code: 408);
      case DioExceptionType.badResponse:
        return _handleError((dioException.response?.statusCode ?? 0),
            dioException.response?.data);
      case DioExceptionType.unknown:
        return DioErrorExp(msg:"Connection problem!", code: 500);
      default:
        return DioErrorExp(msg:"Something went wrong!", code: 500);
    }
  }

  static DioErrorExp _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return DioErrorExp(msg:error['error'] ?? error["message"] ?? "Bad request", code: 400);
      case 401:
      case 403:
        return DioErrorExp(
          msg:error['error'] ?? error["message"] ?? "Unauthorised User",
          code: 403,
        );
      case 404:
        return DioErrorExp(msg:error['error'] ?? error["message"] ?? "Api Url Incorrect", code: 404);
      case 500:
        return DioErrorExp(msg:error['error'] ?? error["message"] ?? "Internal Server Error", code: 500);
      default:
        return DioErrorExp(msg:error['error'] ?? error["message"] ?? "Something went wrong!", code: 500);
    }
  }
}
