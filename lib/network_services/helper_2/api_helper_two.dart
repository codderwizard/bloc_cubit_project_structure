import 'dart:io';
import 'package:bloc_project_structure/shared_preferences/shared_preference.dart';
import 'package:bloc_project_structure/shared_preferences/shared_preference_keys.dart';
import 'package:bloc_project_structure/until/app_strings.dart';
import 'package:bloc_project_structure/until/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as d;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'api_exceptions.dart';

const int _connectTimeout = 10000;
const int _receiveTimeout = 10000;
const int _sendTimeout = 10000;

typedef Success<T> = Function(T data);
typedef Fail = Function(dynamic code, String msg);

class HttpRequest {
  static d.Dio? dio;

  HttpRequest._() {
    dio = createInstance();
  }
  factory HttpRequest() {
    if (dio == null) {
      HttpRequest._();
    }
    return HttpRequest._();
  }

  /// Create Dio Instance
  static d.Dio createInstance() {
    var options = d.BaseOptions(
      contentType: d.Headers.jsonContentType,
      responseType: d.ResponseType.json,
      validateStatus: (status) {
        return true;
      },
      baseUrl: '',
      // sendTimeout: _sendTimeout.milliseconds,
      // connectTimeout: _connectTimeout.milliseconds,
      // receiveTimeout: _receiveTimeout.milliseconds,
    );
    var dioInstance = d.Dio(options);

    dioInstance.interceptors.add(d.InterceptorsWrapper(
      onRequest: (options, handler) {
        // Do something before request is sent

        logger.debug("Api Url ======> ${options.baseUrl + options.path}");
        logger.debug("Body ======> ${options.data}");
        logger.debug("Headers ======> ${options.headers}");
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response); // continue
      },
      onError: (d.DioException e, handler) async {
        // Do something with response error
        DioErrorExp err = DioExceptions.fromDioError(e);
        logger.error("Code      ======> ${e.error}");
        logger.error("Message   ======> ${e.message}");
        // Check if error is due to expired token
        return handler.next(e); //continue
      },
    ));
    return dioInstance;
  }

  /// Custom Request Method
  static Future request<T>({
    required Method method,
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool showLoader = true,
    bool isFormData = false,
    required Success onSuccess,
    required Fail onError,
  }) async {
    logger.debug("API URL - $url");
    String? token =
    await SharedPrefUtils().getStringValue(SharedKeys.authToken);
    var   head = {
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      // if (showLoader) AppUtils.showLoading();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        // if (showLoader) AppUtils.hideLoading();
        return onError(500, 'No Internet!');
      }
      d.Dio dio = createInstance();
      var response = await dio.request(
        url,
        queryParameters: queryParameters,
        data:
        isFormData == true ? d.FormData.fromMap(body ?? {}) : (body ?? {}),
        options: d.Options(
          method: _methodValues[method],
          headers: isFormData == false ? head : headers,
        ),
      );
      logger.debug("Body :: $url ------>> $body");
      // if (showLoader) AppUtils.hideLoading();
      debugPrint("Response code =========>>>>>>>>Refreshed $response");
      _returnResponse(response.data, onSuccess, onError,response);
    } on SocketException {
      // if (showLoader) AppUtils.hideLoading();
      onError(1000, 'No Internet Connection!');
    } on d.DioException catch (e) {
      DioErrorExp err = DioExceptions.fromDioError(e);
      debugPrint("Response code ::::::::::::${e.toString()}");
      // if (showLoader) AppUtils.hideLoading();
      debugPrint("Response code ::::::::::::${e.toString()}");
      debugPrint("Response message${err.msg}");
      onError(err.code, err.msg);
    }
  }
}

dynamic _returnResponse(dynamic response, Success success, Fail fail,dynamic response2) async {
  debugPrint("Response ----------->>>>> ${response.toString()}");
  debugPrint("Response check ${response['code']} ${response['success']}");
  if(response['success'] == true){
    return success(response);
  }else{
    // DioErrorExp err = DioExceptions.fromDioError(e);
    logger.log("Call to refresh ${response['code']}");
    if (response['code'] == 401) {
      logger.debug("Call to refresh newToken ${AppStrings.refreshToken}");
      // Do refrsh token here
      if (AppStrings.refreshToken != null) {
        // Retry the request with the new token

        final requestOptions = response2.requestOptions;
        logger.debug("Call to refresh newToken ${requestOptions.path}");
        requestOptions.headers['Authorization'] = 'Bearer ${AppStrings.refreshToken}';
        final cloneReq = await Dio().request(
          requestOptions.path,
          options: Options(
            method: requestOptions.method,
            headers: requestOptions.headers,
          ),
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
        );
        print("return success -- 1 ${cloneReq.data}");
        if(cloneReq.data['success'] == true){
          print("return success -- 2 ${cloneReq.data}");
          success(cloneReq.data);
        }else{
          print("return success -- 3 ${cloneReq.data}");
          return fail(cloneReq.data['code'], cloneReq.data['message']);
        }
        // return _returnResponse(cloneReq.data, success, fail,cloneReq);
      }
    }else {
      return fail(response['code'], response['message']);
    }
  }
}

/// Method Enum
enum Method { get, post, delete, put, patch, head }

const _methodValues = {
  Method.get: "GET",
  Method.post: "POST",
  Method.delete: "DELETE",
  Method.put: "PUT",
  Method.patch: "PATCH",
  Method.head: "HEAD",
};



