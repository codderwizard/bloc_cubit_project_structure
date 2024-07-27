import 'package:bloc_project_structure/network_services/api_base_helper.dart';
import 'package:bloc_project_structure/network_services/api_constants.dart';

class AuthenticationRepository {
  AuthenticationRepository._privateConstructor();

  static final AuthenticationRepository instance =
      AuthenticationRepository._privateConstructor();

  factory AuthenticationRepository() {
    return instance;
  }

  Future<Map<String, dynamic>?> registerUserApi({
    String? phoneNumber,
    String? countryCode,
    String? email,
  }) {
    Map<String, dynamic> param = {
      "registrableEmail": {"value": email},
      "verificationGateway": {
        "channel": {
          "phoneNumber": phoneNumber,
          "countryCode": countryCode,
        },
        "type": "SMS"
      }
    };
    return ApiBaseHelper().post(ApiConstant.registrationApiUrl, reqBody: param);
  }

}
