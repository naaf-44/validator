/// constant class is used to keep the constant error messages.
class Constants {
  // Error messages
  // Text validation message
  static const String emptyTextErrorMessage = "This field shouldn't be empty";
  static String minLengthErrorMessage = "Field should contain at least %s characters.";
  static String maxLengthErrorMessage = "Field should not exceed %s characters.";

  // Password validation message
  static const String invalidPasswordErrorMessage = "Please enter a valid password";
  static const String emptyPasswordErrorMessage = "Please enter the password.";
  static const String lowerCasePasswordErrorMessage = "Please include a lower case letter in your password";
  static const String upperCasePasswordErrorMessage = "Please include an upper case letter in your password";
  static const String numberPasswordErrorMessage = "Please include a number in your password";
  static const String specialPasswordErrorMessage = "Please include a special character in your password";
  static String minPasswordLengthErrorMessage = "Password should contain at least %s characters";

  // Regex
  static RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
}
