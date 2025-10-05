/// constant class is used to keep the constant error messages.
class Constants {
  // Error messages
  // Text validation message messages
  static const String emptyTextErrorMessage = "This field should not be empty.";
  static const String minLengthErrorMessage =
      "Field should contain at least %s characters.";
  static const String maxLengthErrorMessage =
      "Field should not exceed %s characters.";

  // Password validation message messages
  static const String invalidPasswordErrorMessage =
      "Please enter a valid password.";
  static const String emptyPasswordErrorMessage = "Please enter the password.";
  static const String lowerCasePasswordErrorMessage =
      "Please include a lower case letter in your password.";
  static const String upperCasePasswordErrorMessage =
      "Please include an upper case letter in your password.";
  static const String numberPasswordErrorMessage =
      "Please include a number in your password.";
  static const String specialPasswordErrorMessage =
      "Please include a special character in your password.";
  static const String minPasswordLengthErrorMessage =
      "Password should contain at least %s characters.";
  static const String maxPasswordLengthErrorMessage =
      "Password should not exceed %s characters.";

  // Email validation message messages
  static const String emptyEmailErrorMessage =
      "Please enter the email address.";
  static const String invalidEmailErrorMessage =
      "Please enter the valid email address.";

  // Phone number validation messages
  static const String emptyPhoneNumberErrorMessage =
      "Please enter the phone number.";
  static const String maxPhoneNumberLengthErrorMessage =
      "Phone number should not exceed %s digits.";
  static const String alphabetPhoneNumberErrorMessage =
      "Please enter only the numbers.";

  // Url  validation messages
  static const String emptyUrlErrorMessage =
      "Please enter the URL. ex: https://www.url.com";
  static const String invalidUrlErrorMessage =
      "Please enter the valid URL. ex: https://www.url.com";

  // Regex
  static RegExp passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  static RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp urlRegex = RegExp(
      r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?');
}
