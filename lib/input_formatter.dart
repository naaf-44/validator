import 'package:flutter/services.dart';

/// InputFormatter class is a class to provide various input formatters for text fields.
class InputFormatter {
  /// numberFormatter allows only numeric input.
  static List<TextInputFormatter> numberFormatter() {
    return [FilteringTextInputFormatter.digitsOnly];
  }

  /// upperCaseFormatter converts all input to uppercase.
  static List<TextInputFormatter> upperCaseFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        return newValue.copyWith(text: newValue.text.toUpperCase());
      }),
    ];
  }

  /// lowerCaseFormatter converts all input to lowercase.
  static List<TextInputFormatter> lowerCaseFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        return newValue.copyWith(text: newValue.text.toLowerCase());
      }),
    ];
  }

  /// decimalFormatter allows numeric input including a single decimal point.
  /// [decimalRange] specifies the maximum number of digits allowed after the decimal point.
  static List<TextInputFormatter> decimalFormatter({int? decimalRange}) {
    if (decimalRange == null) {
      // Default: allow any number of decimals
      return [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))];
    } else {
      return [
        TextInputFormatter.withFunction((oldValue, newValue) {
          final text = newValue.text;
          final regExp =
              RegExp(r'^\d*\.?\d{0,' + decimalRange.toString() + r'}$');
          if (regExp.hasMatch(text)) {
            return newValue;
          }
          return oldValue;
        }),
      ];
    }
  }

  /// alphabetFormatter allows only alphabetic input.
  static List<TextInputFormatter> alphabetFormatter() {
    return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))];
  }

  /// alphaNumericFormatter allows alphanumeric input.
  static List<TextInputFormatter> alphaNumericFormatter() {
    return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))];
  }

  /// noLeadingSpaceFormatter prevents leading spaces.
  static List<TextInputFormatter> noLeadingSpaceFormatter() {
    return [
      FilteringTextInputFormatter.deny(RegExp(r'^\s')),
    ];
  }

  /// noDoubleSpaceFormatter prevents multiple consecutive spaces.
  static List<TextInputFormatter> noDoubleSpaceFormatter() {
    return [
      FilteringTextInputFormatter.deny(RegExp(r'\s\s')),
    ];
  }

  /// capitalizeFirstLetterFormatter capitalizes the first letter of each word.
  static List<TextInputFormatter> capitalizeFirstLetterFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        if (newValue.text.isEmpty) {
          return newValue;
        }
        final List<String> words = newValue.text.split(' ');
        final List<String> capitalizedWords = words.map((word) {
          if (word.isEmpty) {
            return '';
          }
          return word[0].toUpperCase() + word.substring(1);
        }).toList();
        return newValue.copyWith(text: capitalizedWords.join(' '));
      }),
    ];
  }

  /// creditCardNumberFormatter formats input as a credit card number (e.g., XXXX XXXX XXXX XXXX).
  static List<TextInputFormatter> creditCardNumberFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        String newText = newValue.text.replaceAll(RegExp(r'\s+\b|\b\s'), '');
        if (newText.length > 16) {
          newText = newText.substring(0, 16);
        }
        final StringBuffer buffer = StringBuffer();
        for (int i = 0; i < newText.length; i++) {
          buffer.write(newText[i]);
          final int index = i + 1;
          if (index % 4 == 0 && index != newText.length) {
            buffer.write(' '); // Add space after every 4 characters
          }
        }
        final String formattedText = buffer.toString();
        return TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }),
    ];
  }

  /// phoneNumberFormatter formats input as a phone number (e.g., (XXX) XXX-XXXX).
  static List<TextInputFormatter> phoneNumberFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        String newText = newValue.text.replaceAll(RegExp(r'\D'), '');
        if (newText.length > 10) {
          newText = newText.substring(0, 10);
        }
        final StringBuffer buffer = StringBuffer();
        int selectionIndex = newValue.selection.end;

        if (newText.isNotEmpty) {
          buffer.write('(');
          if (selectionIndex >= 1) selectionIndex++;
        }
        for (int i = 0; i < newText.length; i++) {
          if (i == 3) {
            buffer.write(') ');
            if (selectionIndex >= 3) selectionIndex += 2;
          } else if (i == 6) {
            buffer.write('-');
            if (selectionIndex >= 6) selectionIndex++;
          }
          buffer.write(newText[i]);
        }

        final String formattedText = buffer.toString();
        return TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: selectionIndex),
        );
      }),
    ];
  }

  /// customPatternFormatter formats input based on a custom pattern.
  /// Example pattern: "XXX-XXX-XXXX" where 'X' is a placeholder for user input.
  static List<TextInputFormatter> customPatternFormatter(String pattern,
      {String placeholder = 'X'}) {
    final List<TextInputFormatter> formatters = [];
    String formattedPattern = '';
    int placeholderCount = 0;
    for (int i = 0; i < pattern.length; i++) {
      final String char = pattern[i];
      if (char == placeholder) {
        placeholderCount++;
        formattedPattern += char;
      } else {
        formattedPattern += char;
      }
    }
    formatters.add(FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')));
    formatters.add(TextInputFormatter.withFunction((oldValue, newValue) {
      String newText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
      if (newText.length > placeholderCount) {
        newText = newText.substring(0, placeholderCount);
      }
      final StringBuffer buffer = StringBuffer();
      int textIndex = 0;
      for (int i = 0; i < formattedPattern.length; i++) {
        if (formattedPattern[i] == placeholder) {
          if (textIndex < newText.length) {
            buffer.write(newText[textIndex]);
            textIndex++;
          } else {
            break;
          }
        } else {
          buffer.write(formattedPattern[i]);
        }
      }
      final String formattedText = buffer.toString();
      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }));
    return formatters;
  }

  /// dateFormatter formats
  /// take format from the user like "MM/DD/YYYY" or "DD-MM-YYYY"
  static List<TextInputFormatter> dateFormatter(
    FormatterEnum formatEnum, {
    String dateSeparator = '-',
    String timeSeparator = ':',
  }) {
    // Replace date and time separators in the format string
    String format = formatEnum.formatString
        .replaceAll('-', dateSeparator)
        .replaceAll(':', timeSeparator)
        .toUpperCase();

    final List<TextInputFormatter> formatters = [];
    String formattedFormat = '';
    // Acceptable pattern chars: D, M, Y, H, S (for date and time)
    final validChars = {'D', 'M', 'Y', 'H', 'S'};

    for (int i = 0; i < format.length; i++) {
      final String char = format[i];
      if (validChars.contains(char)) {
        formattedFormat += char;
      } else {
        formattedFormat += char;
      }
    }

    formatters.add(FilteringTextInputFormatter.allow(RegExp('[0-9]')));
    formatters.add(TextInputFormatter.withFunction((oldValue, newValue) {
      String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
      int maxLength =
          formattedFormat.split('').where((c) => validChars.contains(c)).length;
      if (newText.length > maxLength) {
        newText = newText.substring(0, maxLength);
      }
      final StringBuffer buffer = StringBuffer();
      int textIndex = 0;
      for (int i = 0; i < formattedFormat.length; i++) {
        if (validChars.contains(formattedFormat[i])) {
          if (textIndex < newText.length) {
            buffer.write(newText[textIndex]);
            textIndex++;
          } else {
            break;
          }
        } else {
          if (textIndex < newText.length) {
            buffer.write(formattedFormat[i]);
          }
        }
      }
      final String formattedText = buffer.toString();
      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }));
    return formatters;
  }

  /// adharFormatter formats input as an Aadhaar number (e.g., XXXX XXXX XXXX).
  static List<TextInputFormatter> adharFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        String newText = newValue.text.replaceAll(RegExp(r'\s+\b|\b\s'), '');
        if (newText.length > 12) {
          newText = newText.substring(0, 12);
        }
        final StringBuffer buffer = StringBuffer();
        for (int i = 0; i < newText.length; i++) {
          buffer.write(newText[i]);
          final int index = i + 1;
          if (index % 4 == 0 && index != newText.length) {
            buffer.write(' '); // Add space after every 4 characters
          }
        }
        final String formattedText = buffer.toString();
        return TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }),
    ];
  }

  /// panFormatter formats input as a PAN number (e.g., XXXXX9999X).
  static List<TextInputFormatter> panFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        String newText = newValue.text.toUpperCase();
        if (newText.length > 10) {
          newText = newText.substring(0, 10);
        }
        final StringBuffer buffer = StringBuffer();
        for (int i = 0; i < newText.length; i++) {
          if (i < 5) {
            // First 5 characters should be alphabets
            if (RegExp(r'[A-Z]').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          } else if (i < 9) {
            // Next 4 characters should be digits
            if (RegExp(r'\d').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          } else {
            // Last character should be an alphabet
            if (RegExp(r'[A-Z]').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          }
        }
        final String formattedText = buffer.toString();
        return TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }),
    ];
  }

  /// gstFormatter formats input as a GST number (e.g., 22AAAAA0000A1Z5).
  static List<TextInputFormatter> gstFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        String newText = newValue.text.toUpperCase();
        if (newText.length > 15) {
          newText = newText.substring(0, 15);
        }
        final StringBuffer buffer = StringBuffer();
        for (int i = 0; i < newText.length; i++) {
          if (i < 2) {
            // First 2 characters should be digits
            if (RegExp(r'\d').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          } else if (i < 12) {
            // Next 10 characters should be alphabets or digits
            if (RegExp(r'[A-Z0-9]').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          } else if (i == 12) {
            // 13th character should be an alphabet
            if (RegExp(r'[A-Z]').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          } else if (i == 13) {
            // 14th character should be a digit
            if (RegExp(r'\d').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          } else {
            // Last character should be an alphabet
            if (RegExp(r'[A-Z]').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          }
        }
        final String formattedText = buffer.toString();
        return TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }),
    ];
  }

  /// zipCodeFormatter formats input as a ZIP code (e.g., XXXXX or XXXXX-XXXX).
  static List<TextInputFormatter> zipCodeFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        String newText = newValue.text.replaceAll(RegExp(r'\D'), '');
        if (newText.length > 9) {
          newText = newText.substring(0, 9);
        }
        final StringBuffer buffer = StringBuffer();
        for (int i = 0; i < newText.length; i++) {
          buffer.write(newText[i]);
          if (i == 4 && newText.length > 5) {
            buffer.write(
                '-'); // Add hyphen after first 5 digits if more digits exist
          }
        }
        final String formattedText = buffer.toString();
        return TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }),
    ];
  }

  /// customLengthFormatter limits input to a specified maximum length.
  static List<TextInputFormatter> customLengthFormatter(int maxLength) {
    return [
      LengthLimitingTextInputFormatter(maxLength),
    ];
  }

  /// customRegexFormatter allows input based on a custom regular expression.
  static List<TextInputFormatter> customRegexFormatter(String pattern) {
    return [
      FilteringTextInputFormatter.allow(RegExp(pattern)),
    ];
  }

  /// noSpecialCharacterFormatter prevents special characters.
  static List<TextInputFormatter> noSpecialCharacterFormatter() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
    ];
  }

  /// noEmojiFormatter prevents emoji characters.
  static List<TextInputFormatter> noEmojiFormatter() {
    return [
      FilteringTextInputFormatter.deny(RegExp(r'\p{Emoji}')),
    ];
  }

  /// noWhitespaceFormatter prevents all whitespace characters.
  static List<TextInputFormatter> noWhitespaceFormatter() {
    return [
      FilteringTextInputFormatter.deny(RegExp(r'\s')),
    ];
  }

  /// noNumbersFormatter prevents numeric input.
  static List<TextInputFormatter> noNumbersFormatter() {
    return [
      FilteringTextInputFormatter.deny(RegExp(r'\d')),
    ];
  }

  /// noAlphabetsFormatter prevents alphabetic input.
  static List<TextInputFormatter> noAlphabetsFormatter() {
    return [
      FilteringTextInputFormatter.deny(RegExp(r'[a-zA-Z]')),
    ];
  }

  /// drivingLicenseFormatter formats input as a driving license number (e.g., XX-00-00-000000-000000).
  static List<TextInputFormatter> drivingLicenseFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        String newText = newValue.text.replaceAll(RegExp(r'\s+\b|\b\s'), '');
        if (newText.length > 15) {
          newText = newText.substring(0, 15);
        }
        final StringBuffer buffer = StringBuffer();
        for (int i = 0; i < newText.length; i++) {
          buffer.write(newText[i]);
          final int index = i + 1;
          if ((index == 2 || index == 4 || index == 6 || index == 12) &&
              index != newText.length) {
            buffer.write('-'); // Add hyphen at specific positions
          }
        }
        final String formattedText = buffer.toString();
        return TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }),
    ];
  }

  /// vehicleNumberFormatter formats input as a vehicle number (e.g., XX00XX0000).
  static List<TextInputFormatter> vehicleNumberFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        String newText =
            newValue.text.toUpperCase().replaceAll(RegExp(r'\s+\b|\b\s'), '');
        if (newText.length > 10) {
          newText = newText.substring(0, 10);
        }
        final StringBuffer buffer = StringBuffer();
        for (int i = 0; i < newText.length; i++) {
          if (i < 2) {
            // First 2 characters should be alphabets
            if (RegExp(r'[A-Z]').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          } else if (i < 4) {
            // Next 2 characters should be digits
            if (RegExp(r'\d').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          } else if (i < 6) {
            // Next 2 characters should be alphabets
            if (RegExp(r'[A-Z]').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          } else {
            // Last 4 characters should be digits
            if (RegExp(r'\d').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          }
        }
        final String formattedText = buffer.toString();
        return TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }),
    ];
  }

  /// voterIdFormatter formats input as a voter ID (e.g., ABCD1234567).
  static List<TextInputFormatter> voterIdFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        String newText =
            newValue.text.toUpperCase().replaceAll(RegExp(r'\s+\b|\b\s'), '');
        if (newText.length > 10) {
          newText = newText.substring(0, 10);
        }
        final StringBuffer buffer = StringBuffer();
        for (int i = 0; i < newText.length; i++) {
          if (i < 3) {
            // First 3 characters should be alphabets
            if (RegExp(r'[A-Z]').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          } else if (i < 9) {
            // Next 6 characters should be digits
            if (RegExp(r'\d').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          } else {
            // Last character should be an alphabet
            if (RegExp(r'[A-Z]').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          }
        }
        final String formattedText = buffer.toString();
        return TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }),
    ];
  }

  /// ifscFormatter formats input as an IFSC code (e.g., ABCD0123456).
  static List<TextInputFormatter> ifscFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        String newText =
            newValue.text.toUpperCase().replaceAll(RegExp(r'\s+\b|\b\s'), '');
        if (newText.length > 11) {
          newText = newText.substring(0, 11);
        }
        final StringBuffer buffer = StringBuffer();
        for (int i = 0; i < newText.length; i++) {
          if (i < 4) {
            // First 4 characters should be alphabets
            if (RegExp(r'[A-Z]').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          } else if (i == 4) {
            // 5th character should be '0'
            if (newText[i] == '0') {
              buffer.write(newText[i]);
            } else {
              break;
            }
          } else {
            // Last 6 characters should be digits
            if (RegExp(r'\d').hasMatch(newText[i])) {
              buffer.write(newText[i]);
            } else {
              break;
            }
          }
        }
        final String formattedText = buffer.toString();
        return TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }),
    ];
  }

  /// indianPhoneNumberFormatter formats input as an Indian phone number (e.g., +91 XXXXX-XXXXX).
  static List<TextInputFormatter> indianPhoneNumberFormatter() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        String newText = newValue.text.replaceAll(RegExp(r'\D'), '');
        if (newText.startsWith('91')) {
          newText = newText.substring(2);
        }
        if (newText.length > 10) {
          newText = newText.substring(0, 10);
        }
        final StringBuffer buffer = StringBuffer();
        buffer.write('+91 ');
        for (int i = 0; i < newText.length; i++) {
          buffer.write(newText[i]);
          if (i == 4 && newText.length > 5) {
            buffer.write(
                '-'); // Add hyphen after first 5 digits if more digits exist
          }
        }
        final String formattedText = buffer.toString();
        return TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }),
    ];
  }

  /// maskedFormatter applies a mask to the input.
  /// Example mask: "****-****-****" where '*' is a placeholder for user input.
  static List<TextInputFormatter> maskedFormatter(String mask,
      {String placeholder = '*'}) {
    final List<TextInputFormatter> formatters = [];
    String formattedMask = '';
    int placeholderCount = 0; // Count of placeholder characters
    for (int i = 0; i < mask.length; i++) {
      final String char = mask[i];
      if (char == placeholder) {
        placeholderCount++;
        formattedMask += char;
      } else {
        formattedMask += char;
      }
    }
    formatters.add(FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')));
    formatters.add(TextInputFormatter.withFunction((oldValue, newValue) {
      String newText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
      if (newText.length > placeholderCount) {
        newText = newText.substring(0, placeholderCount);
      }
      final StringBuffer buffer = StringBuffer();
      int textIndex = 0;
      for (int i = 0; i < formattedMask.length; i++) {
        if (formattedMask[i] == placeholder) {
          if (textIndex < newText.length) {
            buffer.write(newText[textIndex]);
            textIndex++;
          } else {
            break;
          }
        } else {
          buffer.write(formattedMask[i]);
        }
      }
      final String formattedText = buffer.toString();
      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }));
    return formatters;
  }

  
}

