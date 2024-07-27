import 'package:bloc_project_structure/until/app_strings.dart';


class Validation {
  static String? emptyTextValidation(String text) {
    if (text == '') {
      return AppStrings.fieldIsEmpty;
    }
    return null;
  }

  // static Future<String?> phoneNumberTextValidation(String text) async {
  //   if (text == '') {
  //     return AppStrings.fieldIsEmpty;
  //   }else if(isValid == false){
  //     return AppStrings.enterValidMobileNumber;
  //   }
  //   return null;
  // }

  static String? emptyTextValidation1(String text) {
    if (text == '') {
      return "";
    }
    return null;
  }

  static String? emailValidator(String? email) {
    if (email == '') {
      return AppStrings.emailIsEmpty;
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email!)) {
      return AppStrings.pleaseEnterValidEmailAddress;
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password!.isEmpty) {
      return AppStrings.passwordIsEmpty;
    } else if (!password.contains(RegExp(r'[A-Z]'))) {
      return AppStrings.passwordUppercase;
    } else if (!password.contains(RegExp(r'[a-z]'))) {
      return AppStrings.passwordLowerCase;
    } else if (!password.contains(RegExp(r'[0-9]'))) {
      return AppStrings.passwordDigit;
    } else if (!password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return AppStrings.passwordSpecialCharacter;
    } else if (password.length < 8) {
      return AppStrings.passwordShouldBe8CharacterLong;
    }
    return null;
  }

  static String? confirmPasswordValidator(
      String? confirmPassword, String? password) {
    if (confirmPassword == '') {
      return AppStrings.confirmPasswordIsEmpty;
    } else if (password!.trim().length < 8) {
      return AppStrings.passwordShouldBe8CharacterLong;
    } else if (confirmPassword != password) {
      return AppStrings.passwordAreNotSame;
    }
    return null;
  }

  static String? otpPinValidator(String? pin) {
    if (pin == '') {
      return AppStrings.otpPinIsEmpty;
    } else if (pin!.trim().length < 4) {
      return AppStrings.otpPinShouldBe4CharacterLong;
    }
    return null;
  }
}
