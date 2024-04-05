library text_field_validator;

import 'package:text_field_validator/Constants.dart';

/// TextFieldValidator class is a class to provide validations for the input.
class TextFieldValidator {

  /// textValidator provides validation for the TextFormField input.
  ///
  /// parameters
  /// 1. text
  /// 2. minLength
  /// 3. maxLength
  /// 4. emptyNameErrorMessage defaultMessage: Please enter.
  /// 5. minLengthErrorMessage defaultMessage: Name should contain at least %s characters.
  /// 6. maxLengthErrorMessage defaultMessage: Name should not exceed %s characters.
  static textValidator({String? value, int? minLength, int? maxLength, String? emptyNameErrorMessage, String? minLengthErrorMessage, String? maxLengthErrorMessage}) {
    if (value == null || value.isEmpty) {
      return emptyNameErrorMessage ?? Constants.emptyTextErrorMessage;
    } else if (minLength != null && value.length < minLength) {
      String minMessage = Constants.minLengthErrorMessage.replaceAll("%s", "$minLength");
      return minLengthErrorMessage ?? minMessage;
    } else if (maxLength != null && value.length > maxLength) {
      String maxMessage = Constants.maxLengthErrorMessage.replaceAll("%s", "$maxLength");
      return maxLengthErrorMessage ?? maxMessage;
    }

    return "";
  }

  /// passWordValidator provides validation for the TextFormField password type.
  /// Used regex: RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
  ///
  /// parameters
  /// password
  /// lowerCaseRequired
  /// upperCaseRequired
  /// specialCharactersRequired
  /// numbersRequired
  /// specialCharacters
  /// emptyPasswordErrorMessage default message: Please enter the password.
  /// invalidPasswordErrorMessage default message: Please enter a valid password
  /// lowercaseErrorMessage default message: Please include a lower case letter in your password
  /// uppercaseErrorMessage default message: Please include an upper case letter in your password
  /// numberErrorMessage default message: Please include a number in your password
  /// specialCharacterErrorMessage default message: Please include a special character in your password
  /// minPasswordLengthErrorMessage default message: Password should contain at least %s characters
  static passWordValidator({
    String? password,
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
    String? minPasswordLengthErrorMessage,
  }) {
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
