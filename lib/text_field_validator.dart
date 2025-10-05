library text_field_validator;

import 'package:text_field_validator/utils/constants.dart';

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
  static String? textValidator(
      {required String? value,
      int? minLength,
      int? maxLength,
      String? emptyNameErrorMessage,
      String? minLengthErrorMessage,
      String? maxLengthErrorMessage}) {
    if (value == null || value.isEmpty) {
      return emptyNameErrorMessage ?? Constants.emptyTextErrorMessage;
    } else if (minLength != null && value.length < minLength) {
      String minMessage =
          Constants.minLengthErrorMessage.replaceAll("%s", "$minLength");
      return minLengthErrorMessage ?? minMessage;
    } else if (maxLength != null && value.length > maxLength) {
      String maxMessage =
          Constants.maxLengthErrorMessage.replaceAll("%s", "$maxLength");
      return maxLengthErrorMessage ?? maxMessage;
    }

    return null;
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
  /// minPasswordLength default value: 8
  /// maxPasswordLength default value: 30
  /// emptyPasswordErrorMessage default message: Please enter the password.
  /// invalidPasswordErrorMessage default message: Please enter a valid password
  /// lowercaseErrorMessage default message: Please include a lower case letter in your password
  /// uppercaseErrorMessage default message: Please include an upper case letter in your password
  /// numberErrorMessage default message: Please include a number in your password
  /// specialCharacterErrorMessage default message: Please include a special character in your password
  /// minPasswordLengthErrorMessage default message: Password should contain at least %s characters
  static String? passWordValidator({
    required String? password,
    bool? lowerCaseRequired = true,
    bool? upperCaseRequired = true,
    bool? specialCharactersRequired = true,
    bool? numbersRequired = true,
    int? minPasswordLength = 8,
    int? maxPasswordLength = 30,
    String? specialCharacters = "!@#\$&*~",
    String? emptyPasswordErrorMessage,
    String? invalidPasswordErrorMessage,
    String? lowercaseErrorMessage,
    String? uppercaseErrorMessage,
    String? numberErrorMessage,
    String? specialCharacterErrorMessage,
    String? minPasswordLengthErrorMessage,
  }) {
    if (password == null || password.isEmpty) {
      return emptyPasswordErrorMessage ?? Constants.emptyPasswordErrorMessage;
    } else if (lowerCaseRequired! && !password.contains(RegExp(r'[a-z]'))) {
      return lowercaseErrorMessage ?? Constants.lowerCasePasswordErrorMessage;
    } else if (upperCaseRequired! && !password.contains(RegExp(r'[A-Z]'))) {
      return uppercaseErrorMessage ?? Constants.upperCasePasswordErrorMessage;
    } else if (numbersRequired! && !password.contains(RegExp(r'[0-9]'))) {
      return numberErrorMessage ?? Constants.numberPasswordErrorMessage;
    } else if (specialCharactersRequired! &&
        !password.contains(RegExp(r'[' + specialCharacters! + r']'))) {
      return specialCharacterErrorMessage ??
          Constants.specialPasswordErrorMessage;
    } else if (password.length < minPasswordLength!) {
      String errMessage = Constants.minPasswordLengthErrorMessage
          .replaceAll("%s", "$minPasswordLength");
      return minPasswordLengthErrorMessage ?? errMessage;
    } else if (password.length > maxPasswordLength!) {
      String errMessage = Constants.maxPasswordLengthErrorMessage
          .replaceAll("%s", "$maxPasswordLength");
      return minPasswordLengthErrorMessage ?? errMessage;
    }

    return null;
  }

  /// emailValidator provides validation for the TextFormField email type.
  /// Used regex: RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  ///
  /// parameters
  /// email, it is a required field.
  /// emptyEmailErrorMessage default message: Please enter the email address.
  /// invalidEmailErrorMessage default message: Please enter the valid email address.
  static String? emailValidator({
    required String? email,
    String? emptyEmailErrorMessage,
    String? invalidEmailErrorMessage,
  }) {
    if (email == null || email.isEmpty) {
      return emptyEmailErrorMessage ?? Constants.emptyEmailErrorMessage;
    } else if (!Constants.emailRegex.hasMatch(email)) {
      return invalidEmailErrorMessage ?? Constants.invalidEmailErrorMessage;
    }
    return null;
  }

  /// phoneValidator provides validation for the TextFormField phone type.
  ///
  /// parameters
  /// phoneNumber: it is a required parameter.
  /// maxLength default value: 10
  /// emptyPhoneNumberErrorMessage default message: Please enter the phone number.
  /// maxLengthPhoneNumberErrorMessage default message: Phone number should not exceed %s digits.
  /// alphabetsPhoneNumberErrorMessage default message: Please enter only the numbers.
  static String? phoneValidator({
    required String? phoneNumber,
    int? maxLength = 10,
    String? emptyPhoneNumberErrorMessage,
    String? maxLengthPhoneNumberErrorMessage,
    String? alphabetsPhoneNumberErrorMessage,
  }) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return emptyPhoneNumberErrorMessage ??
          Constants.emptyPhoneNumberErrorMessage;
    } else if (phoneNumber.contains(RegExp(r'[a-zA-Z]'))) {
      return alphabetsPhoneNumberErrorMessage ??
          Constants.alphabetPhoneNumberErrorMessage;
    } else if (phoneNumber.length > maxLength!) {
      return maxLengthPhoneNumberErrorMessage ??
          Constants.maxPhoneNumberLengthErrorMessage
              .replaceAll("%s", "$maxLength");
    }

    return null;
  }

  /// phoneValidator provides validation for the TextFormField phone type.
  /// Regex used RegExp(r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?')
  ///
  /// parameters
  /// url : it is a required parameter
  /// emptyUrlErrorMessage default message: Please enter the URL. ex: https://www.url.com
  /// invalidUrlErrorMessage default message: Please enter the valid URL. ex: https://www.url.com
  static String? urlValidator({
    required String? url,
    String? emptyUrlErrorMessage,
    String? invalidUrlErrorMessage,
  }) {
    if (url == null || url.isEmpty) {
      return emptyUrlErrorMessage ?? Constants.emptyUrlErrorMessage;
    } else {
      if (!Constants.urlRegex.hasMatch(url)) {
        return invalidUrlErrorMessage ?? Constants.invalidUrlErrorMessage;
      } else {
        String lastPart = url.split(".").last;
        if (lastPart.isEmpty) {
          return invalidUrlErrorMessage ?? Constants.invalidUrlErrorMessage;
        }
      }
    }

    return null;
  }
}
