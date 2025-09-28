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

```
Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Center(
        child: ListView(
            children: <Widget>[
            Text("Validators",
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            TextFormField(
                validator: (value) {
                    return TextFieldValidator.textValidator(
                    value: value,
                    minLength: 2,
                    maxLength: 5,
                    );
                },
                autovalidateMode: AutovalidateMode.onUserInteraction),
            const SizedBox(height: 20),
            TextFormField(
                validator: (value) {
                return TextFieldValidator.passWordValidator(
                    password: value,
                    minPasswordLength: 8,
                );
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            TextFormField(
                validator: (value) {
                return TextFieldValidator.urlValidator(
                    url: value,
                );
                },
                keyboardType: TextInputType.url,
                autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 30),
            Text("Input Formatters",
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Adhar Input Formatter'),
                inputFormatters: InputFormatter.adharFormatter()),
            const SizedBox(height: 20),
            TextFormField(
                decoration:
                    const InputDecoration(labelText: 'PAN Input Formatter'),
                inputFormatters: InputFormatter.panFormatter(),
            ),
            const SizedBox(height: 20),
            TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Date Input Formatter'),
                inputFormatters: InputFormatter.dateFormatter(
                FormatterEnum.hhmmssMMDDYYYY24,
                ),
            ),
            const SizedBox(height: 20),
            TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Alphabet Input Formatter'),
                inputFormatters: InputFormatter.alphabetFormatter(),
            ),
            const SizedBox(height: 20),
            TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Credit Card Formatter'),
                keyboardType: TextInputType.number,
                inputFormatters: InputFormatter.creditCardNumberFormatter(),
            ),
            const SizedBox(height: 20),
            TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Phone Number Formatter'),
                keyboardType: TextInputType.phone,
                inputFormatters: InputFormatter.phoneNumberFormatter(),
            ),
            const SizedBox(height: 20),
            TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Decimal Number Formatter'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: InputFormatter.decimalFormatter(),
            ),
            const SizedBox(height: 20),
            TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Integer Number Formatter'),
                keyboardType: TextInputType.number,
                inputFormatters: InputFormatter.numberFormatter(),
            ),
            ],
        ),
    ),
),
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

#### 1. Aadhaar Formatter
Formats input as an Aadhaar number (e.g., `XXXX XXXX XXXX`).
```dart
inputFormatters: InputFormatter.adharFormatter(),
```

#### 2. PAN Formatter
Formats input as a PAN (Permanent Account Number) in the structure: `AAAAA9999A`.
```dart
inputFormatters: InputFormatter.panFormatter(),
```

#### 3. IFSC Code Formatter
Formats input as an IFSC (Indian Financial System Code) code, typically used for Indian bank branches.
```dart
inputFormatters: InputFormatter.ifscFormatter(),
```

#### 4. Number Formatter
Allows only numeric input (digits only).
```dart
inputFormatters: InputFormatter.numberFormatter(),
```

#### 5. Decimal Formatter
Allows numeric input with decimal points, useful for prices or measurements.
```dart
inputFormatters: InputFormatter.decimalFormatter(decimalRange: 2),
```

#### 6. Alphabet Formatter
Allows only alphabetic input (letters only).
```dart
inputFormatters: InputFormatter.alphabetFormatter(),
```

#### 7. Alphanumeric Formatter
Allows only alphanumeric input (letters and digits).
```dart
inputFormatters: InputFormatter.alphaNumericFormatter(),
```

#### 8. Upper Case Formatter
Allows only upper-case alphabetic input.
```dart
inputFormatters: InputFormatter.upperCaseFormatter(),
```

#### 9. Lower Case Formatter
Allows only lower-case alphabetic input.
```dart
inputFormatters: InputFormatter.lowerCaseFormatter(),
```

#### 10. No Leading Space Formatter
Prevents leading spaces in the input.
```dart
inputFormatters: InputFormatter.noLeadingSpaceFormatter(),
```

#### 11. No Double Space Formatter
Prevents occurrence of double spaces in the input.
```dart
inputFormatters: InputFormatter.noDoubleSpaceFormatter(),
```

#### 12. Capitalize First Letter Formatter
Capitalizes the first letter of the input string.
```dart
inputFormatters: InputFormatter.capitalizeFirstLetterFormatter(),
```

#### 13. Credit Card Number Formatter
Formats input to ensure it matches the structure of a credit card number (e.g., 1234-5678-9012-3456).
```dart
inputFormatters: InputFormatter.creditCardNumberFormatter(),
```

#### 14. Phone Number Formatter
Formats the input to ensure it matches the structure of a phone number, including optional country code.
```dart
inputFormatters: InputFormatter.phoneNumberFormatter(),
```

#### 15. Custom Pattern Formatter
Allows input formatting based on a custom pattern, where `X` represents a required digit.
```dart
inputFormatters: InputFormatter.customPatternFormatter('XXX-XXX-XXXX'),
```

