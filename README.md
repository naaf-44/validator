<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A flutter package for both Android and iOS which provides the validation functionalities for the input fields.

## Features

Provides validation for the input types 
    1. text
    2. password
    3. email
    4. phone
    5. url

## Getting started

Add the ```text_field_validator``` package into pubspec.yaml file start working.
import the package as ```import 'package:text_field_validator/text_field_validator.dart';```

## Usage

```import 'package:flutter/material.dart';
import 'package:text_field_validator/text_field_validator.dart';

class ValidatorTest extends StatefulWidget {
    const ValidatorTest({Key? key}) : super(key: key);

    @override
    State<ValidatorTest> createState() => _ValidatorTestState();
}

class _ValidatorTestState extends State<ValidatorTest> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(),
            body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                    child: Column(
                        children: [
                            TextFormField(
                                validator: (value) {
                                    return TextFieldValidator.textValidator(
                                        value: value,
                                    );
                                },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                                validator: (value) {
                                    return TextFieldValidator.passWordValidator(
                                        password: value,
                                    );
                                },
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
```

## Added Input Formatters

### 1. Date and Time Input Formatter

- **New Enum:**  
  Added `FormatterEnum` to specify common date and time formats (e.g., `DD-MM-YYYY`, `YYYY-MM-DD HH:MM:SS`).

- **Flexible Separators:**  
  The `dateFormatter` now accepts two parameters:  
  - `dateSeparator` (e.g., `-`, `/`)  
  - `timeSeparator` (e.g., `:`, `.`)  
  This allows you to customize the format for both date and time parts.

- **Supports Date & Time:**  
  The formatter supports both date and time fields, handling patterns with `D`, `M`, `Y`, `H`, and `S` (for day, month, year, hour, second).

- **Usage Example:**
  ```dart
  inputFormatters: InputFormatter.dateFormatter(
    FormatterEnum.ddMMyyyyhhmmss,
    dateSeparator: '/',
    timeSeparator: '.',
  )
  // Result: DD/MM/YYYY HH.MM.SS
  ```

## Input Formatters

This package provides a variety of input formatters for Flutter `TextFormField` and `TextField` widgets, making it easy to restrict and format user input.

### Available Formatters

#### 1. Number Formatter
Allows only numeric input (digits only).
```dart
inputFormatters: InputFormatter.numberFormatter(),
```

#### 2. Decimal Formatter
Allows numeric input with decimal points, useful for prices or measurements.
```dart
inputFormatters: InputFormatter.decimalFormatter(decimalRange: 2),
```

#### 3. Alphabet Formatter
Allows only alphabetic input (letters only).
```dart
inputFormatters: InputFormatter.alphabetFormatter(),
```

#### 4. Alphanumeric Formatter
Allows only alphanumeric input (letters and digits).
```dart
inputFormatters: InputFormatter.alphaNumericFormatter(),
```

#### 5. Upper Case Formatter
Allows only upper-case alphabetic input.
```dart
inputFormatters: InputFormatter.upperCaseFormatter(),
```

#### 6. Lower Case Formatter
Allows only lower-case alphabetic input.
```dart
inputFormatters: InputFormatter.lowerCaseFormatter(),
```

#### 7. No Leading Space Formatter
Prevents leading spaces in the input.
```dart
inputFormatters: InputFormatter.noLeadingSpaceFormatter(),
```

#### 8. No Double Space Formatter
Prevents occurrence of double spaces in the input.
```dart
inputFormatters: InputFormatter.noDoubleSpaceFormatter(),
```

#### 9. Capitalize First Letter Formatter
Capitalizes the first letter of the input string.
```dart
inputFormatters: InputFormatter.capitalizeFirstLetterFormatter(),
```

#### 10. Credit Card Number Formatter
Formats input to ensure it matches the structure of a credit card number (e.g., 1234-5678-9012-3456).
```dart
inputFormatters: InputFormatter.creditCardNumberFormatter(),
```

#### 11. Phone Number Formatter
Formats the input to ensure it matches the structure of a phone number, including optional country code.
```dart
inputFormatters: InputFormatter.phoneNumberFormatter(),
```

#### 12. Custom Pattern Formatter
Allows input formatting based on a custom pattern, where `X` represents a required digit.
```dart
inputFormatters: InputFormatter.customPatternFormatter('XXX-XXX-XXXX'),
```

