import 'dart:convert';
import 'dart:io';
import 'package:bloc_project_structure/network_services/api_base_helper.dart';
import 'package:bloc_project_structure/shared_preferences/shared_preference.dart';
import 'package:bloc_project_structure/shared_preferences/shared_preference_keys.dart';
import 'package:bloc_project_structure/until/logger.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

extension on String {
  bool containsAny(List<String> values) {
    for (final value in values) {
      if (contains(value)) {
        return true;
      }
    }
    return false;
  }
}

class ApiInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final method = options.method;
    final uri = options.uri;
    final data = options.data;
    String? token =
        await SharedPrefUtils().getStringValue(SharedKeys.authToken);
    logger.debug(
        "check == auth token ${options.headers.containsKey("requiresToken")} ${options.headers}");
    if (method != 'GET') {
      options.headers['Authorization'] = 'Bearer $token';
    } else {
      options.headers['Authorization'] = 'Bearer $token';
    }
    logger.log(
        "\n\n--------------------------------------------------------------------------------------------------------");
    if (method == 'GET') {
      logger.log(
          "✈️ REQUEST[$method] => PATH: $uri \n Headers: ${options.headers}",
          printFullText: true);
    } else {
      try {
        logger.log(
            "✈️ REQUEST[$method] => PATH: $uri \n Headers: ${options.headers} \n DATA: ${json.encode(data)}",
            printFullText: true);
      } catch (e) {
        logger.log(
            "✈️ REQUEST[$method] => PATH: $uri \n Headers: ${options.headers} \n DATA: $data",
            printFullText: true);
      }
    }
    super.onRequest(options, handler);
  }

  Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id.toString(); // unique ID on Android
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor.toString(); // unique ID on iOS
    } else {
      return "";
    }
  }

  Future<String?> getDeviceOSType() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.version.release
          .toString(); // unique ID on Android
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.systemVersion.toString(); // unique ID on iOS
    } else {
      return "";
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    EasyLoading.dismiss();
    final statusCode = response.statusCode;
    final uri = response.requestOptions.uri;
    logger.debug('this is response in api interceptors ==>  $response');
    final data = jsonEncode(response.data);
    logger.log("✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: $data",
        printFullText: true);
    //Handle section expired
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    EasyLoading.dismiss();
    final errorMessage = err.response?.data;
    logger.error(errorMessage);
    logger.error(err);
    final statusCode = err.response?.statusCode;
    final uri = err.requestOptions.path;
    var data = "";
    try {
      logger.debug(
          "Error Data -- 1 ${err.response!.headers['set-cookie']!.isNotEmpty || err.response!.headers['set-cookie']!.isNotEmpty} ${err.response!.headers['set-cookie'] != null} ${err.response!.headers['set-cookie']!.isNotEmpty}");
      if (err.response!.statusCode == 401) {
        Map<String, dynamic>? data =
            await ApiBaseHelper().post("Refresh Token URL");
        if (data?['code'] == 401) {
          logger.debug("Error Data refresh token -- 401");
        } else {
          Options options = Options();
          options.method = err.response!.requestOptions.method;
          options.headers!['Authorization'] =
              'Bearer ${data?['data']['accessToken']}';
          try {
            var response = await ApiBaseHelper.getDio().request(
                err.response!.requestOptions.uri.toString(),
                data: err.response!.requestOptions.data,
                queryParameters: err.response!.requestOptions.queryParameters,
                options: options);
            return handler.resolve(response);
          } on DioException catch (e) {
            debugPrint(e.toString());
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    logger.log("⚠️ ERROR[$statusCode] => PATH: $uri\n DATA: $data",
        printFullText: true);
    super.onError(err, handler);
  }
}
