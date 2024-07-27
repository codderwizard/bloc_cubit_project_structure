import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  ///API Base URL
  static String baseUrl = dotenv.env['API_BASE_PATH']!;

  ///API End Points
  static final registrationApiUrl = '$baseUrl/registrations/otp'; //Register User API

}

///API Header values
class Constants {
  static const token = 'token';
  static const cookie = 'cookie';
  static Options optionsData = Options(headers: {"requiresToken" : true});
  static Options optionsData2 = Options();
}
