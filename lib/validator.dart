library validator;

import 'package:validator/Constants.dart';

class Validator {
  static nameValidator({String? name, int? minLength, int? maxLength, String? emptyNameErrorMessage, String? minLengthErrorMessage, String? maxLengthErrorMessage}) {
    if (name == null || name.isEmpty) {
      return emptyNameErrorMessage ?? Constants.emptyNameErrorMessage;
    } else if (minLength != null && name.length < minLength) {
      String minMessage = Constants.minLengthErrorMessage.replaceAll("%s", "$minLength");
      return minLengthErrorMessage ?? minMessage;
    } else if (maxLength != null && name.length > maxLength) {
      String maxMessage = Constants.maxLengthErrorMessage.replaceAll("%s", "$maxLength");
      return maxLengthErrorMessage ?? maxMessage;
    }

    return "";
  }

  static passWordValidator({
    String? password,
    //RegExp? regExp,
    bool? lowerCaseRequired = true,
    bool? upperCaseRequired = true,
    bool? specialCharactersRequired = true,
    bool? numbersRequired = true,
    int? minPasswordLength = 8,
    String? specialCharacters = "!@#\$&*~",
    String? emptyPasswordErrorMessage,
    String? invalidPasswordErrorMessage,
    String? lowercaseErrorMessage,
    String? uppercaseErrorMessage,
    String? numberErrorMessage,
    String? specialCharacterErrorMessage,
    String ? minPasswordLengthErrorMessage,
  }) {
    //RegExp passwordRegex = regExp ?? Constants.passwordRegex;
    String specialCharacterPattern = "r'[$specialCharacters]'";
    if (password == null || password.isEmpty) {
      return emptyPasswordErrorMessage ?? Constants.emptyPasswordErrorMessage;
    } else if (lowerCaseRequired! && password.contains(RegExp(r'[a-z]'))) {
      return lowercaseErrorMessage ?? Constants.lowerCasePasswordErrorMessage;
    } else if (upperCaseRequired! && password.contains(RegExp(r'[A-Z]'))) {
      return uppercaseErrorMessage ?? Constants.upperCasePasswordErrorMessage;
    } else if (numbersRequired! && password.contains(RegExp(r'[0-9]'))) {
      return numberErrorMessage ?? Constants.numberPasswordErrorMessage;
    } else if (specialCharactersRequired! && password.contains(RegExp(specialCharacterPattern))) {
      return lowercaseErrorMessage ?? Constants.lowerCasePasswordErrorMessage;
    } else if(password.length < minPasswordLength!){
      String errMessage = Constants.minPasswordLengthErrorMessage.replaceAll("%s", "$minPasswordLength");
      return minPasswordLengthErrorMessage ?? errMessage;
    }

    return "";
  }
}
