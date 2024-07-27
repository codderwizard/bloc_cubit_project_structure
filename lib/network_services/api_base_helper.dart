import 'dart:convert';
import 'package:bloc_project_structure/network_services/api_interceptors.dart';
import 'package:bloc_project_structure/until/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ApiBaseHelper {
  static Future<BaseOptions> createDioObject() async {
    return BaseOptions(
      connectTimeout: const Duration(milliseconds: 12000),
      receiveTimeout: const Duration(milliseconds: 20000),
    );
  }

  static Future<Dio> dioClient() async {
    final baseOptions = await createDioObject();
    Dio dio = Dio(baseOptions)..interceptors.add(ApiInterceptors());
    return dio;
  }

  static Dio? dio;

  static Dio getDio() {
    if (dio == null) {
      dio = Dio();
      dio!.options.connectTimeout = const Duration(milliseconds: 6000);
      dio!.interceptors.add(ApiInterceptors());
    }
    return dio!;
  }

  Future<Map<String, dynamic>?> get(String url,
      {Map<String, dynamic>? queryParameters,Options? optionsData,bool showLoader = true}) async {
    Dio dio = await dioClient();
    try {
      if(showLoader) EasyLoading.show();

      final response = await dio.get(url,queryParameters: queryParameters,options: optionsData);
      logger.debug("response Get API ${response.data}");
      return {
        "code": response.statusCode,
        "status": "Success",
        "message": response.statusMessage,
        "data": response.data
      };
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          debugPrint('This is 401 code in get api');
        } else {
          // Map<String,String> errorMessage = e.response?.data;
          return {
            "code": e.response?.statusCode,
            "status": "Fail",
            "message": e.response?.statusMessage,
            "data": {}
          };
        }
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> post(String url,
      {Map<String, dynamic>? reqBody,Options? optionsData,Map<String, dynamic>? queryParametersData,bool showLoader = true}) async {
    Dio dio = await dioClient();
    try {
      if(showLoader) EasyLoading.show();

      final response = await dio.post(url, data: jsonEncode(reqBody),options: optionsData,queryParameters: queryParametersData);
      // jsonEncode(reqBody)
      logger.debug("API -- Message ${response.statusMessage}");
      return {
        "code": response.statusCode,
        "status": "Success",
        "message": response.statusMessage,
        "data": response.data
      };
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          logger.debug("This is 401 code in post api");
          return {
            "code": e.response?.statusCode,
            "status": "Fail",
            "message": e.response?.data ?? e.response!.statusMessage,
            "data": {}
          };
        } else {
          logger.error("API -- Error Message ${e.response?.statusMessage}");
          logger.error("API -- Error data ${e.response!.data}");
          logger.error("API -- Error data ${e.response!.extra.toString()}");
          logger.error(
              "API -- Error headers ${e.response?.headers['set-cookie']}");
          logger.error("API -- Error statusCode ${e.response?.statusCode}");
          return {
            "code": e.response?.statusCode,
            "status": "Fail",
            "message": e.response?.data ?? e.response!.statusMessage,
            "data": {}
          };
        }
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> patch(String url,
      {Map<String, dynamic>? reqBody,Options? optionsData,bool showLoader = true}) async {
    Dio dio = await dioClient();
    try {
      if(showLoader) EasyLoading.show();
      final response = await dio.patch(url, data: jsonEncode(reqBody),options: optionsData);
      logger.debug("API -- Message ${response.statusMessage}");
      return {
        "code": response.statusCode,
        "status": "Success",
        "message": response.statusMessage,
        "data": response.data
      };
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          logger.debug("This is 401 code in post api");
          return {
            "code": e.response?.statusCode,
            "status": "Fail",
            "message": e.response?.data ?? e.response!.statusMessage,
            "data": {}
          };
        } else {
          logger.error("API -- Error Message ${e.response!.statusMessage}");
          logger.error("API -- Error data ${e.response!.data}");
          logger.error("API -- Error data ${e.response!.extra.toString()}");
          logger.error(
              "API -- Error headers ${e.response?.headers['set-cookie']}");
          logger.error("API -- Error statusCode ${e.response?.statusCode}");
          return {
            "code": e.response?.statusCode,
            "status": "Fail",
            "message": e.response?.data ?? e.response!.statusMessage,
            "data": {}
          };
        }
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> put(String url,
      {Map<String, dynamic>? reqBody,Options? optionsData,bool showLoader = true}) async {
    Dio dio = getDio();
    try {
      if(showLoader) EasyLoading.show();
      final response = await dio.put(url,data: jsonEncode(reqBody),options: optionsData);
      logger.debug("API -- Message ${response.statusMessage}");
      return {
        "code": response.statusCode,
        "status": "Success",
        "message": response.statusMessage,
        "data": response.data
      };
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          debugPrint('this is 401 code in put api');
        } else {
          Map<String, String> errorMessage = e.response?.data;
          return {
            "code": e.response?.statusCode,
            "status": "Fail",
            "message": errorMessage['message'],
            "data": {}
          };
        }
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> delete(String url,
      {Options? optionsData, Map<String, dynamic>? queryParameters,bool showLoader = true}) async {
    Dio dio = getDio();
    try {
      if(showLoader) EasyLoading.show();
      final response = await dio.delete(
        url,
        queryParameters: queryParameters,
        options: optionsData
      );
      return {
        "code": response.statusCode,
        "status": "Success",
        "message": response.statusMessage,
        "data": response.data
      };
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          logger.debug("This is 401 code in delete api");
          return {
            "code": e.response?.statusCode,
            "status": "Fail",
            "message": e.response?.data ?? e.response!.statusMessage,
            "data": {}
          };
        } else {
          logger.error("API delete -- Error Message ${e.response!.statusMessage}");
          logger.error("API delete -- Error data ${e.response!.data}");
          logger.error("API delete -- Error data ${e.response!.extra.toString()}");
          logger.error(
              "API delete -- Error headers ${e.response?.headers['set-cookie']}");
          logger.error("API delete -- Error statusCode ${e.response?.statusCode}");
          return {
            "code": e.response?.statusCode,
            "status": "Fail",
            "message": e.response?.data ?? e.response!.statusMessage,
            "data": {}
          };
        }
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> multiPartPatch(String url,
      {FormData? formData,Options? optionsData,bool showLoader = true}) async {
    Dio dio = getDio();
    try {
      if(showLoader) EasyLoading.show();
      final response = await dio.patch(url, data: formData,options: optionsData);
      logger.debug("API -- Message ${response.statusMessage}");
      return {
        "code": response.statusCode,
        "status": "Success",
        "message": response.statusMessage,
        "data": response.data
      };
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          logger.error('this is 401 code in multipart Patch api');
        } else {
          // var errorMessage = e.response?.data;
          logger.error('Error in Multipart API statusCode - ${e.response?.statusCode}');
          logger.error('Error in Multipart API - ${e.response?.data}');
          logger.error('Error in Multipart API - ${e.response?.statusMessage}');
          return {
            "code": e.response?.statusCode,
            "status": "Fail",
            "message": e.response?.statusMessage ?? e.response?.data ?? "",
            "data": {}
          };
        }
      }
    }
    return null;
  }
}