// Add this enum at the top of the file, outside the InputFormatter class
enum FormatterEnum {
  ddMMyyyy, // DD-MM-YYYY
  mmDDyyyy, // MM-DD-YYYY
  yyyyMMdd, // YYYY-MM-DD
  ddMMyy, // DD-MM-YY
  mmDDyy, // MM-DD-YY
  ddMMyyyyhhmm, // DD-MM-YYYY HH:MM
  mmDDyyyyhhmm, // MM-DD-YYYY HH:MM
  yyyyMMddhhmm, // YYYY-MM-DD HH:MM
  ddMMyyhhmm, // DD-MM-YY HH:MM
  mmDDyyhhmm, // MM-DD-YY HH:MM
  hhmmDDMMYYYY, // HH:MM DD-MM-YYYY
  hhmmMMDDYYYY, // HH:MM MM-DD-YYYY
  hhmmYYYYMMDD, // HH:MM YYYY-MM-DD
  hhmmDDMMYY, // HH:MM DD-MM-YY
  hhmmMMDDYY, // HH:MM MM-DD-YY
  hhmmYYYYMMYY, // HH:MM YYYY-MM-YY
  hhmmssDDMMYYYY, // HH:MM:SS DD-MM-YYYY
  hhmmssMMDDYYYY, // HH:MM:SS MM-DD-YYYY
  hhmmssYYYYMMDD, // HH:MM:SS YYYY-MM-DD
  hhmmssDDMMYY, // HH:MM:SS DD-MM-YY
  hhmmssMMDDYY, // HH:MM:SS MM-DD-YY
  hhmmssYYYYMMYY, // HH:MM:SS YYYY-MM-YY
  ddMMyyyyhhmmss, // DD-MM-YYYY HH:MM:SS
  mmDDyyyyhhmmss, // MM-DD-YYYY HH:MM:SS
  yyyyMMddhhmmss, // YYYY-MM-DD HH:MM:SS
  ddMMyyhhmmss, // DD-MM-YY HH:MM:SS
  mmDDyyhhmmss, // MM-DD-YY HH:MM:SS
  yyyyMMDDhhmmss, // YYYY-MM-YY HH:MM:SS
  hhmmssDDMMYYYY24, // HH:MM:SS DD-MM-YYYY 24 HOUR FORMAT
  hhmmssMMDDYYYY24, // HH:MM:SS MM-DD-YYYY 24 HOUR FORMAT
  hhmmssYYYYMMDD24, // HH:MM:SS YYYY-MM-DD 24 HOUR FORMAT
  hhmmssDDMMYY24, // HH:MM:SS DD-MM-YY 24 HOUR FORMAT
  hhmmssMMDDYY24, // HH:MM:SS MM-DD-YY 24 HOUR FORMAT
  hhmmssYYYYMMYY24, // HH:MM:SS YYYY-MM-YY 24 HOUR FORMAT
  ddMMyyyyhhmmss24, // DD-MM-YYYY HH:MM:SS 24 HOUR FORMAT
  mmDDyyyyhhmmss24, // MM-DD-YYYY HH:MM:SS 24 HOUR FORMAT
  yyyyMMddhhmmss24, // YYYY-MM-DD HH:MM:SS 24 HOUR FORMAT
  ddMMyyhhmmss24, // DD-MM-YY HH:MM:SS 24 HOUR FORMAT
  mmDDyyhhmmss24, // MM-DD-YY HH:MM:SS 24 HOUR FORMAT
  yyyyMMDDhhmmss24, // YYYY-MM-YY HH:MM:SS  24 HOUR FORMAT
}

// Add this extension to get the format string from the enum
extension FormatterEnumExtension on FormatterEnum {
  String get formatString {
    switch (this) {
      case FormatterEnum.ddMMyyyy:
        return 'DD-MM-YYYY';
      case FormatterEnum.mmDDyyyy:
        return 'MM-DD-YYYY';
      case FormatterEnum.yyyyMMdd:
        return 'YYYY-MM-DD';
      case FormatterEnum.ddMMyy:
        return 'DD-MM-YY';
      case FormatterEnum.mmDDyy:
        return 'MM-DD-YY';
      case FormatterEnum.ddMMyyyyhhmm:
        return 'DD-MM-YYYY HH:MM';
      case FormatterEnum.mmDDyyyyhhmm:
        return 'MM-DD-YYYY HH:MM';
      case FormatterEnum.yyyyMMddhhmm:
        return 'YYYY-MM-DD HH:MM';
      case FormatterEnum.ddMMyyhhmm:
        return 'DD-MM-YY HH:MM';
      case FormatterEnum.mmDDyyhhmm:
        return 'MM-DD-YY HH:MM';
      case FormatterEnum.yyyyMMDDhhmmss24:
        return 'YYYY-MM-DD HH:MM:SS';
      case FormatterEnum.hhmmDDMMYYYY:
        return 'HH:MM DD-MM-YYYY';
      case FormatterEnum.hhmmssYYYYMMYY:
        return 'HH:MM:SS YYYY-MM-YY';
      case FormatterEnum.hhmmMMDDYYYY:
        return 'HH:MM MM-DD-YYYY';
      case FormatterEnum.hhmmssDDMMYY:
        return 'HH:MM:SS DD-MM-YY';
      case FormatterEnum.hhmmYYYYMMDD:
        return 'HH:MM YYYY-MM-DD';
      case FormatterEnum.hhmmssMMDDYY:
        return 'HH:MM:SS MM-DD-YY';
      case FormatterEnum.hhmmssDDMMYYYY:
        return 'HH:MM:SS DD-MM-YYYY';
      case FormatterEnum.hhmmssMMDDYYYY:
        return 'HH:MM:SS MM-DD-YYYY';
      case FormatterEnum.hhmmssYYYYMMDD:
        return 'HH:MM:SS YYYY-MM-DD';
      case FormatterEnum.hhmmssDDMMYY24:
        return 'HH:MM:SS DD-MM-YY';
      case FormatterEnum.hhmmssYYYYMMYY24:
        return 'HH:MM:SS YYYY-MM-YY';
      case FormatterEnum.hhmmssDDMMYYYY24:
        return 'HH:MM:SS DD-MM-YYYY';
      case FormatterEnum.hhmmssMMDDYYYY24:
        return 'HH:MM:SS MM-DD-YYYY';
      case FormatterEnum.hhmmssYYYYMMDD24:
        return 'HH:MM:SS YYYY-MM-DD';
      case FormatterEnum.hhmmssMMDDYY24:
        return 'HH:MM:SS MM-DD-YY';
      case FormatterEnum.ddMMyyyyhhmmss:
        return 'DD-MM-YYYY HH:MM:SS';
      case FormatterEnum.mmDDyyyyhhmmss:
        return 'MM-DD-YYYY HH:MM:SS';
      case FormatterEnum.yyyyMMddhhmmss:
        return 'YYYY-MM-DD HH:MM:SS';
      case FormatterEnum.ddMMyyhhmmss:
        return 'DD-MM-YY HH:MM:SS';
      case FormatterEnum.mmDDyyhhmmss:
        return 'MM-DD-YY HH:MM:SS';
      case FormatterEnum.yyyyMMDDhhmmss:
        return 'YYYY-MM-YY HH:MM:SS';
      case FormatterEnum.ddMMyyhhmmss24:
        return 'DD-MM-YY HH:MM:SS';
      case FormatterEnum.mmDDyyhhmmss24:
        return 'MM-DD-YY HH:MM:SS';
      default:
        return 'DD-MM-YYYY';
    }
  }
}
